import 'package:hive_flutter/hive_flutter.dart';
import 'package:piwot2/services/weatherApiService.dart';
import 'varApiService.dart';

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
        values[scheme['url']] = scheme['Image'][0]['formats']['thumbnail']['url'];
      }
      box.put('schemes', values);
    } catch (e) {
      print('Error syncing schemes: $e');
    }
  }

  Future<void> syncWeatherData() async {
    try {
      var weatherData = await WeatherApiService.fetchWeather(21.145800,79.088158);
      box.put('Weather Data', weatherData);
      print('Weather Data: $weatherData');
    } catch (e) {
      print('Error syncing weather data: $e');
    }
  }

  Future<void> syncData() async {
    try {
      await syncAppFont();
      await syncLightTheme();
      await syncDarkTheme();
      await syncSchemes();
      await syncWeatherData();
      await box.put('Data Sync', true);
    } catch (e) {
      print('Error syncing data: $e');
    }
  }
}
