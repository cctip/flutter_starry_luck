// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/game.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import '/widget/primary_btn.dart';
import 'package:animate_do/animate_do.dart';
import '/widget/detail_header.dart';

class GalacticHand extends StatefulWidget {
  const GalacticHand({super.key});

  @override
  State<GalacticHand> createState() => GalacticHandState();
}

class GalacticHandState extends State<GalacticHand> {
  final int _startFee = 150; // 游戏开始花费
  bool _start = false;
  final List _cardList = [];
  // 一对/两对/三条/顺子/同花/葫芦(三条+一对)/四条/同花顺/皇家同花顺
  final List _guessList = ['Pair', 'Two Pair', 'Three of kind', 'Straight', 'Flush', 'Full house', 'Four of kind', 'Straight flush', 'Royal flush'];
  final List _pointList = [150, 200, 225, 250, 300, 350, 400, 450, 500];
  int _curGuessIndex = -1;
  bool _guessLocked = false;
  int _result = -1;
  bool _showResult = false;

  // 重置游戏
  _onResetGame() {
    setState(() {
      _start = false;
      _cardList.clear();
      _curGuessIndex = -1;
      _guessLocked = false;
      _result = -1;
      _showResult = false;
    });
  }

  // 开始游戏
  _onStartGame() {
    if (UserController.points.value >= _startFee) {
      UserController.decreasePoints(_startFee);
      GameController.startGame('gh');
      setState(() => _start = true);
      Future.delayed(Duration(milliseconds: 200), _deal);
      Future.delayed(Duration(milliseconds: 700), _deal);
    } else {
      Utils.toast(context, message: 'Insufficient points');
    }
  }

  // 发牌
  _deal() {
    if (_cardList.length >= 5) return;
    int cardNumber() {
      int val = Random().nextInt(52);
      if (_cardList.contains(val)) return cardNumber();
      return val;
    }
    setState(() {
      _cardList.add(cardNumber());
    });
    if (_cardList.length > 2) {
      setState(() => _guessLocked = true);
    }
  }
  // 计算牌面
  _calcFace(index) {
    if (_cardList.length > index) {
      int item = _cardList[index];
      String face = '${item % 13 + 1}';
      Color color = Color(0xFF040E1D);
      List suits = ['suit_spade', 'suit_heart', 'suit_club', 'suit_diamond']; // 黑桃♠️/红桃♥️/梅花♣️/方片♦️
      String suit = suits[item ~/ 13];
      if (item % 13 == 0) {
        face = 'A';
      } else if (item % 13 == 10) {
        face = 'J';
      } else if (item % 13 == 11) {
        face = 'Q';
      } else if (item % 13 == 12) {
        face = 'K';
      }
      return { 'suit': suit, 'face': face, 'color': color };
    } else {
      return { 'suit': '', 'face': '', 'color': Colors.transparent };
    }
  }

  // 提交预测
  _onConfirm() {
    if (_guessLocked) return;
    _deal();
    Future.delayed(Duration(milliseconds: 500), _deal);
    Future.delayed(Duration(milliseconds: 1000), _deal);
    Future.delayed(Duration(milliseconds: 1100), () {
      setState(() {
        _result = _calcResult();
        _showResult = true;
      });
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      if (_curGuessIndex == _result) {
        GameController.winGame('gh');
        Utils.gameSuccess(context, point: _pointList[_result], xp: 100, callback: _onResetGame);
      } else {
        GameController.calcGameTime();
        Utils.gameFailed(context, xp: 50, callback: _onResetGame);
      }
    });
  }
  // 计算预测结果
  _calcResult() {
    // 检查各种牌型（按优先级从高到低）
    if (_isRoyalFlush()) return 8;
    if (_isStraight() && _isFlush()) return 7;
    if (_countRanks().values.any((count) => count == 4)) return 6;
    if (_isFullHouse()) return 5;
    if (_isFlush()) return 4;
    if (_isStraight()) return 3;
    if (_countRanks().values.any((count) => count == 3)) return 2;
    if (_isTwoPair()) return 1;
    if (_countRanks().values.any((count) => count == 2)) return 0;
    return -1;
  }
  // 皇家同花顺
  bool _isRoyalFlush() {
    for (int i = 0; i < _cardList.length; i++) {
      if (_cardList[i] % 13 < 8) {
        return false;
      }
    }
    return _isFlush() && _isStraight();
  }
  // 同花
  bool _isFlush() {
    final firstSuit = _calcFace(0)['suit'];
    bool result = true;
    for (int i = 1; i < _cardList.length; i++) {
      if (_calcFace(i)['suit'] != firstSuit) {
        result = false;
      }
    }
    return result;
  }
  // 顺子
  bool _isStraight() {
    // 检查是否连续
    for (int i = 0; i < _cardList.length - 1; i++) {
      if (_cardList[i + 1] - _cardList[i] != 1) return false;
    }
    return true;
  }
  // 葫芦
  bool _isFullHouse() {
    final counts = _countRanks();
    return counts.containsValue(3) && counts.containsValue(2);
  }
  // 两对
  bool _isTwoPair() {
    final counts = _countRanks();
    int pairCount = 0;
    counts.forEach((key, value) {
      if (value == 2) pairCount++;
    });
    return pairCount == 2;
  }
  // 统计点数出现次数
  Map _countRanks() {
    final counts = <int, int>{};
    for (final rank in _cardList) {
      counts[rank % 13] = (counts[rank % 13] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Galactic Hand', rule: 'galactic_hand'),
            ContentBox(),
            GuessBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 416,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/game_galactic_hand/table.png'), fit: BoxFit.cover)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            child: BackInDown(child: Container(
              width: 114,
              height: 63,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/game_galactic_hand/card_group.png'))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(33, 33, 33, 0.72),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text('${52-_cardList.length}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  )
                ]
              )
            ))
          ),
          Positioned(
            child: Wrap(
              spacing: 3,
              children: List.generate(5, (index) => CardItem(index))
            )
          ),
          Positioned(
            bottom: 88,
            child: _showResult ? Text(_result == -1 ? 'High Card' : _guessList[_result], style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Color(0xFFFFAA1C), // 阴影颜色
                  offset: Offset(0, 0), // 阴影偏移量 (水平, 垂直)
                  blurRadius: 4, // 阴影模糊程度
                ),
              ]
            )) : Container()
          )
        ],
      ),
    );
  }
  Widget CardItem(index) {
    var info = _calcFace(index);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/game_galactic_hand/card_hollow.png', width: 72, height: 108),
        Positioned(child: _cardList.length > index ? SlideInDown(child: Container(
          width: 72,
          height: 108,
          padding: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/game_galactic_hand/${info['suit']}.png', width: 32),
              Text('${info['face']}', style: TextStyle(color: Color(0xFF040E1D), fontSize: 42, fontWeight: FontWeight.w800))
            ]
          ),
        )) : SizedBox(width: 72, height: 108))
      ]
    );
  }

  Widget GuessBox() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 20, right: 20),
      child: Column(children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_guessList.length, (index) => GestureDetector(
            onTap: () {
              if (_guessLocked || !_start) return;
              setState(() {
                _curGuessIndex = index;
              });
            },
            child: Container(
              width: (MediaQuery.of(context).size.width - 56) / 3,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _curGuessIndex == index ? Color(0xFF0083FE) : Color(0xFF313131),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text(_guessList[index], style: TextStyle(color: Color.fromRGBO(255, 255, 255, _curGuessIndex == index ? 1 : 0.64), fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ))
        ),
        SizedBox(height: 16),
        PrimaryBtn(
          width: MediaQuery.of(context).size.width,
          height: 62,
          radius: 12,
          text: _start ? (_curGuessIndex != -1 ? 'Confirm' : 'Waiting for select') : 'Start Game ($_startFee)',
          func: _start ? (_curGuessIndex != -1 ? _onConfirm : null) : _onStartGame
        )
      ]),
    );
  }
}