// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/primary_btn.dart';

class Utils {
  static void toast(BuildContext context, { required message }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // 点击内容区域关闭
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(message, style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 24,
              fontWeight: FontWeight.w700
            ))
          ],
        ),
      )
    );
  }

  // 第一次进入
  static void welcomeBonus(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      globalDialog(context, bg: 'welcome_bouns', text: 'Thanks for joining — here’s a gift!', musk: true, point: 1000, callback: () => UserController.onFirstUse());
    });
  }
  // 抽奖
  static void checkReward(context, point) {
    globalDialog(context, text: 'Boom! Major win unlocked', musk: true, point: point, callback: () => UserController.onFreeSpin());
  }
  // 等级奖励
  static void badgeReward(context, index, point) {
    globalDialog(context, bg: 'well_down', text: 'Your Glory Unlocked', musk: true, point: point, callback: () => UserController.onClaimBadgeReward(index));
  }
  // 游戏成功
  static void gameSuccess(BuildContext context, { required int point, required int xp, Function? callback }) {
    globalDialog(context, bg: 'success', text: 'Congratulations on your win!', musk: true, point: point, xp: xp, callback: callback);
  }
  // 游戏失败
  static void gameFailed(BuildContext context, { int? point, required int xp, Function? callback }) {
    globalDialog(context, bg: 'failed', text: 'One step closer to greatness', point: point, xp: xp, callback: callback);
  }

  static void globalDialog(context, { bg, musk, text, point, xp, callback }) {
    String background = bg ?? 'success';
    String dialogText = text ?? 'Congratulations on your win!';
    List<Widget> content = [];
    if (point != null) {
      content.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Reward', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32), fontSize: 12)),
          SizedBox(height: 8),
          Row(children: [
            Image.asset('assets/icons/gold.png', width: 24),
            SizedBox(width: 4),
            Text('$point', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
          ])
        ]
      ));
    }
    if (xp != null) {
      content.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('XP', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32), fontSize: 12)),
          SizedBox(height: 8),
          Row(children: [
            Image.asset('assets/icons/xp.png', width: 24),
            SizedBox(width: 4),
            Text('$xp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
          ])
        ]
      ));
    }
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false; // 返回 true 允许关闭，false 阻止关闭
        },
        child: Material(
          color: Colors.black38,
          child: BounceIn(child: Stack(
            alignment: Alignment.center,
            children: [
              musk != null ? Opacity(opacity: 0.5, child: Image.asset('assets/images/bg/musk.png')) : Positioned(child: Container()),
              Positioned(
                top: 200,
                child: Container(
                  width: 338,
                  height: 439,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/bg/$background.png'))
                  ),
                  child: Column(children: [
                    SizedBox(height: 200),
                    Text(dialogText, style: TextStyle(color: Colors.white, fontSize: 14)),
                    Container(
                      width: 242,
                      height: 78,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: content
                      ),
                    ),
                    PrimaryBtn(
                      width: 102,
                      height: 40,
                      radius: 8,
                      text: 'Claim',
                      func: () {
                        if (point != null) UserController.increasePoints(point);
                        if (xp != null) UserController.increaseXP(xp);
                        if (callback != null) {
                          callback();
                        }
                        Navigator.of(context).pop();
                      }
                    )
                  ]),
                )
              ),
            ],
          )),
        )
      )
    );
  }
}