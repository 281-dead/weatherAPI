import 'package:flutter/material.dart';

Widget OptionWidget(String urlImage, String number, String name) {
  return Container(
    height: 300,
    width: 140,
    decoration: const BoxDecoration(color: Color(0xFFF7F6F7), borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(urlImage, height: 100),
        Text(
          number,
          style: const TextStyle(
            color: Color(0xFF454443),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF454443),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
