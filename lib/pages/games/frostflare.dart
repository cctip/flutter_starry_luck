// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/primary_btn.dart';
import '/widget/detail_header.dart';

class Frostflare extends StatefulWidget {
  const Frostflare({super.key});

  @override
  State<Frostflare> createState() => FrostflareState();
}

class FrostflareState extends State<Frostflare> {
  final ScrollController _scrollController = ScrollController();
  final int _startFee = 150; // 游戏开始花费
  bool _start = false;
  bool _ending = false;
  final List _list = [];
  int _floor = 0;
  final List _reachedList = [];

  @override
  initState() {
    super.initState();
    for (int i = 0; i < 8; i++) {
      _addRow();
    }
  }
  // 新增一列盲盒
  _addRow() {
    int truthIndex = Random().nextInt(3);
    setState(() {
      _list.add([
        truthIndex == 0 ? 1 : 0,
        truthIndex == 1 ? 1 : 0,
        truthIndex == 2 ? 1 : 0,
      ]);
    });
    // 确保在布局完成后滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 使用动画滚动
      _scrollController.animateTo(
        (_list.length - 1) * 55,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // 重置游戏
  _onResetGame() {
    setState(() {
      _start = false;
      _ending = false;
      _list.clear();
      _floor = 0;
      _reachedList.clear();
      for (int i = 0; i < 8; i++) {
        _addRow();
      }
    });
  }

  // 开始游戏
  _onStart() {
    if (UserController.points.value >= _startFee) {
      UserController.decreasePoints(_startFee);
      if (_start) return;
      setState(() => _start = true);
      _floor = 1;
    } else {
      Utils.toast(context, message: 'Insufficient points');
    }
  }
  _onChooseBox(index) {
    if (_ending) return;
    int type = _list[_reachedList.length][index];
    setState(() {
      _floor++;
      _reachedList.add(index);
    });
    if (type == 1) {
      if (_floor > 6) _addRow();
    } else {
      setState(() => _ending = true);
      Future.delayed(Duration(milliseconds: 500), () {
        Utils.gameFailed(context, xp: 50, callback: _onResetGame);
      });
    }
  }

  // 领取奖励
  _onClaim() {
    if (_ending) return;
    Utils.gameSuccess(context, point: 50 * _reachedList.length, xp: 100 + 5 * _reachedList.length, callback: _onResetGame);
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            DetailHeader(title: 'Frostflare', rule: 'frostflare'),
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
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/game_frostflare/bg.png'), fit: BoxFit.cover)
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: _list.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(top: 7),
          child: Row(
            spacing: 7,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (i) => BoxItem(index, i))
          ),
        ),
        reverse: true,
      )
    );
  }
  Widget BoxItem(index, item) {
    // 已经翻开的方块
    final box_reached = ZoomIn(child: Image.asset('assets/images/game_frostflare/box_${_list[index][item] == 1? 'true' : 'false'}.png', height: 48));
    // 没有翻开的方块
    final box_blind = ZoomIn(child: GestureDetector(
      onTap: _reachedList.length == index ? () => _onChooseBox(item) : null,
      child: Image.asset('assets/images/game_frostflare/box_blind.png', height: 48)
    ));
    // 黑色禁止方块
    final box_disabled = ZoomIn(child: Image.asset('assets/images/game_frostflare/box_disabled.png', height: 48));
    return (_reachedList.length > index && _reachedList[index] == item) ? box_reached : (_floor > index ? box_blind : box_disabled);
  }

  Widget DataBox() {
    return Expanded(child: Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Color(0xFF212121),
      child: Column(children: [
        Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reached:', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.64), fontSize: 14, fontWeight: FontWeight.w400)),
              Text('Floor ${_reachedList.length}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
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