import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart' as http;

class WeatherApiService {
  static final String? token = DotEnv.dotenv.env['WEATHER_API_TOKEN'];
  static final client = http.Client();

  static Future<Map<String, dynamic>> fetchWeather(double latitude, double longitude) async {
  try {
    if (token == null) {
      throw Exception('Weather API token not found');
    }

    var baseUrl = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': token,
      'q': '${latitude.toString()},${longitude.toString()}',
      'days': '7',
    });
    final response = await client.get(
      baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error fetching weather data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch weather data: $e');
  }
}
}
