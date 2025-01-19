import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart' as http;

class VarApiService {
  static var client = http.Client();
  static var server_url =
      '${DotEnv.dotenv.env['HOST']}:${DotEnv.dotenv.env['PORT']}';
  static var token = DotEnv.dotenv.env['VAR_API_TOKEN'];

  static Future<dynamic> getFont() async {
    try {
      var uri = Uri.http(server_url, '/api/app-font');
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error getting user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  static Future<dynamic> getLightTheme() async {
    try {
      var uri = Uri.http(server_url, '/api/light-theme');
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error getting user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  static Future<dynamic> getDarkTheme() async {
    try {
      var uri = Uri.http(server_url, '/api/dark-theme');
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error getting user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  static Future<dynamic> getSchemes() async {
    try {
      var queryParams = {'populate': '*'};
      var uri = Uri.http(server_url, '/api/schemes', queryParams);
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error getting user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  static Future<dynamic> getFertilizers() async {
    try {
      var uri = Uri.http(server_url, '/api/fertilizers',);
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error getting user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }
}
