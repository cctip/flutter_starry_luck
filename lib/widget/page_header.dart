import 'package:flutter/material.dart';
import 'user_card.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({super.key});

  @override
  State<PageHeader> createState() => PageHeaderState();
}

class PageHeaderState extends State<PageHeader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF191919),
      child: Container(
        height: 64 + MediaQuery.of(context).padding.top,
        padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top),
        child: Row(children: [
          Image.asset('assets/images/logo_header.png', width: 140),
          Spacer(),
          UserCard()
        ])
      )
    );
  }
}