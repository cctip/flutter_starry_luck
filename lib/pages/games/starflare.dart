// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/game.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/primary_btn.dart';
import '/widget/detail_header.dart';

class Starflare extends StatefulWidget {
  const Starflare({super.key});

  @override
  State<Starflare> createState() => StarflareState();
}

class StarflareState extends State<Starflare> {
  final int _startFee = 100; // 游戏开始花费
  bool _start = false;
  int _guessIndex = 0;
  final List _lightList = [];

  // 重置游戏
  _onResetGame() {
    setState(() {
      _start = false;
      _guessIndex = 0;
      _lightList.clear();
    });
  }

  // 选择预测数
  _onChoose(index) {
    if (_start) return;
    setState(() => _guessIndex = index);
  }
  // 开始游戏
  _onStart() {
    if (UserController.points.value >= _startFee) {
      UserController.decreasePoints(_startFee);
      GameController.startGame('sf');
      if (_start) return;
      setState(() => _start = true);
      Future.delayed(Duration(milliseconds: 1000), () {
        for (int i = 0; i < 12; i++) {
          if (Random().nextInt(2) == 1) {
            setState(() {
              _lightList.add(i);
            });
          }
        }
        if (_lightList.length < 6 && _guessIndex == 1 || _lightList.length == 6 && _guessIndex == 2 || _lightList.length > 6 && _guessIndex == 3) {
          Future.delayed(Duration(milliseconds: 2000), () {
            GameController.winGame('sf');
            Utils.gameSuccess(context, point: _lightList.length == 6 && _guessIndex == 2 ? 300 : 120, xp: 70 + 5 * _lightList.length, callback: _onResetGame);
          });
        } else {
          Future.delayed(Duration(milliseconds: 2000), () {
            GameController.calcGameTime();
            Utils.gameFailed(context, xp: 30, callback: _onResetGame);
          });
        }
      });
    } else {
      Utils.toast(context, message: 'Insufficient points');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Starflare', rule: 'starflare'),
            ContentBox(),
            DataBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      height: 540,
      color: Color.fromARGB(134, 33, 33, 33),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 上
          Positioned(
            top: _lightList.contains(0) || _lightList.contains(1) || _lightList.contains(2) ? 0 : 10,
            child: Row(
              children: [
                Flash(animate: _lightList.contains(0), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_up${_lightList.contains(0) ? '_light' : ''}.png', width: 72)),
                SizedBox(width: 32),
                Flash(animate: _lightList.contains(1), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_up${_lightList.contains(1) ? '_light' : ''}.png', width: 72)),
                SizedBox(width: 32),
                Flash(animate: _lightList.contains(2), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_up${_lightList.contains(2) ? '_light' : ''}.png', width: 72)),
              ]
            )
          ),
          Positioned(
            top: _lightList.contains(3) || _lightList.contains(4) ? 68 : 78,
            child: Row(
              children: [
                Flash(animate: _lightList.contains(3), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_up${_lightList.contains(3) ? '_light' : ''}.png', width: 72)),
                SizedBox(width: 32),
                Flash(animate: _lightList.contains(4), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_up${_lightList.contains(4) ? '_light' : ''}.png', width: 72)),
              ]
            )
          ),
          Positioned(
            top: _lightList.contains(5) ? 136 : 146,
            child: Row(
              children: [
                Flash(animate: _lightList.contains(5), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_up${_lightList.contains(5) ? '_light' : ''}.png', width: 72)),
              ]
            )
          ),
          // 下
          Positioned(
            bottom: _lightList.contains(6) || _lightList.contains(7) || _lightList.contains(8) ? 0 : 10,
            child: Row(
              children: [
                Flash(animate: _lightList.contains(6), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_down${_lightList.contains(6) ? '_light' : ''}.png', width: 72)),
                SizedBox(width: 32),
                Flash(animate: _lightList.contains(7), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_down${_lightList.contains(7) ? '_light' : ''}.png', width: 72)),
                SizedBox(width: 32),
                Flash(animate: _lightList.contains(8), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_down${_lightList.contains(8) ? '_light' : ''}.png', width: 72)),
              ]
            )
          ),
          Positioned(
            bottom: _lightList.contains(9) || _lightList.contains(10) ? 68 : 78,
            child: Row(
              children: [
                Flash(animate: _lightList.contains(9), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_down${_lightList.contains(9) ? '_light' : ''}.png', width: 72)),
                SizedBox(width: 32),
                Flash(animate: _lightList.contains(10), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_down${_lightList.contains(10) ? '_light' : ''}.png', width: 72)),
              ]
            )
          ),
          Positioned(
            bottom: _lightList.contains(11) ? 136 : 146,
            child: Row(
              children: [
                Flash(animate: _lightList.contains(11), delay: Duration(milliseconds: 500), child: Image.asset('assets/images/game_starflare/bulb_down${_lightList.contains(11) ? '_light' : ''}.png', width: 72)),
              ]
            )
          ),
          
          // 插线
          Positioned(
            left: 0,
            child: _start ? FadeInLeftBig(
              duration: Duration(milliseconds: 800),
              child: Image.asset('assets/images/game_starflare/plug_left_long.png', width: MediaQuery.of(context).size.width / 2 + 20)
            ) : SlideInLeft(child: Image.asset('assets/images/game_starflare/plug_left.png', width: 100))
          ),
          Positioned(
            right: 0,
            child: _start ? FadeInRightBig(
              duration: Duration(milliseconds: 800),
              child: Image.asset('assets/images/game_starflare/plug_right_long.png', width: MediaQuery.of(context).size.width / 2)
            ) : SlideInRight(child: Image.asset('assets/images/game_starflare/plug_right.png', width: 100))
          ),
        ],
      ),
    );
  }

  Widget DataBox() {
    return Expanded(child: Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Color(0xFF212121),
      child: Column(children: [
        Container(
          height: 48,
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            spacing: 8,
            children: [
              Expanded(child: GestureDetector(
                onTap: () => _onChoose(1),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(_guessIndex == 1 ? 0xFF0083FE :0xFF313131),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text('<6', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ))
              ),
              Expanded(child: GestureDetector(
                onTap: () => _onChoose(2),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(_guessIndex == 2 ? 0xFF0083FE :0xFF313131),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text('6', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ))
              ),
              Expanded(child: GestureDetector(
                onTap: () => _onChoose(3),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(_guessIndex == 3 ? 0xFF0083FE :0xFF313131),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text('>6', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ))
              ),
            ],
          ),
        ),
        PrimaryBtn(
          width: MediaQuery.of(context).size.width,
          height: 62,
          radius: 12,
          text: 'Start Game ($_startFee)',
          func: _start || _guessIndex == 0 ? null : _onStart
        )
      ])
    ));
  }
}