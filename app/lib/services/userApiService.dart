import 'dart:convert';
import 'package:flutter/material.dart';
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
      String name, String email,String username, String password, Image profilePicture, String bio, List<String> skills, int year, String gender,
      bool isOpenToTeams, String college) async {
    try {
      var uri = Uri.http(server_url, '/api/auth/local/register');
      var response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'username': email,
          'password': password,
          'profilePicture': profilePicture,
          'Bio': bio,
          'Skills': skills,
          'Year': year,
          'Gender': gender,
          'isOpenToTeams': isOpenToTeams,
          'College': college,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error creating user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating user: $e');
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
