// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Utils {
  static void toast(BuildContext context, { required message }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 点击内容区域关闭
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(message, style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 24,
              fontWeight: FontWeight.w700
            ))
          ],
        ),
      )
    );
  }
}