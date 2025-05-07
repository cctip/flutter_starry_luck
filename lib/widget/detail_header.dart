import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'user_card.dart';

class DetailHeader extends StatefulWidget {
  const DetailHeader({super.key, required this.title, required this.rule});
  final String title;
  final String rule;

  @override
  State<DetailHeader> createState() => DetailHeaderState();
}

class DetailHeaderState extends State<DetailHeader> {
  // 规则
  _showRule() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => ZoomIn(child: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            height: 600,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 32),
            decoration: BoxDecoration(
              color: Color(0xFF212121),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
            ),
            child: Column(
              children: [
                Image.asset('assets/images/rules/slider.png'),
                Image.asset('assets/images/rules/${widget.rule}.png'),
              ],
            ),
          ),
        ),
      ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF191919),
      child: Container(
        height: 64 + MediaQuery.of(context).padding.top,
        padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top),
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
            Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(width: 4),
            GestureDetector(
              onTap: _showRule,
              child: Container(
                width: 24,
                height: 24,
                color: Colors.transparent,
                padding: EdgeInsets.all(4),
                child: Image.asset('assets/icons/icon_info.png', width: 16),
              )
            ),
            Spacer(),
            UserCard()
          ],
        ),
      )
    );
  }
}