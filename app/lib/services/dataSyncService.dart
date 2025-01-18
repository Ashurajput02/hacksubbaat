
import 'package:hive_flutter/hive_flutter.dart';
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

  Future<void> syncCollege() async {
    try {
      var college = await VarApiService.getCollege();
      var colleges = college['data'] as List;
      var values = colleges.map((college) {
        var value = Map.from(college);
        value.remove('id');
        value.remove('documentId');
        value.remove('createdAt');
        value.remove('updatedAt');
        value.remove('publishedAt');
        return value;
      }).toList();
      box.put('College', values);
    } catch (e) {
      print('Error syncing college: $e');
    }
  }
  Future<void> syncData() async {
    try {
      await syncAppFont();
      await syncLightTheme();
      await syncDarkTheme();
      await syncCollege();
      await box.put('Data Sync', true);
    } catch (e) {
      print('Error syncing data: $e');
    }
  }
}
