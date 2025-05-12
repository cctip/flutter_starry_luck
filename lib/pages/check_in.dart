// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/user_card.dart';
import 'package:get/get.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => CheckInPageState();
}

class CheckInPageState extends State<CheckInPage> with SingleTickerProviderStateMixin {
  int get _freeCount => UserController.freeCount.value;

  final _scrollControllers = List.generate(3, (_) => ScrollController());
  final List<double> _randomOffsets = [0, 0, 0];
  final List<int> _randomEndIndex = [0, 0, 0];
  late AnimationController _animationController;
  final double _itemHeight = 80;
  bool runing = false;
  int _endingCount = 0;

  @override
  void initState() {
    super.initState();
    setState(() => runing = true);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollControllers.asMap().forEach((index, controller) {
        controller.animateTo(
          274 + MediaQuery.of(context).padding.top,
          duration: Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      });
    });
  }

  // 开始抽奖
  void _startSpin() {
    if (runing) return;
    _animationController.reset();
    setState(() => runing = true);

    // 递归随机数生成
    getRandom(index) {
      int endIndex = (Random().nextInt(20) + 5);
      double randomOffset = endIndex * _itemHeight * 6 - 46 + MediaQuery.of(context).padding.top; // 保证完整滚动圈数
      if (randomOffset > _randomOffsets[index] - 1000 && randomOffset < _randomOffsets[index] + 1000) {
        randomOffset = getRandom(index);
      }
      setState(() {
        _randomEndIndex[index] = endIndex % 5;
        _randomOffsets[index] = randomOffset;
      });
      return randomOffset;
    }
    _scrollControllers.asMap().forEach((index, controller) {
      controller.animateTo(
        getRandom(index),
        duration: Duration(seconds: 3),
        curve: Curves.easeOutQuart,
      );
    });
  }

  // 结束抽奖
  void _endSpin() {
    setState(() {
      _endingCount++;
      if (_endingCount / 3 % 1 == 0 && _endingCount / 3 > 0) {
        runing = false;
      }
    });
    if (runing || _endingCount <= 3) return;

    int rewardIndex = 0;
    if (_countRanks().values.any((count) => count == 3)) {
      rewardIndex = _randomEndIndex[0];
    } else if (_countRanks().values.any((count) => count == 2)) {
      if (_randomEndIndex[0] == _randomEndIndex[1]) {
        rewardIndex = _randomEndIndex[0];
      } else {
        rewardIndex = _randomEndIndex[2];
      }
    } else {
      int reward = _randomEndIndex[0];
      if (_randomEndIndex[1] < reward) {
        reward = _randomEndIndex[1];
      } else if (_randomEndIndex[2] < reward) {
        reward = _randomEndIndex[2];
      }
      rewardIndex = reward;
    }
    int rewardValue = 0;
    switch(rewardIndex) {
      case 0: rewardValue = Random().nextInt(51) + 50; break;
      case 1: rewardValue = Random().nextInt(100) + 101; break;
      case 2: rewardValue = Random().nextInt(100) + 201; break;
      case 3: rewardValue = Random().nextInt(100) + 301; break;
      case 4: rewardValue = Random().nextInt(200) + 401; break;
    }
    Utils.checkReward(context, rewardValue);
  }
  Map _countRanks() {
    final counts = <int, int>{};
    for (final rank in _randomEndIndex) {
      counts[rank] = (counts[rank] ?? 0) + 1;
    }
    return counts;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF212121),
        child: Column(
          children: [
            Navbar(),
            ContentBox()
          ],
        ),
      ),
    );
  }

  Widget Navbar() {
    return Container(
      height: 64 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top),
      color: Color(0xFF191919),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 26,
              height: 26,
              color: Colors.transparent,
              padding: EdgeInsets.all(4),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
            )
          ),
          SizedBox(width: 2),
          Text('Daily Check In', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          Spacer(),
          UserCard()
        ],
      ),
    );
  }

  Widget ContentBox() {
    return Expanded(child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/check_in/bg.png'), fit: BoxFit.cover)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 0, child: Image.asset('assets/images/check_in/mask.png', width: MediaQuery.of(context).size.width)),
          Column(
            children: [
              SizedBox(height: 110),
              Image.asset('assets/images/check_in/title.png', height: 60),
              SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/check_in/content.png', height: 280),
                  _buildSlotMachine(),
                  Positioned(top: 10, child: Image.asset('assets/images/check_in/text_top.png', height: 22)),
                  Positioned(bottom: 12, child: Image.asset('assets/images/check_in/text_bottom.png', height: 14)),
                ],
              ),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 370,
                    height: 62,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF511CFF), Color(0xFFED2DFF)],
                        stops: [0.1, 1], // 调整渐变范围
                      ),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Color.fromRGBO(255, 255, 255, 0.64),
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Color(0xFF494949),
                        overlayColor: Colors.black26,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _freeCount != 0 ? _startSpin : null,
                      child: Text('Free Spin ($_freeCount)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                    ))
                  )
                ]
              )),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ]
          ),
        ],
      )
    ));
  }

  Widget _buildSlotMachine() {
    return Positioned(
      top: 56,
      left: 40,
      child: Row(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) => _scrollItem(index))
      )
    );
  }

  Widget _scrollItem(index) {
    return SizedBox(
      width: 100,
      height: 170,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollEndNotification: _endSpin(); break;
          }
          return true;
        },
        child: ListView.builder(
          controller: _scrollControllers[index],
          physics: NeverScrollableScrollPhysics(),
          itemCount: 600, // 确保足够滚动长度
          itemBuilder: (_, i) => Container(
            height: _itemHeight,
            alignment: Alignment.center,
            child: Image.asset('assets/images/check_in/reward_${i%5+1}.png', width: 46),
          ),
        ),
      ),
    );
  }
}