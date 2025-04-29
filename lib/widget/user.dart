// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/controller/user.dart';
import 'package:get/get.dart';

Widget UserBox({ required final String theme }) {
  bool light = theme == 'light';
  return Container(
    height: 56,
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/profile');
          },
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(42)
                ),
                child: Image.asset('assets/images/avator/avator_4.png', width: 40),
              ),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Noob101', style: TextStyle(color: light ? Color(0xFF15171C) : Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  Obx(() => Text('Lvl.${UserController.level}', style: TextStyle(color: light ? Color.fromRGBO(21, 23, 28, 0.6) : Color.fromRGBO(255, 255, 255, 0.6), fontSize: 14, fontWeight: FontWeight.w500))),
                ]
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 28,
              padding: EdgeInsets.only(left: 38, right: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: light ? Color(0xFFF1F5F9) : Colors.white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Obx(() => Text('${UserController.xpAll.value}', style: TextStyle(color: Color(0xFF15171C), fontSize: 16, fontWeight: FontWeight.w700)))
            ),
            Positioned(
              left: -1,
              top: -2,
              child: Image.asset('assets/icons/xp.png', width: 32)
            )
          ],
        ),
      ],
    ),
  );
}