// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/common/eventbus.dart';
import '/controller/user.dart';
import './home.dart';


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
            ],
          ),
          TabbarBox()
        ],
      ),
    );
  }

  Widget TabbarBox() {
    return Positioned(child: Container(
      height: 58 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, left: 12, right: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
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
        width: (MediaQuery.of(context).size.width - 24) / 4,
        height: 58,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/tabbar/$icon${currentIndex == index ? '_ac' : ''}.png', width: 24),
            SizedBox(height: 4),
            Text('$text', style: TextStyle(color: Color(currentIndex == index ? 0xFF282B32 : 0xFFA2A6AF), fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
