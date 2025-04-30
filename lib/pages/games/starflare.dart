// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/widget/detail_header.dart';

class Starflare extends StatefulWidget {
  const Starflare({super.key});

  @override
  State<Starflare> createState() => StarflareState();
}

class StarflareState extends State<Starflare> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Starflare', rule: 'starflare'),
            ContentBox(),
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container();
  }
}