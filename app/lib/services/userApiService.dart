import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart' as http;

class UserApiService {
  static var client = http.Client();
  static var server_url = '${DotEnv.dotenv.env['HOST']}:${DotEnv.dotenv.env['PORT']}';
  static var token = DotEnv.dotenv.env['USER_API_TOKEN'];
  
  static Future<dynamic> getUser(String email) async {
    if (token == null) {
      throw Exception('Not authenticated');
    }
    try {
      final api = {'filters[\$and][0][email][\$eq]': email,
                   'populate': '*'};
      var token = DotEnv.dotenv.env['USER_API_TOKEN'];
      var uri = Uri.http(server_url, '/api/users', api);
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } 
      else {
        throw Exception('Error getting user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  static Future<dynamic> createUser(
      String name, String email, String username, String password, bool isFarmer, String phone, String gender,) async {
    try {
      var uri = Uri.http(server_url, '/api/auth/local/register');
      var requestBody = json.encode({
        'email': email,
        'username': username, // Use provided username instead of email
        'password': password,
        'isFarmer': isFarmer, // lowercase field name
        'Phone': phone, // lowercase field name
        'Gender': gender, // lowercase field name
        'Name': name, // lowercase field name
      });
      var response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );


      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        var errorData = json.decode(response.body);
        throw Exception(errorData['error']['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      var uri = Uri.http(server_url, '/api/auth/local');
      var response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'identifier': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        token = data['jwt'];
        return data;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
