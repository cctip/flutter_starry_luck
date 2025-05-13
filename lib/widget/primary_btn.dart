// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget PrimaryBtn({required width, required height, required double radius, required String text, required func}) {
  return Container(
    width: width / 1,
    height: height / 1,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF8743), Color(0xFFFFAA1C)],
        stops: [0.5, 1], // 调整渐变范围
      ),
      borderRadius: BorderRadius.circular(radius)
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        foregroundColor: Colors.white,
        disabledForegroundColor: Color.fromRGBO(255, 255, 255, 0.64),
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: Color(0xFF494949),
        shadowColor: Colors.transparent,
        overlayColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      onPressed: func,
      child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
    ),
  );
}