// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '/widget/page_header.dart';

class NebulaRush extends StatefulWidget {
  const NebulaRush({super.key});

  @override
  State<NebulaRush> createState() => NebulaRushState();
}

class NebulaRushState extends State<NebulaRush> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF212121),
        child: Column(
          children: [
            PageHeader(title: 'Nebula Rush', rule: 'nebula_rush'),
            ContentBox(),
            
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      child: Image.asset('assets/images/game_nebula_rush/table.png'),
    );
  }
}