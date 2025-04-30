// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '/widget/detail_header.dart';

class NebulaRush extends StatefulWidget {
  const NebulaRush({super.key});

  @override
  State<NebulaRush> createState() => NebulaRushState();
}

class NebulaRushState extends State<NebulaRush> {
  bool _start = false;
  final List _dealerList = [];
  final List _playerList = [];
  bool _dealerStand = false;
  bool _playerStand = false;

  @override
  void initState() {
    super.initState();
  }

  // 开始游戏
  _onStart() {
    setState(() {
      _start = true;
      _dealerAuto(0);
      _addPlayerPoker(0);
      _addPlayerPoker(500);
    });
  }
  // 对手自动游戏
  _dealerAuto(duration) {
    _addDealerPoker(duration);
    Future.delayed(Duration(milliseconds: duration), () {
      if (_calcDealerPoint(_dealerList) < 18) {
        _dealerAuto(duration + 500);
      } else {
        setState(() => _dealerStand = true);
        if (_playerStand) _gameOver();
      }
    });
  }
  // 给对手发牌
  _addDealerPoker(duration) {
    Future.delayed(Duration(milliseconds: duration), () {
      setState(() {
        _dealerList.add(randomNumber());
      });
    });
  }
  // 给自己发牌
  _addPlayerPoker(duration) {
    Future.delayed(Duration(milliseconds: duration), () {
      setState(() {
        _playerList.add(randomNumber());
      });
    });
  }
  // 生成随机卡牌编码
  int randomNumber() {
    int val = Random().nextInt(52);
    if (_dealerList.contains(val) || _playerList.contains(val)) return randomNumber();
    return val;
  }
  // 计算点数合
  _calcDealerPoint(list) {
    int point = 0;
    for (int val in list) {
      point += val % 13 + 1;
    }
    return point;
  }

  // 自己结束抽牌
  _onStand() {
    setState(() {
      _playerStand = true;
    });
    if (_dealerStand) _gameOver();
  }
  // 游戏结束
  _gameOver() {

  }

  // 计算牌面
  _calcFace(item) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF212121),
        child: Column(
          children: [
            DetailHeader(title: 'Nebula Rush', rule: 'nebula_rush'),
            ContentBox(),
            FooterBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/game_nebula_rush/table.png'),
        Positioned(
          top: 70 * MediaQuery.of(context).size.width / 402,
          child: PersonBox(name: 'Dealer', point: _dealerStand && _playerStand ? _calcDealerPoint(_dealerList) : _dealerList.isEmpty ? 0 : _dealerList[0] % 13 + 1)
        ),
        Positioned(
          bottom: 110 * MediaQuery.of(context).size.width / 402,
          child: PersonBox(name: 'Player', point: _calcDealerPoint(_playerList))
        ),
        Positioned(
          top: (130) * MediaQuery.of(context).size.width / 402,
          child: SizedBox(
            width: 260 * MediaQuery.of(context).size.width / 402,
            height: 320 * MediaQuery.of(context).size.width / 402,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(_dealerList.length, (index) => FadeInRight(
                    child: index == 0 ?
                      CardItem(_dealerList[index])
                      : _dealerStand && _playerStand ? FlipInY(child: CardItem(_dealerList[index])) : Image.asset('assets/icons/poker_back.png', width: 42)
                  )),
                ),
                !_start ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(left: -24, child: Image.asset('assets/icons/poker_back.png', width: 42)),
                    Positioned(left: -12, child: Image.asset('assets/icons/poker_back.png', width: 42)),
                    Image.asset('assets/icons/poker_back.png', width: 42),
                    Positioned(left: 12, child: Image.asset('assets/icons/poker_back.png', width: 42)),
                    Positioned(left: 24, child: Image.asset('assets/icons/poker_back.png', width: 42)),
                  ]
                ) : Container(),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(_playerList.length, (index) => FadeInRight(child: CardItem(_playerList[index]))),
                ),
              ]
            ),
          )
        )
      ],
    );
  }
  Widget PersonBox({ required String name, required int point }) {
    return Container(
      width: 116,
      height: 48,
      decoration: BoxDecoration(
        color: Color.fromRGBO(40, 40, 40, 0.3),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(children: [
        SizedBox(height: 4),
        Text(name, style: TextStyle(color: Colors.white38, fontSize: 12)),
        Text('$point', style: TextStyle(color: Colors.white, fontSize: 18)),
      ]),
    );
  }
  Widget CardItem(val) {
    var info = _calcFace(val);
    return Container(
      width: 42,
      height: 63,
      padding: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/game_galactic_hand/${info['suit']}.png', width: 18),
          Text('${info['face']}', style: TextStyle(color: Color(0xFF040E1D), fontSize: 24.5, fontWeight: FontWeight.w800))
        ]
      ),
    );
  }

  Widget FooterBox() {
    return Container(
      padding: EdgeInsets.all(16),
      child: _start ? Row(children: [
        GradientBtn(text: 'Stand', colors: [Color(0xFF2BB100), Color(0xFF74EA4E)], func: _playerStand ? null : _onStand),
        SizedBox(width: 16),
        GradientBtn(text: 'Hit', colors: [Color(0xFFFF8743), Color(0xFFFFAA1C)], func: _playerStand ? null : () {
          _addPlayerPoker(0);
        }),
      ]) : Row(children: [GradientBtn(text: 'Start Game', colors: [Color(0xFFFF8743), Color(0xFFFFAA1C)], func: _onStart)]),
    );
  }
  Widget GradientBtn({ required String text, colors, func }) {
    return Expanded(child: Container(
      height: 62,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: [0.5, 1], // 调整渐变范围
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
          shadowColor: Colors.transparent,
          overlayColor: Colors.black26,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: func,
        child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
      ),
    ));
  }
}