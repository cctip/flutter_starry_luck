// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/primary_btn.dart';
import '/widget/detail_header.dart';

class StellarGift extends StatefulWidget {
  const StellarGift({super.key});

  @override
  State<StellarGift> createState() => StellarGiftState();
}

class StellarGiftState extends State<StellarGift> {
  final int _startFee = 200; // 游戏开始花费
  bool _start = false;
  final List _openedList = [];
  final List _openedBalls = [];
  int _comboCount = 0;
  bool _openBlack = false;

  // 重置游戏
  _onResetGame() {
    setState(() {
      _start = false;
      _openedList.clear();
      _openedBalls.clear();
      _comboCount = 0;
      _openBlack = false;
    });
  }

  // 开始游戏
  _onStart() {
    if (UserController.points.value >= _startFee) {
      UserController.decreasePoints(_startFee);
      setState(() => _start = true);
    } else {
      Utils.toast(context, message: 'Insufficient points');
    }
  }

  // 打开盲盒
  _onOpen(index) {
    if (!_start || _openedList.contains(index) || _openBlack) return;
    setState(() {
      _openedList.add(index);
      int type = Random().nextInt(2);
      if (type != 0) {
        _comboCount++;
      }
      _openedBalls.add(type);
      _openBlack = type == 0;
    });
    if (_openBlack) {
      Future.delayed(Duration(milliseconds: 500), () {
        Utils.gameFailed(context, xp: 70, callback: _onResetGame);
      });
    }
  }

  // 领取奖励
  _onClaim() {
    if (_openBlack) return;
    Utils.gameSuccess(context, point: 50 * _comboCount, xp: 120 + 5 * _comboCount, callback: _onResetGame);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Stellar Gift', rule: 'stellar_gift'),
            ContentBox(),
            DataBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 540,
      padding: EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/game_stellar_gift/bg.png'), fit: BoxFit.cover)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(child: Image.asset('assets/images/game_stellar_gift/cambo_border.png', height: 60)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/game_stellar_gift/COMBO_${_comboCount == 0 ? 'gray' : _comboCount > 2 ? 'orange' : 'white'}.png', height: 20),
                    SizedBox(width: 10),
                    Text('x$_comboCount', style: TextStyle(color: Color.fromRGBO(255, 255, 255, _comboCount == 0 ? 0.32 : 1), fontSize: 24, fontWeight: FontWeight.w700))
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: List.generate(25, (index) => _openedList.contains(index) ? ballItem(index) : GestureDetector(
                onTap: () => _onOpen(index),
                child: FlipInY(child: Image.asset('assets/images/game_stellar_gift/blind_box.png', width: 70)),
              )),
            ),
          ]),
          _openBlack ? Positioned(child: Image.asset('assets/images/game_stellar_gift/toast_opps.png')): Container()
        ],
      ),
    );
  }
  Widget ballItem(item) {
    int index = _openedList.indexOf(item);
    int type = _openedBalls[index];
    return type == 1 ? BounceIn(child: Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(7),
      child: Image.asset('assets/images/game_stellar_gift/ball_purple.png', width: 56),
    )) : Pulse(child: Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(7),
      child: Image.asset('assets/images/game_stellar_gift/ball_black.png', width: 56),
    ));
  }

  Widget DataBox() {
    return Expanded(child: Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Color(0xFF212121),
      child: Column(children: [
        Container(
          height: 48,
          margin: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/game_stellar_gift/ball_purple.png', width: 32),
              SizedBox(width: 8),
              Text('$_comboCount', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))
            ],
          ),
        ),
        PrimaryBtn(
          width: MediaQuery.of(context).size.width,
          height: 62,
          radius: 12,
          text: _start ? 'Claim Reward' : 'Start Game ($_startFee)',
          func: _start ? _onClaim : _onStart
        )
      ])
    ));
  }
}