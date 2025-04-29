// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '/widget/page_header.dart';

class Frostflare extends StatefulWidget {
  const Frostflare({super.key});

  @override
  State<Frostflare> createState() => FrostflareState();
}

class FrostflareState extends State<Frostflare> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            PageHeader(title: 'Frostflare'),
            ContentBox(),
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 540,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/game_frostflare/bg.png'), fit: BoxFit.cover)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: List.generate(24, (index) => Container(
              width: 118,
              height: 48,
              child: Image.asset('assets/images/game_frostflare/blind_box.png'),
            )),
          ),
          SizedBox(height: 32)
        ]
      ),
    );
  }
}