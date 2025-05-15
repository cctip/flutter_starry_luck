// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
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
          Text('Settings', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget ContentBox() {
    return Expanded(child: Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      child: Column(
        children: [
          linkItem('Contact us', (){
            Utils.toast(context, message: 'regaliarage@gmail.com');
          }),
          SizedBox(height: 8),
          // linkItem('Rate us', (){}),
          SizedBox(height: 40),
          linkItem('Privacy policy', (){
            launchUrl(Uri.parse('https://sites.google.com/view/starryluckk/privacy-policy'));
          }),
          SizedBox(height: 8),
          linkItem('Terms of service', (){
            launchUrl(Uri.parse('https://sites.google.com/view/script-canvas/terms-and-conditions'));
          }),
          Spacer(),
          Text('v 1.0.0', style: TextStyle(color: Colors.white30),)
        ]
      ),
    ));
  }
  Widget linkItem(text, func) {
    return SizedBox(
      height: 58,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Color(0xFF282828),
          overlayColor: Colors.white10,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Manrope')),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
          ],
        ),
      ),
    );
  }
}