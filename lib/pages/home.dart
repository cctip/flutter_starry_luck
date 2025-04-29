// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/sense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SenseController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF1F5F9),
      child: Column(
        children: [
          HeaderBox(),
          ContentBox()
        ],
      ),
    );
  }

  Widget HeaderBox() {
    return Container(
      height: 100,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Get.toNamed('/galactic_hand');
                },
                child: Text('Galactic Hand', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Get.toNamed('/nebula_rush');
                },
                child: Text('Nebula Rush', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Get.toNamed('/stellar_gift');
                },
                child: Text('Stellar Gift', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Get.toNamed('/frostflare');
                },
                child: Text('Frostflare', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Get.toNamed('/starflare');
                },
                child: Text('Starflare', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF15171C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Get.toNamed('/quest_roll');
                },
                child: Text('Quest Roll', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ),
            ]
          ),
        ),
      )
    ]));
  }
}