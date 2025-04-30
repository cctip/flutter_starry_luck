// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/widget/detail_header.dart';

class StellarGift extends StatefulWidget {
  const StellarGift({super.key});

  @override
  State<StellarGift> createState() => StellarGiftState();
}

class StellarGiftState extends State<StellarGift> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Stellar Gift', rule: 'stellar_gift'),
            ContentBox(),
            DataBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 540,
      padding: EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/game_stellar_gift/bg.png'), fit: BoxFit.cover)
      ),
      child: Column(children: [
        Image.asset('assets/images/game_stellar_gift/cambo_border.png', height: 59),
        SizedBox(height: 16),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: List.generate(25, (index) => Container(
            width: 70,
            height: 70,
            child: Image.asset('assets/images/game_stellar_gift/blind_box.png'),
          )),
        )
      ]),
    );
  }

  Widget DataBox() {
    return Expanded(child: Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Color(0xFF212121),
      child: Column(children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
        )
      ])
    ));
  }
}