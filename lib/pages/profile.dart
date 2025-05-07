// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/controller/user.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => HomePageState();
}

class HomePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      color: Color(0xFFF1F5F9),
      child: Column(
        children: [
          HeaderBox(),
          Expanded(child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingBox()
              ]
            ),
          ))
        ],
      ),
    ));
  }

  Widget HeaderBox() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1D4ED8), Color(0xFF4C1AE2)],
          stops: [0, 1], // 调整渐变范围
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text('Profile', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          SizedBox(
            height: 92,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(56)
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text('Noob101', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, height: 1)),
                        SizedBox(width: 8),
                        Obx(() => Text('Lvl.${UserController.level.value}', style: TextStyle(color: Color(0xFFE2E8F0), fontSize: 16, fontWeight: FontWeight.w700, height: 1))),
                      ]),
                      Container(
                        width: 250,
                        height: 8,
                        margin: EdgeInsets.only(top: 10, bottom: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFF989BEE),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(children: [
                          Container(
                            width: 250 * UserController.xp.value / (UserController.level.value * 1000),
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: 250,
                        child: Row(children: [
                          Obx(() => Text('${UserController.xp.value}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                          Text('/${UserController.level.value * 1000}', style: TextStyle(color: Color(0xFF989BEE), fontWeight: FontWeight.w500)),
                          SizedBox(width: 4),
                          Image.asset('assets/icons/xp.png', width: 16),
                          Spacer(),
                          Obx(() => Text('Lvl.${UserController.level.value+1}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                        ]),
                      )
                    ]
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget DataItem({required String title, required int count}) {
    return Expanded(child: Container(
      padding: EdgeInsets.only(top: 4),
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Text(title, style: TextStyle(color: Color(0xFFA2A6AF), fontSize: 12, fontWeight: FontWeight.w500)),
        Text('$count', style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 20, fontWeight: FontWeight.w900)),
      ]),
    ));
  }

  Widget SettingBox() {
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: TextStyle(color: Color(0xFF15171C), fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: 8),
        Expanded(child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Column(children: [
            linkItem('Privacy Policy', (){
              launchUrl(Uri.parse('https://www.freeprivacypolicy.com/live/41e43b5d-e73e-451f-ac00-5838508ff035'));
            }),
            linkItem('Terms of Services', (){
              launchUrl(Uri.parse('https://www.freeprivacypolicy.com/live/10e585c9-bcf8-4603-a6c0-78274ea108b4'));
            }),
            Container(
              height: 58,
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Version', style: TextStyle(color: Color(0xFF282B32), fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('V1.0.0', style: TextStyle(color: Color(0xFFA2A6AF), fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ]),
        ))
      ]
    ));
  }
  Widget linkItem(text, func) {
    return Container(
      height: 58,
      margin: EdgeInsets.only(top: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          overlayColor: Colors.black,
          shadowColor: Colors.transparent,
          elevation: 0, // 阴影
          backgroundColor: Colors.transparent,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          )
        ),
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(
              color: Color(0xFF282B32),
              fontSize: 16,
              fontWeight: FontWeight.w500
            )),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF282B32))
          ],
        ),
      ),
    );
  }
}