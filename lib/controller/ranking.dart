import 'dart:math';

import '/common/eventbus.dart';
import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';
import '/controller/user.dart';

var formater = DateFormat('yyyy-MM-dd');

class RankingController extends GetxController {
  static final initCount = RxInt(0);
  static final rankingMap = RxMap();

  // 初始化
  static init() {
    if (UserController.xp.value != 0) {
      rankingMap['Noob101'] = {
        'avator': 'avator_4',
        'xp': UserController.xp.value
      };
    }
    initCount.value = SharePref.getInt('initCount') ?? 0;
    if (initCount.value != 0) {
      for (int i = 0; i < 10; i++) {
        String name = 'Noob${i + 102}';
        if (SharePref.getInt(name) != null) {
          rankingMap[name] = {
            'avator': 'avator_${Random().nextInt(20) + 1}',
            'xp': SharePref.getInt(name)
          };
        }
      }
      int noobCount = Random().nextInt(10);
      String name = 'Noob${noobCount + 102}';
      int newVal = (Random().nextInt(10) + 1) * 300 + Random().nextInt(100);
      if (rankingMap[name] != null) {
        rankingMap[name]['xp'] = SharePref.getInt(name) + newVal;
      } else {
        rankingMap[name] = {
          'avator': 'avator_${Random().nextInt(20) + 1}',
          'xp': newVal
        };
      }
      SharePref.setInt(name, rankingMap[name]['xp']);
    }
    initCount.value++;
    SharePref.setInt('initCount', initCount.value);
    bus.emit('calcRank');
  }
}