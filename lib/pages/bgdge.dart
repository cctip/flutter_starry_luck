// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/utils.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:get/get.dart';
import '/widget/page_header.dart';

class BadgePage extends StatefulWidget {
  const BadgePage({super.key});

  @override
  State<BadgePage> createState() => BadgePageState();
}

class BadgePageState extends State<BadgePage> {
  final List _badgeList = ['Sparkling Gem', 'Stardust', 'Sliver Crown', 'Shooting Star', 'Dimond Crown', 'Shinning Star'];
  final List _rewardList = [500, 1000, 1500, 2000, 2500, 3000];
  int get _level => UserController.level.value;
  int get _xp => UserController.xp.value;
  int get _xpUp => UserController.xpUp.value;
  List get _claimList => UserController.claimList;

  _onClaim(index) {
    Utils.badgeReward(context, index, _rewardList[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF212121),
      child: Column(
        children: [
          PageHeader(),
          ContentBox()
        ],
      ),
    );
  }

  Widget ContentBox() {
    return Expanded(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Stack(
          children: [
            Positioned(child: Image.asset('assets/images/badge/card_shadow.png')),
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 58 + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(),
                  SizedBox(height: 32),
                  BadgeList()
                ]
              ),
            ),
          ]
        )
      )
    ]));
  }

  Widget Card() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_badgeList[_level - 1], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Container(
              width: 180,
              height: 12,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xFF313131),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Row(children: [
                Container(
                  width: 176 * ((_xp < _xpUp) ? (_xp / _xpUp) : 1),
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                  ),
                )
              ])
            ),
            SizedBox(height: 4),
            Text('${_xp < 3000 ? _xp : 3000}/$_xpUp', style: TextStyle(color: Colors.white54)),
          ],
        ),
        Stack(children: [
          Image.asset('assets/images/badge/badge_$_level.png', width: 120),
          Positioned(bottom: 0, child: Image.asset('assets/images/badge/shadow_$_level.png', width: 120, height: 11, fit: BoxFit.cover))
        ])
      ],
    );
  }
  
  Widget BadgeList() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(6, (index) => BadgeItem(index)),
    );
  }
  Widget BadgeItem(index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: 242,
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(child: Stack(
                alignment: Alignment.center,
                children: [
                  _level > index ? Image.asset('assets/images/badge/mask_${index+1}.png') : SizedBox(height: (MediaQuery.of(context).size.width - 48) / 2 * 363 / 531),
                  Image.asset('assets/images/badge/badge_${index+1}${_level > index ? '' : '_gray'}.png', width: 80),
                  Positioned(bottom: 18, child: _level > index ? Image.asset('assets/images/badge/shadow_${index+1}.png', width: 60) : Container())
                ]
              )),
              Column(children: [
                SizedBox(height: 108),
                Text(_badgeList[index], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 12),
                Container(
                  width: 150,
                  height: 40,
                  padding: EdgeInsets.only(left: 12, right: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF313131),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Text('Reward', style: TextStyle(color: Colors.white30, fontSize: 12)),
                      Spacer(),
                      Text('${_rewardList[index]}', style: TextStyle(color: _level > index ? Colors.white : Colors.white30, fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(width: 2),
                      Image.asset('assets/icons/gold.png', width: 32)
                    ],
                  ),
                ),
                Expanded(child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _level - 1 > index || _xp >= 3000 ? Obx(() => Container(
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: _claimList[index] ? [Colors.transparent, Colors.transparent] : [Color(0xFFFF8743), Color(0xFFFFAA1C)],
                            stops: [0.5, 1], // 调整渐变范围
                          ),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor: Color(0xFF3AD164),
                            disabledBackgroundColor: Color.fromRGBO(58, 209, 100, 0.15),
                            shadowColor: Colors.transparent,
                            overlayColor: Colors.black26,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: _claimList[index] ? null : () => _onClaim(index),
                          child: Text(_claimList[index] ? 'Completed' : 'Claim', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                        ),
                      )) : LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: constraints.maxWidth),
                              child: Container(
                                height: 10,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Color(0xFF313131),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(children: [
                                  _level - 1 == index ? Container(
                                    width: constraints.maxWidth * ((_xp < _xpUp) ? (_xp / _xpUp) : 1),
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFAA1C),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                  ) : Container()
                                ]),
                              )
                            )
                          );
                        }
                      ),
                    ]
                  ),
                )),
              ])
            ]
          ),
        ),
        Positioned(bottom: 10, child: Offstage(offstage: _level - 1 > index || _xp >= 3000, child: Text('${_level > index ? (_xp / _xpUp * 100).toStringAsFixed(1) : 0}%', style: TextStyle(color: Colors.white60, fontSize: 11, height: 1)))),
        Positioned(
          top: 0,
          right: 0,
          child: Offstage(
            offstage: _level - 1 != index,
            child: Container(
              height: 18,
              width: 97,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 135, 67, 0.15),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), topRight: Radius.circular(8))
              ),
              child: Text('Current level', style: TextStyle(color: Color(0xFFFFAA1C), fontSize: 11)),
            )
          )
        )
      ],
    );
  }
}