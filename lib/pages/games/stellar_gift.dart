// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '/widget/page_header.dart';

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
            PageHeader(title: 'Stellar Gift'),
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