// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widget/page_header.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => GamesPageState();
}

class GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF212121),
      child: Column(
        children: [
          PageHeader(),
          ContentBox()
        ],
      ),
    );
  }

  Widget ContentBox() {
    return Expanded(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 58 + 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Top Games', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Get.toNamed('/galactic_hand'),
                child: Image.asset('assets/images/bg/game_top.png')
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  GameItem('nebula_rush'),
                  GameItem('stellar_gift'),
                  GameItem('frostflare'),
                  GameItem('starflare'),
                  GameItem('quest_roll'),
                  GameItem('galactic_hand'),
                ],
              ),
              Image.asset('assets/images/bg/stay_tuned.png')
            ]
          ),
        ),
      )
    ]));
  }
  Widget GameItem(name, { width }) {
    return GestureDetector(
      onTap: () => Get.toNamed('/$name'),
      child: Image.asset('assets/images/bg/game_$name.png', width: (width ?? (MediaQuery.of(context).size.width - 48) / 2) / 1)
    );
  }
}