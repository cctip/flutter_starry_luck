// ignore_for_file: deprecated_member_use

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

  // 游戏成功
  static void gameSuccess(BuildContext context, { required int point, required int xp, Function? callback }) {
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
              Opacity(opacity: 0.5, child: Image.asset('assets/images/bg/musk.png')),
              Positioned(
                top: 200,
                child: Container(
                  width: 338,
                  height: 439,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/bg/success.png'))
                  ),
                  child: Column(children: [
                    SizedBox(height: 200),
                    Text('Congratulations on your win!', style: TextStyle(color: Colors.white, fontSize: 16)),
                    Container(
                      width: 242,
                      height: 78,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
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
                          ),
                          Column(
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
                          ),
                        ]
                      ),
                    ),
                    PrimaryBtn(
                      width: 102,
                      height: 40,
                      radius: 8,
                      text: 'Claim',
                      func: () {
                        UserController.increasePoints(point);
                        UserController.increaseXP(xp);
                        if (callback != null) {
                          Navigator.of(context).pop();
                          callback();
                        } else {
                          Navigator.of(context).popUntil(ModalRoute.withName('/'));
                        }
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
  // 游戏失败
  static void gameFailed(BuildContext context, { int? point, required int xp, Function? callback }) {
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
              // Opacity(opacity: 0.5, child: Image.asset('assets/images/bg/musk.png')),
              Positioned(
                top: 200,
                child: Container(
                  width: 338,
                  height: 439,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/bg/failed.png'))
                  ),
                  child: Column(children: [
                    SizedBox(height: 200),
                    Text('One step closer to greatness', style: TextStyle(color: Colors.white, fontSize: 16)),
                    Container(
                      width: 242,
                      height: 78,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
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
                          ),
                        ]
                      ),
                    ),
                    PrimaryBtn(
                      width: 102,
                      height: 40,
                      radius: 8,
                      text: 'Claim',
                      func: () {
                        UserController.increaseXP(xp);
                        if (callback != null) {
                          Navigator.of(context).pop();
                          callback();
                        } else {
                          Navigator.of(context).popUntil(ModalRoute.withName('/'));
                        }
                      }
                    )
                  ]),
                )
              ),
            ],
          ))
        )
      )
    );
  }
}