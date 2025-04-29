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
    return Container();
  }
}