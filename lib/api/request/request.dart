import 'package:dio/dio.dart';
import 'package:flutter_app_weather/api/dio_client.dart';

class Request {
  late Dio _dio;

  Request() {
    _dio = DioClient.instance.dio;
  }

  Future temCityRequest(String cityName) {
    return _dio.get('/data/2.5/weather', queryParameters: {"q": cityName, "appid": "195b2e9d03f5250e8f3b4d58561a2f32", "units": "metric"});
  }
}
