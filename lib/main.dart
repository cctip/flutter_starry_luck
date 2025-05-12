import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/pages/check_in.dart';
import 'package:get/get.dart';
import 'common/share_pref.dart';
import 'package:flutter/services.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import 'pages/index.dart';
import 'pages/profile.dart';
import 'pages/settings.dart';
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
      home: FlutterSplashScreen.fadeIn(
        onInit: () => debugPrint("On Init"),
        onEnd: () => debugPrint("On End"),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        childWidget: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/images/splash.png"),
        ),
        nextScreen: const IndexPage(),
      ),
      getPages: [
        GetPage(name: '/check_in', page: () => CheckInPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/settings', page: () => Settings()),

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
