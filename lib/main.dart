import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/share_pref.dart';
import 'package:flutter/services.dart';

import 'pages/index.dart';
import 'pages/profile.dart';
import 'pages/games/galactic_hand.dart';
import 'pages/games/nebula_rush.dart';
import 'pages/games/stellar_gift.dart';
import 'pages/games/frostflare.dart';
import 'pages/games/starflare.dart';
import 'pages/games/quest_roll.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 设置支持的屏幕方向为竖屏（正反方向）
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharePref.init().then((e) => runApp(MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      initialRoute: '/',
      home: IndexPage(),
      getPages: [
        GetPage(name: '/profile', page: () => ProfilePage()),

        GetPage(name: '/galactic_hand', page: () => GalacticHand()),
        GetPage(name: '/nebula_rush', page: () => NebulaRush()),
        GetPage(name: '/stellar_gift', page: () => StellarGift()),
        GetPage(name: '/frostflare', page: () => Frostflare()),
        GetPage(name: '/starflare', page: () => Starflare()),
        GetPage(name: '/quest_roll', page: () => QuestRoll()),
      ],
    );
  }
}
