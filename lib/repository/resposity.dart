import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter_app_weather/api/request/request.dart';
import 'package:flutter_app_weather/base/resource.dart';
import 'package:flutter_app_weather/model/weatherModel.dart';
import 'package:flutter_app_weather/model/weather_model.dart';
import 'package:http/http.dart' as http;

class Resposity {
  late Request _request;

  Resposity(Request request) {
    _request = request;
  }

  // Future<Resource<WeatherModel>> getTempCity(String cityName) async {
  //   Completer<Resource<WeatherModel>> completer = Completer();
  //   completer.complete(const Resource.loading());
  //   try {
  //     Response reponse = await _request.temCityRequest(cityName);
  //     if (reponse.statusCode == 200) {
  //       WeatherModel weather = WeatherModel.fromJson(reponse.data);
  //       completer.complete(Resource.success(weather));
  //     }
  //   } on DioException catch (error) {
  //     if (error.response != null) {
  //       if (error.response!.statusCode == 404) {
  //         print("Dio ${error.response!.data['message']}");
  //         completer.completeError(Resource.error(error.response!.data['message']));
  //       }
  //     }
  //   } catch (e) {
  //     completer.completeError(Resource.error(e.toString()));
  //   }

  //   return completer.future;
  // }

  Future<WeatherModel> getTempCity(String cityName) async {
    Completer<WeatherModel> completer = Completer();
    Response response = await _request.temCityRequest(cityName);
    if (response.statusCode == 200) {
      completer.complete(WeatherModel.fromJson(response.data));
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    return completer.future;
  }
}
