// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/widget/user_card.dart';
import 'package:get/get.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => CheckInPageState();
}

class CheckInPageState extends State<CheckInPage> with SingleTickerProviderStateMixin {
  final _scrollControllers = List.generate(3, (_) => ScrollController());
  final List<double> _randomOffsets = [0, 0, 0];
  late AnimationController _animationController;
  final double _itemHeight = 80;
  bool runing = false;
  int _endingCount = 0;
  int _endIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollControllers.asMap().forEach((index, controller) {
        controller.animateTo(
          300,
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
    setState(() {
      runing = true;
      _endIndex = Random().nextInt(5);
    });

    // 递归随机数生成
    getRandom(index) {
      double randomOffset = (Random().nextInt(20) + 5) * _itemHeight * 6 + _endIndex * _itemHeight + 60; // 保证完整滚动圈数
      if (randomOffset > _randomOffsets[index] - 1000 && randomOffset < _randomOffsets[index] + 1000) {
        randomOffset = getRandom(index);
      }
      _randomOffsets[index] = randomOffset;
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
      if (_endingCount == 6) {
        runing = false;
        _endingCount = 0;
      }
    });
    if (runing) return;

    int starCount = 0;
    int expCount = 0;
    String nftImage = '';
    if (_endIndex == 0) {
      int n = Random().nextInt(200) + 1; // 1到200随机数
      starCount = 5 * n;
    } else if (_endIndex == 1) {
      int n = Random().nextInt(50) + 1; // 1到50随机数
      expCount = 10 * n;
    } else if (_endIndex == 2) {
      
    }
    Widget _rewardImage() {
      if (_endIndex == 0) {
        return Image.asset('assets/icons/star.png', width: 120);
      } else if (_endIndex == 1) {
        return Image.asset('assets/icons/exp.png', width: 120);
      } else if (_endIndex == 2) {
        return Image.asset(nftImage, width: 242);
      } else {
        return Container();
      }
    }
    
    showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black87,
      builder: (_) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 点击内容区域关闭
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + kToolbarHeight + 20, 16, MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Image.asset('assets/images/lottery/dialog_title.png'),
              ),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 68,
                    left: 24,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: Opacity(opacity: 0.5, child: Image.asset('assets/images/lottery/dialog_decration.png')),
                    )
                  ),
                  Positioned(child: Image.asset('assets/images/lottery/dialog_mask.png')),
                  Positioned(child: _rewardImage()),
                ],
              ),
              Text('You got a reward${_endIndex == 2 ? '' : 'of'}', style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Outfit',
                decoration: TextDecoration.none
              )),
              _endIndex == 2 ? Container() : Container(
                width: 200,
                height: 64,
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(12, 12, 13, 0.8),
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/${_endIndex == 0 ? 'star' : 'exp'}.png', width: 32),
                    SizedBox(width: 8),
                    Text(_endIndex == 0 ? '$starCount' : '$expCount', style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Outfit',
                      decoration: TextDecoration.none
                    ))
                  ],
                ),
              ),
              Spacer(),
              Text('Tap anywhere to claim your reward', style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none
              )),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 80)
            ],
          ),
        )
      )
    );
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Color.fromRGBO(255, 255, 255, 0.64),
                        backgroundColor: Colors.transparent,
                        disabledBackgroundColor: Color(0xFF494949),
                        overlayColor: Colors.black26,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _startSpin,
                      child: Text('Free Spin (3)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                    ),
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
            // case ScrollEndNotification: _endSpin(); break;
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
            child: Image.asset('assets/images/check_in/reward_${i%5+1}.png', width: 56),
          ),
        ),
      ),
    );
  }
}