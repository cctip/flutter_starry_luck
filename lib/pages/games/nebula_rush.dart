// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/game.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import '/widget/detail_header.dart';

class NebulaRush extends StatefulWidget {
  const NebulaRush({super.key});

  @override
  State<NebulaRush> createState() => NebulaRushState();
}

class NebulaRushState extends State<NebulaRush> {
  final int _startFee = 200; // 游戏开始花费
  bool _wobble = false;
  bool _start = false;
  bool _playable = false;
  final List _dealerList = [];
  final List _playerList = [];
  bool _dealerStand = false; // 庄家stand
  bool _playerStand = false; // 玩家stand
  bool _someoneBurst = false; // 有人爆牌
  String _toastText = '';
  bool _showToast = false; // 普通提示显隐
  bool _burstToast = false; // 爆牌提示显隐
  bool _resultToast = false; // 结果提示显隐
  String _result = ''; // 结果
  bool _someonBlackJack = false; // 有人是黑杰克

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() => _wobble = true);
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() => _wobble = false);
    });
  }

  // 重置游戏
  _onResetGame() {
    setState(() {
      _wobble = true;
      _start = false;
      _playable = false;
      _dealerList.clear();
      _playerList.clear();
      _dealerStand = false;
      _playerStand = false;
      _someoneBurst = false;
      _showToast = false;
      _burstToast = false;
      _resultToast = false;
      _result = '';
      _someonBlackJack = false;
    });
  }

  // 开始游戏
  _onStart() {
    if (UserController.points.value >= _startFee) {
      UserController.decreasePoints(_startFee);
      GameController.startGame('nr');
      setState(() => _start = true);
      _addDealerPoker(0);
      _addDealerPoker(500);
      _addPlayerPoker(0);
      _addPlayerPoker(500);
      Future.delayed(Duration(milliseconds: 1000), () {
        _onToast('Player First');
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() => _playable = true);
        });
      });
    } else {
      Utils.toast(context, message: 'Insufficient points');
    }
  }

  // 对手自动游戏
  _dealerAuto(duration) {
    if (_someoneBurst || _dealerStand) return;
    _addDealerPoker(duration);
    Future.delayed(Duration(milliseconds: duration), () {
      if (_someoneBurst || _dealerStand) return;
      _dealerAuto(duration + 500);
    });
  }
  // 给对手发牌
  _addDealerPoker(duration) {
    if (_someoneBurst) return;
    if (_calcListPoint(_dealerList) < 18) {
      Future.delayed(Duration(milliseconds: duration), () {
        if (_someoneBurst) return;
        setState(() {
          _dealerList.add(randomNumber());
        });
        if (_calcListPoint(_dealerList) > 21) {
          _showBurstToast();
        }
      });
    } else {
      Future.delayed(Duration(milliseconds: 1000), () {
        _onToast('Dealer Stand');
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() => _dealerStand = true);
          if (_playerStand) _gameOver();
        });
      });
    }
  }
  // 给自己发牌
  _addPlayerPoker(duration) {
    if (_playerList.length > 6 || _someoneBurst) return;
    Future.delayed(Duration(milliseconds: duration), () {
      if (_someoneBurst) return;
      setState(() {
        _playerList.add(randomNumber());
      });
      if (_calcListPoint(_playerList) > 21) {
        _showBurstToast();
      }
    });
  }
  // 生成随机卡牌编码
  int randomNumber() {
    int val = Random().nextInt(52);
    if (_dealerList.contains(val) || _playerList.contains(val)) return randomNumber();
    return val;
  }
  // 计算点数合
  _calcListPoint(list) {
    if (list.length == 2) {
      if (list[0] % 13 == 0 && list[1] % 13 >= 9 || list[1] % 13 == 0 && list[0] % 13 >= 9) {
        return 21;
      }
    }
    int point = 0;
    for (int val in list) {
      int newIndex = val % 13;
      if (newIndex >= 9) {
        point += 10;
      } else {
        point += newIndex + 1;
      }
    }
    return point;
  }

  // 自己结束抽牌
  _onStand() {
    setState(() {
      _playerStand = true;
    });
    _onToast("Dealer's Time");
    Future.delayed(Duration(milliseconds: 2000), () {
      if (_calcListPoint(_dealerList) < 18) {
        _dealerAuto(2000);
      } else {
        Future.delayed(Duration(milliseconds: 1000), () {
          _onToast('Dealer Stand');
          Future.delayed(Duration(milliseconds: 2000), () {
            setState(() => _dealerStand = true);
            if (_playerStand) _gameOver();
          });
        });
      }
    });
  }
  
  // 爆牌弹窗提示
  _showBurstToast() {
    setState(() {
      _someoneBurst = true;
      _burstToast = true;
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _dealerStand = true;
        _playerStand = true;
      });
      Future.delayed(Duration(milliseconds: 2000), () {
        setState(() => _burstToast = false);
        _gameOver();
      });
    });
  }
  // 游戏结束
  _gameOver() {
    int dealerPoint = _calcListPoint(_dealerList);
    int playerPoint = _calcListPoint(_playerList);
    setState(() {
      _someonBlackJack = (_dealerList.length == 2 && dealerPoint == 21) || (_playerList.length == 2 && playerPoint == 21);
      if (_someoneBurst) { // 爆牌者对方获胜
        _result = dealerPoint > playerPoint ? 'win' : 'lose';
      } else if (dealerPoint != playerPoint) { // 点数大者胜
        _result = dealerPoint > playerPoint ? 'lose' : 'win';
      } else if (dealerPoint == playerPoint) { // 相同时庄家胜，若玩家为黑杰克则胜出
        _result = 'lose';
        if (_playerList.length == 2 && playerPoint == 21) { // 玩家黑杰克
          _result = 'win';
        }
        if (_dealerList.length == 2 && dealerPoint == 21) { // 庄家黑杰克
          _result = 'lose';
        }
      }
    });
    if (_someonBlackJack) {
      Future.delayed(Duration(milliseconds: 2000), () {
        setState(() {
          _someonBlackJack = false;
          _resultToast = true;
        });
        _showReword();
      });
    } else {
      setState(() {
        _resultToast = true;
      });
      _showReword();
    }
  }
  // 奖励弹窗
  _showReword() {
    Future.delayed(Duration(milliseconds: 2000), () {
      if (_result == 'win') {
        GameController.winGame('nr');
        Utils.gameSuccess(context, point: 350, xp: 125, callback: _onResetGame);
      } else {
        GameController.calcGameTime();
        Utils.gameFailed(context, xp: 75, callback: _onResetGame);
      }
    });
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

  // 提示弹窗
  _onToast(String text) {
    setState(() {
      _toastText = text;
      _showToast = true;
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() => _showToast = false);
    });
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
        ZoomIn(child: Image.asset('assets/images/game_nebula_rush/table.png')),
        Positioned(
          top: 70 * MediaQuery.of(context).size.width / 402,
          child: FlipInY(child: PersonBox(name: 'Dealer', point: _dealerStand && _playerStand ? _calcListPoint(_dealerList) : _dealerList.isEmpty ? 0 : _calcListPoint([_dealerList[0]])))
        ),
        Positioned(
          bottom: 110 * MediaQuery.of(context).size.width / 402,
          child: FlipInY(child: PersonBox(name: 'Player', point: _calcListPoint(_playerList)))
        ),
        Positioned(
          top: (130) * MediaQuery.of(context).size.width / 402,
          child: ZoomIn(child: SizedBox(
            width: 260 * MediaQuery.of(context).size.width / 402,
            height: 320 * MediaQuery.of(context).size.width / 402,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(_dealerList.length, (index) => SlideInUp(
                    child: index == 0 ?
                      CardItem(_dealerList[index])
                      : _dealerStand && _playerStand ? FlipInY(child: CardItem(_dealerList[index])) : Image.asset('assets/icons/poker_back.png', width: 42)
                  )),
                ),
                CardGroup(),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(_playerList.length, (index) => SlideInDown(child: CardItem(_playerList[index]))),
                ),
              ]
            ),
          ))
        ),
        

        // 提示
        Positioned(
          top: MediaQuery.of(context).size.width / 402 * 310 - 60,
          child: FlipInX(
            animate: _showToast,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 370 * 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/game_nebula_rush/toast_bg.png'), fit: BoxFit.cover)
              ),
              child: Text(_toastText, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))
            )
          )
        ),
        // 爆牌
        _burstToast ? Positioned(
          top: MediaQuery.of(context).size.width / 402 * 310 - 60,
          child: FlipInX(child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/game_nebula_rush/toast_bust.png', fit: BoxFit.cover),
          ))
        ) : Container(),
        // 黑杰克
        _someonBlackJack ? Positioned(
          top: MediaQuery.of(context).size.width / 402 * 310 - 60,
          child: FlipInX(child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/game_nebula_rush/toast_black_jack.png', fit: BoxFit.cover),
          ))
        ) : Container(),
        // 结果
        _resultToast ? Positioned(
          top: MediaQuery.of(context).size.width / 402 * 310 - 60,
          child: FlipInX(child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/game_nebula_rush/toast_$_result.png', fit: BoxFit.cover),
          ))
        ) : Container(),
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
  Widget CardGroup() {
    return SizedBox(
      width: 42,
      height: 63,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(54, (index) => Positioned(
          left: 0.1 * (index - 27),
          bottom: 0.05 * (index - 27),
          child: _wobble ? Wobble(
            delay: Duration(milliseconds: 4 * index),
            child: Image.asset('assets/icons/poker_back.png', width: 42)
          ) : Image.asset('assets/icons/poker_back.png', width: 42)
        ))
      ),
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
        GradientBtn(text: 'Stand', colors: [Color(0xFF2BB100), Color(0xFF74EA4E)], func: !_playable || _playerStand || _someoneBurst ? null : _onStand),
        SizedBox(width: 16),
        GradientBtn(text: 'Hit', colors: [Color(0xFFFF8743), Color(0xFFFFAA1C)], func: !_playable || _playerStand || _someoneBurst ? null : () {
          _addPlayerPoker(0);
        }),
      ]) : Row(children: [GradientBtn(text: 'Start Game ($_startFee)', colors: [Color(0xFFFF8743), Color(0xFFFFAA1C)], func: _onStart)]),
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