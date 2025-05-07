// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import '/common/eventbus.dart';
import '/controller/user.dart';
import './home.dart';
import './games.dart';
import './bgdge.dart';
import './profile.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    UserController.init();
    if (UserController.first.value != false) {
      Utils.welcomeBonus(context);
    }
    bus.on('tabChange', (index) => onTabChanged(index));
  }

  /// Tab 改变
  void onTabChanged(int index) {
    setState(() {
      if (currentIndex != index) {
        currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: currentIndex,
            children: [
              HomePage(),
              GamesPage(),
              BadgePage(),
              ProfilePage()
            ],
          ),
          TabbarBox()
        ],
      ),
    );
  }

  Widget TabbarBox() {
    return Positioned(child: Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color(0xFF191919),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabbarItem(icon: 'home', text: 'Home', index: 0),
          TabbarItem(icon: 'games', text: 'Games', index: 1),
          TabbarItem(icon: 'badge', text: 'Badge', index: 2),
          TabbarItem(icon: 'profile', text: 'Profile', index: 3),
        ],
      )
    ));
  }
  Widget TabbarItem({icon, text, index}) {
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/tabbar/$icon${currentIndex == index ? '_ac' : ''}.png', width: 24),
            SizedBox(height: 4),
            Text('$text', style: TextStyle(color: currentIndex == index ? Color(0xFFFFAA1C) : Color.fromRGBO(255, 255, 255, 0.32), fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
