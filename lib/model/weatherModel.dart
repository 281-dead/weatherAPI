import 'package:flutter_app_weather/model/main_model.dart';
import 'package:flutter_app_weather/model/sys_model.dart';
import 'package:flutter_app_weather/model/weather_model.dart';
import 'package:flutter_app_weather/model/win_model.dart';

class WeatherModel {
  List<Weather>? weather;
  Main? main;
  int? visibility;
  Wind? wind;
  Sys? sys;
  String? name;

  WeatherModel({this.weather, this.main, this.visibility, this.wind, this.sys, this.name});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    weather = json["weather"] == null ? null : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
    main = json["main"] == null ? null : Main.fromJson(json["main"]);
    visibility = json["visibility"];
    wind = json["wind"] == null ? null : Wind.fromJson(json["wind"]);
    sys = json["sys"] == null ? null : Sys.fromJson(json["sys"]);
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weather != null) {
      data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    if (main != null) {
      data["main"] = main?.toJson();
    }
    data["visibility"] = visibility;
    if (wind != null) {
      data["wind"] = wind?.toJson();
    }
    if (sys != null) {
      data["sys"] = sys?.toJson();
    }
    data["name"] = name;
    return data;
  }

  @override
  String toString() {
    return 'WeatherModel{weather: $weather, main: $main, visibility: $visibility, wind: $wind, sys: $sys, name: $name}';
  }
}
