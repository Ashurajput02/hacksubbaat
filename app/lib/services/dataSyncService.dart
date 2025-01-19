import 'package:hive_flutter/hive_flutter.dart';
import 'package:piwot2/services/weatherApiService.dart';
import 'varApiService.dart';
import 'package:geolocator/geolocator.dart';

class DataSyncService {
  final box = Hive.box('appBox');

  Future<void> syncAppFont() async {
    try {
      var font = await VarApiService.getFont();
      box.put('App Font', font['data']['Name']);
    } catch (e) {
      print('Error syncing font:$e');
    }
  }

  Future<void> syncLightTheme() async {
    try {
      var lightTheme = await VarApiService.getLightTheme();
      var values = Map.from(lightTheme['data']);
      values.remove('id');
      values.remove('documentId');
      values.remove('createdAt');
      values.remove('updatedAt');
      values.remove('publishedAt');
      box.put('Light Theme', values);
    } catch (e) {
      print('Error syncing light theme: $e');
    }
  }

  Future<void> syncDarkTheme() async {
    try {
      var lightTheme = await VarApiService.getDarkTheme();
      var values = Map.from(lightTheme['data']);
      values.remove('id');
      values.remove('documentId');
      values.remove('createdAt');
      values.remove('updatedAt');
      values.remove('publishedAt');
      box.put('Dark Theme', values);
    } catch (e) {
      print('Error syncing light theme: $e');
    }
  }

  Future<void> syncSchemes() async {
    try {
      var schemes = await VarApiService.getSchemes();
      var values = {};
      for (var scheme in schemes['data']) {
        values[scheme['url']] =
            scheme['Image'][0]['formats']['large']['url'];
      }
      box.put('schemes', values);
    } catch (e) {
      print('Error syncing schemes: $e');
    }
  }

  Future<void> syncWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;
      var weatherData =await WeatherApiService.fetchWeather(latitude, longitude);
      List<String> weather = [];
      weather.add(weatherData['current']['condition']['icon']);
      weather.add(weatherData['current']['temp_c'].toString());
      for (var day in weatherData['forecast']['forecastday']) {
        weather.add(day['day']['avgtemp_c'].toString());
      }
      await box.put('Weather Data', weather);

    } catch (e) {
      print('Error syncing weather data: $e');
    }
  }

  Future<void> syncFertilizers() async {
    try {
      var fertilizers = await VarApiService.getFertilizers();
      Map<String, List<String>> phosphorus = {};
      Map<String, List<String>> nitrophosphate = {};
      Map<String, List<String>> potassium = {};
      Map<String, List<String>> dap = {};
      Map<String, List<String>> urea = {};
      for (var i in fertilizers['data']) {
        if (i['Type'] == 'Phosphorus') {
          
          phosphorus[i['Name']] = [i['Name'], i['Price'].toString(), i['Url']];
        } else if (i['Type'] == 'Nitrophosphate') {
          nitrophosphate[i['Name']] = [i['Name'], i['Price'].toString(), i['Url']];
        } else if (i['Type'] == 'Potassium') {
          potassium[i['Name']] = [i['Name'], i['Price'].toString(), i['Url']];
        } else if (i['Type'] == 'DAP') {
          dap[i['Name']] = [i['Name'], i['Price'].toString(), i['Url']];
        } else if (i['Type'] == 'Urea') {
          urea[i['Name']] = [i['Name'], i['Price'].toString(), i['Url']];
        }
      }
      box.put('Phosphorus', phosphorus);
      box.put('Nitrophosphate', nitrophosphate);
      box.put('Potassium', potassium);
      box.put('DAP', dap);
      box.put('Urea', urea);
    } catch (e) {
      print('Error syncing fertilizers: $e');
    }
  }

  Future<void> syncData() async {
    try {
      await box.put('Data Sync', false);
      await syncAppFont();
      await syncLightTheme();
      await syncDarkTheme();
      await syncSchemes();
      await syncWeatherData();
      await syncFertilizers();
      await box.put('Data Sync', true);
    } catch (e) {
      print('Error syncing data: $e');
    }
  }
}
