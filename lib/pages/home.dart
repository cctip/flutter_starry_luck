// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widget/page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

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
              Image.asset('assets/images/bg/subtitle_top.png', height: 20),
              SizedBox(height: 10),
              GameItem('galactic_hand', width: MediaQuery.of(context).size.width),
              SizedBox(height: 20),
              Image.asset('assets/images/bg/subtitle_hot.png', height: 20),
              SizedBox(height: 10),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: Wrap(
                        spacing: 10,
                        children: [
                          GameItem('nebula_rush'),
                          GameItem('stellar_gift'),
                          GameItem('frostflare'),
                          GameItem('starflare'),
                          GameItem('quest_roll'),
                        ],
                      )
                    )
                  );
                }
              ),
            ]
          ),
        ),
      )
    ]));
  }
  Widget GameItem(name, { width }) {
    return GestureDetector(
      onTap: () => Get.toNamed('/$name'),
      child: Image.asset('assets/images/bg/game_$name.png', width: (width ?? 112) / 1)
    );
  }
}