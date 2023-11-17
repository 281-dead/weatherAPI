import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_weather/api/request/request.dart';
import 'package:flutter_app_weather/base/resource.dart';
import 'package:flutter_app_weather/model/weatherModel.dart';
import 'package:flutter_app_weather/model/weather_model.dart';
import 'package:flutter_app_weather/repository/resposity.dart';
import 'package:flutter_app_weather/weatherApi.dart';
import 'package:flutter_app_weather/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_weather/widget/image.dart';

class Weather_home_page extends StatefulWidget {
  const Weather_home_page({super.key});

  static Weather_home_page of(BuildContext context) {
    return context.findAncestorWidgetOfExactType()!;
  }

  @override
  State<Weather_home_page> createState() => _Weather_home_pageState();
}

class _Weather_home_pageState extends State<Weather_home_page> {
  final TextEditingController textCountry = TextEditingController();
  late Request request;
  late Resposity reposity;
  late Completer<Resource<WeatherModel>> completer;
  late WeatherModel weather;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    request = Request();
    reposity = Resposity(request);
  }

  @override
  void dispose() {
    textCountry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sizeTextH1 = MediaQuery.of(context).size.width / 10.5;

    Widget temCity(WeatherModel weather) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${weather.main!.temp}',
            style: const TextStyle(
              color: Color(0xFFFFDD77),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: '${weather.name}, ',
                style: TextStyle(
                  color: Colors.amber[900]!.withOpacity(0.7),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: weather.sys!.country,
                style: TextStyle(
                  color: Colors.amber[900]!.withOpacity(0.7),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image.imgCloude,
                //height: 50,
              ),
              const SizedBox(width: 20),
              Text(
                '${weather.weather?[0].description}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget detaiWidget(WeatherModel weather) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OptionWidget(image.imgDoC, weather.main!.humidity.toString(), 'Humidity'),
          OptionWidget(image.imgWind, weather.wind!.speed.toString(), 'Wind'),
          OptionWidget(image.imgAS, weather.main!.pressure.toString(), 'Air pressure'),
        ],
      );
    }

    Widget optionWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFDC8159),
            ),
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                '℃',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFDABD6A),
            ),
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'F',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF96C0E3),
                Color(0xFF24384A),
              ],
            ),
          ),
          child: FutureBuilder<WeatherModel>(
              future: reposity.getTempCity('hanoi'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('He thong dang su co'),
                  );
                } else if (snapshot.hasData) {
                  WeatherModel weather = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Weather App",
                          style: TextStyle(color: const Color(0xFFF1DB74), fontSize: sizeTextH1, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      searchBox(context, textCountry),
                      const SizedBox(height: 30.0),
                      Expanded(
                        flex: 3,
                        child: temCity(weather),
                      ),
                      Expanded(
                        flex: 4,
                        child: detaiWidget(weather),
                      ),
                      Expanded(
                        flex: 1,
                        child: optionWidget(),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                    backgroundColor: Colors.pinkAccent,
                  ),
                );
              }),
        ),
      ),
    );
  }
}

Widget searchBox(context, TextEditingController controller) {
  return TextField(
    textAlignVertical: TextAlignVertical.center,
    //key: key,
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      hintText: 'Seach country name.....',
      suffixIcon: IconButton(
        onPressed: () {
          //
        },
        icon: const Icon(
          Icons.search,
          color: Color(0xFF929CA3),
          size: 27,
        ),
      ),
    ),
    //autovalidateMode: AutovalidateMode.onUserInteraction,
    maxLines: 1,
  );
}
