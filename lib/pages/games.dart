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
  final List _tabList = ['All Games', 'Card Games', 'Casual', 'Strategy'];
  final List _tabIcons = ['all', 'poker', 'casual', 'strategy'];
  final Map _contentMap = {
    'all': ['nebula_rush', 'stellar_gift', 'frostflare', 'starflare', 'quest_roll', 'galactic_hand'],
    'poker': ['nebula_rush', 'galactic_hand'],
    'casual': ['starflare', 'quest_roll'],
    'strategy': ['stellar_gift', 'frostflare'],
  };
  int _curTab = 0;

  _onChoosTab(index) {
    setState(() {
      _curTab = index;
    });
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
              Text('Top Games', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Get.toNamed('/galactic_hand'),
                child: Image.asset('assets/images/bg/game_top.png')
              ),
              Container(
                margin: EdgeInsets.only(top: 24, bottom: 16),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 12,
                        children: List.generate(_tabList.length, (index) => GestureDetector(
                          onTap: () => _onChoosTab(index),
                          child: Container(
                            height: 32,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF313131),
                              borderRadius: BorderRadius.circular(4)
                            ),
                            child: Row(children: [
                              Image.asset('assets/icons/${_tabIcons[index]}${_curTab == index ? '_ac' : ''}.png', width: 16),
                              SizedBox(width: 4),
                              Text(_tabList[index], style: TextStyle(color: Colors.white))
                            ]),
                          ),
                        ))
                      )
                    );
                  }
                )
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: List.generate(_contentMap[_tabIcons[_curTab]].length, (index) => GameItem(_contentMap[_tabIcons[_curTab]][index]))
              ),
              SizedBox(height: 12),
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