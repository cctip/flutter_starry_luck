// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/widget/detail_header.dart';

class QuestRoll extends StatefulWidget {
  const QuestRoll({super.key});

  @override
  State<QuestRoll> createState() => QuestRollState();
}

class QuestRollState extends State<QuestRoll> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Quest Roll', rule: 'quest_roll'),
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