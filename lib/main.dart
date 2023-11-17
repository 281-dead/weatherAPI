import 'package:flutter/material.dart';
import 'package:flutter_app_weather/page/Weather_home_page.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Weather_home_page(),
    );
  }
}
