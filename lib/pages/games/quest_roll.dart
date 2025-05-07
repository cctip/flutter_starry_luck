// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/primary_btn.dart';
import '/widget/detail_header.dart';

class QuestRoll extends StatefulWidget {
  const QuestRoll({super.key});

  @override
  State<QuestRoll> createState() => QuestRollState();
}

class QuestRollState extends State<QuestRoll> with SingleTickerProviderStateMixin {
  final int _startFee = 100; // 游戏开始花费
  bool _start = false;
  final List _guessList = [7, 8, 9];
  int _guessValue = 0;
  int _numberLeft = 0;
  int _numberRight = 0;

  // 重置游戏
  _onResetGame() {
    setState(() {
      _start = false;
      _guessValue = 0;
      _numberLeft = 0;
      _numberRight = 0;
    });
  }

  // 选择预测数
  _onChoose(val) {
    if (_start) return;
    setState(() => _guessValue = val);
  }
  // 开始游戏
  _onStart() {
    if (UserController.points.value >= _startFee) {
      UserController.decreasePoints(_startFee);
      if (_start) return;
      setState(() {
        _start = true;
        _numberLeft = Random().nextInt(6) + 1;
        _numberRight = Random().nextInt(6) + 1;
      });

      if (_numberLeft + _numberRight == _guessValue) {
        int successPoint = 0;
        switch(_guessValue) {
          case 7: successPoint = 160; break;
          case 8: successPoint = 200; break;
          case 9: successPoint = 250; break;
        }
        Future.delayed(Duration(milliseconds: 1000), () {
          Utils.gameSuccess(context, point: successPoint, xp: 75, callback: _onResetGame);
        });
      } else {
        Future.delayed(Duration(milliseconds: 1000), () {
          Utils.gameFailed(context, xp: 30, callback: _onResetGame);
        });
      }
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
            DetailHeader(title: 'Quest Roll', rule: 'quest_roll'),
            ContentBox(),
            DataBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0.4, child: Image.asset('assets/images/game_quest_roll/bg.png', fit: BoxFit.cover)),
        _start ? Positioned(child: Row(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceIn(child: Container(
              width: 100,
              height: 100,
              padding: _numberLeft == 6 ? EdgeInsets.symmetric(horizontal: 20, vertical: 12) : EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/game_quest_roll/dice_bg.png'))
              ),
              child: _buildDots(_numberLeft),
            )),
            BounceIn(child: Container(
              width: 100,
              height: 100,
              padding: _numberRight == 6 ? EdgeInsets.symmetric(horizontal: 20, vertical: 12) : EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/game_quest_roll/dice_bg.png'))
              ),
              child: _buildDots(_numberRight),
            )),
          ],
        )) : Positioned(child: Image.asset('assets/images/game_quest_roll/dice_group.png', height: 120)),
      ],
    );
  }
  Widget _buildDots(int number) {
    final dot = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );

    List<Widget> dots = [];
    
    switch (number) {
      case 1:
        dots = [Center(child: dot)];
        break;
      case 2:
        dots = [Align(alignment: Alignment.topLeft, child: dot), 
                Align(alignment: Alignment.bottomRight, child: dot)];
        break;
      case 3:
        dots = [Align(alignment: Alignment.topLeft, child: dot),
                Align(alignment: Alignment.center, child: dot),
                Align(alignment: Alignment.bottomRight, child: dot)];
        break;
      case 4:
        dots = [Align(alignment: Alignment.topLeft, child: dot),
                Align(alignment: Alignment.topRight, child: dot),
                Align(alignment: Alignment.bottomLeft, child: dot),
                Align(alignment: Alignment.bottomRight, child: dot)];
        break;
      case 5:
        dots = [Align(alignment: Alignment.topLeft, child: dot),
                Align(alignment: Alignment.topRight, child: dot),
                Align(alignment: Alignment.center, child: dot),
                Align(alignment: Alignment.bottomLeft, child: dot),
                Align(alignment: Alignment.bottomRight, child: dot)];
        break;
      case 6:
        dots = [Align(alignment: Alignment.topLeft, child: dot),
                Align(alignment: Alignment.topRight, child: dot),
                Align(alignment: Alignment.centerLeft, child: dot),
                Align(alignment: Alignment.centerRight, child: dot),
                Align(alignment: Alignment.bottomLeft, child: dot),
                Align(alignment: Alignment.bottomRight, child: dot)];
        break;
    }
    return Stack(children: dots);
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
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            spacing: 8,
            children: List.generate(_guessList.length, (index) => Expanded(child: GestureDetector(
              onTap: () => _onChoose(_guessList[index]),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(_guessList[index] == _guessValue ? 0xFF0083FE :0xFF313131),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text('${_guessList[index]}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              ))
            ))
          ),
        ),
        PrimaryBtn(
          width: MediaQuery.of(context).size.width,
          height: 62,
          radius: 12,
          text: 'Start Game ($_startFee)',
          func: !_start && _guessList.contains(_guessValue) ? _onStart : null
        )
      ])
    ));
  }
}