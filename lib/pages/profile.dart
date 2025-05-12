// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/controller/game.dart';
import '/controller/user.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => HomePageState();
}

class HomePageState extends State<ProfilePage> {
  int get _level => UserController.level.value;
  int get _xp => UserController.xp.value;
  int get _xpUp => UserController.xpUp.value;

  final List _tabList = ['Details', 'Statistics'];
  int _curTab = 0;
  int get played_gh => GameController.game_gh_played.value;
  int get played_nr => GameController.game_nr_played.value;
  int get played_sg => GameController.game_sg_played.value;
  int get played_ff => GameController.game_ff_played.value;
  int get played_sf => GameController.game_sf_played.value;
  int get played_qr => GameController.game_qr_played.value;
  int get won_gh => GameController.game_gh_won.value;
  int get won_nr => GameController.game_nr_won.value;
  int get won_sg => GameController.game_sg_won.value;
  int get won_ff => GameController.game_ff_won.value;
  int get won_sf => GameController.game_sf_won.value;
  int get won_qr => GameController.game_qr_won.value;

  double get _playedTime => GameController.game_palyTime.value;
  int get _playedNum => played_gh + played_nr + played_sg + played_ff + played_sf + played_qr;
  int get _wonNum => won_gh + won_nr + won_sg + won_ff + won_sf + won_qr;
  String get _winRate => _playedNum == 0 ? '0' : (_wonNum / _playedNum * 100).toStringAsFixed(2);


  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      color: Color(0xFF212121),
      padding: EdgeInsets.only(bottom: 64),
      child: Column(
        children: [
          HeaderBox(),
          ContentBox()
        ],
      ),
    ));
  }

  Widget HeaderBox() {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).padding.top + 96,
        color: Color(0xFF191919),
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 16, 16, 16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFAA1C), Color(0xFFFF8743)],
                  stops: [0, 1], // 调整渐变范围
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color(0xFF191919),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset('assets/images/avator/avator.png'),
                  ),
                  Positioned(child: Container(
                    width: 64,
                    height: 19,
                    decoration: BoxDecoration(
                      color: Color(0xFF212121),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                    ),
                  )),
                  Positioned(child: Container(
                    width: 64,
                    height: 19,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromRGBO(255, 170, 28, 0.3), Color.fromRGBO(255, 170, 28, 0.3)],
                        stops: [0, 1], // 调整渐变范围
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                    ),
                    child: Text('Lvl.$_level', style: TextStyle(color: Colors.white, fontSize: 16, height: 1)),
                  ))
                ],
              )
            ),
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Color(0xFF282828),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromRGBO(255, 170, 28, 0.1), Color.fromRGBO(255, 135, 67, 0.1)],
                            stops: [0, 1], // 调整渐变范围
                          ),
                        ),
                        child: Image.asset('assets/icons/gold.png'),
                      ),
                      SizedBox(width: 10),
                      Obx(() => Text('${UserController.points.value}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Image.asset('assets/images/badge/badge_$_level.png', width: 24),
                    SizedBox(width: 6),
                    Container(
                      width: 150,
                      height: 10,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color(0xFF313131),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(children: [
                        Container(
                          width: 146 * ((_xp < _xpUp) ? (_xp / _xpUp) : 1),
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFAA1C),
                            borderRadius: BorderRadius.circular(8)
                          ),
                        )
                      ]),
                    ),
                    SizedBox(width: 6),
                    Text('${_xp < 3000 ? (_xp / _xpUp * 100).toStringAsFixed(1) : 100}%', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.64), fontSize: 11))
                  ],
                )
              ]
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed('/settings'),
              child: Image.asset('assets/icons/settings.png', width: 24),
            )
          ],
        )
      ),
      Row(children: List.generate(_tabList.length, (index) => TabItem(index)))
    ]);
  }
  Widget TabItem(index) {
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _curTab = index),
      child: Container(
        width: 100,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _curTab == index ? [Color.fromRGBO(33, 33, 33, 0), Color.fromRGBO(255, 170, 28, 0.3)] : [Color(0xFF212121), Color(0xFF212121)],
            stops: [0, 1], // 调整渐变范围
          ),
          border: Border(bottom: BorderSide(color: _curTab == index ? Color(0xFFFFAA1C) : Color(0xFF313131)))
        ),
        child: Text(_tabList[index], style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
      )
    ));
  }

  Widget ContentBox() {
    return Expanded(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
          child: _curTab == 0 ? DetailsContent() : StatisticsContent()
        )
      )
    ]));
  }
  
  Widget DetailsContent() {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailItem(name: 'Galactic Hand', icon: 'game_galactic_hand', played: played_gh, won: won_gh),
        DetailItem(name: 'Nebula Rush', icon: 'game_nebula_rush', played: played_nr, won: won_nr),
        DetailItem(name: 'Stellar Gift', icon: 'game_stellar_gift', played: played_sg, won: won_sg),
        DetailItem(name: 'Frostflare', icon: 'game_frostflare', played: played_ff, won: won_ff),
        DetailItem(name: 'Starflare', icon: 'game_starflare', played: played_sf, won: won_sf),
        DetailItem(name: 'Quest Roll', icon: 'game_quest_roll', played: played_qr, won: won_qr),
      ]
    );
  }
  Widget DetailItem({ required String name, required String icon, required int played, required int won }) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          Image.asset('assets/images/bg/$icon.png'),
          SizedBox(width: 16),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.64), fontSize: 16)),
              SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Win Rate: ', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32), fontSize: 11, height: 1.2)),
                  Text('${played == 0 ? 0 : (won / played * 100).toStringAsFixed(2)}%', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, height: 1)),
                ],
              ),
              Spacer(),
              LayoutBuilder(
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
                          Container(
                            width: constraints.maxWidth * (played == 0 ? 0 : (won / played)),
                            height: 5,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFAA1C),
                              borderRadius: BorderRadius.circular(8)
                            ),
                          )
                        ]),
                      )
                    )
                  );
                }
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Text('Won: ', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32), fontSize: 11, height: 1.2)),
                  Text('$won', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.64), fontSize: 12, fontWeight: FontWeight.w600, height: 1)),
                  Spacer(),
                  Text('Played: ', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32), fontSize: 11, height: 1.2)),
                  Text('$played', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.64), fontSize: 12, fontWeight: FontWeight.w600, height: 1)),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget StatisticsContent() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: 260,
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Time played', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32))),
              SizedBox(height: 6),
              Obx(() => Text('${_playedTime.toStringAsFixed(2)}h', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: 260,
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Win rate', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32))),
              SizedBox(height: 6),
              Text('$_winRate%', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: 260,
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hands played', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32))),
              SizedBox(height: 6),
              Text('$_playedNum', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: 260,
          decoration: BoxDecoration(
            color: Color(0xFF282828),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hands won', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.32))),
              SizedBox(height: 6),
              Text('$_wonNum', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}