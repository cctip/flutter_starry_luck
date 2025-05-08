// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/widget/user_card.dart';
import 'package:get/get.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => CheckInPageState();
}

class CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF212121),
        child: Column(
          children: [
            Navbar(),
            ContentBox()
          ],
        ),
      ),
    );
  }

  Widget Navbar() {
    return Container(
      height: 64 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top),
      color: Color(0xFF191919),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 26,
              height: 26,
              color: Colors.transparent,
              padding: EdgeInsets.all(4),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
            )
          ),
          SizedBox(width: 2),
          Text('Daily Check In', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          Spacer(),
          UserCard()
        ],
      ),
    );
  }

  Widget ContentBox() {
    return Expanded(child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/check_in/bg.png'), fit: BoxFit.cover)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 0, child: Image.asset('assets/images/check_in/mask.png', width: MediaQuery.of(context).size.width)),
          Column(
            children: [
              SizedBox(height: 110),
              Image.asset('assets/images/check_in/title.png', height: 60),
              SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/check_in/content.png', height: 280),
                  Positioned(top: 10, child: Image.asset('assets/images/check_in/text_top.png', height: 22)),
                  Positioned(bottom: 12, child: Image.asset('assets/images/check_in/text_bottom.png', height: 14)),
                ],
              ),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 370,
                    height: 62,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF511CFF), Color(0xFFED2DFF)],
                        stops: [0.1, 1], // 调整渐变范围
                      ),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Color.fromRGBO(255, 255, 255, 0.64),
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Color(0xFF494949),
                        overlayColor: Colors.black26,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: (){},
                      child: Text('Free Spin (3)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                    ),
                  )
                ]
              )),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ]
          ),
        ],
      )
    ));
  }
}