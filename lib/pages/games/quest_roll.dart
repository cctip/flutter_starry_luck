// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '/widget/page_header.dart';

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
            PageHeader(title: 'Quest Roll'),
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