import 'dart:convert';

import 'package:flutter_app_weather/model/weatherModel.dart';
import 'package:http/http.dart' as http;

class weatherApi {
  static Future<WeatherModel> getData() async {
    // final String url = "https://api.openweathermap.org/data/2.5/weather?lat=10.7758439&lon=106.7017555&appid=195b2e9d03f5250e8f3b4d58561a2f32&units=metric";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'lat': '10.7758439', 'lon': '106.7017555', 'appid': '195b2e9d03f5250e8f3b4d58561a2f32', 'units': 'metric'});
    var response = await http.get(url);
    final parse = jsonDecode(response.body);
    return WeatherModel.fromJson(parse);
  }
}
