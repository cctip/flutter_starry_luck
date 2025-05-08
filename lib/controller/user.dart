import 'package:intl/intl.dart';
import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class UserController extends GetxController {
  static final first = RxBool(true); // 第一次打开
  static final level = RxInt(1); // 等级
  static final xpList = [500, 1000, 1500, 2000, 2000, 3000];
  static final xp = RxInt(0); // 当前经验
  static final xpAll = RxInt(0); // 所有经验
  static final xpUp = RxInt(0); // 升级所需经验
  static final points = RxInt(0); // 积分
  static final claimList = RxList([]);

  // 初始化
  static init() {
    level.value = SharePref.getInt('level') ?? 1;
    xp.value = SharePref.getInt('xp') ?? 0;
    xpAll.value = SharePref.getInt('xpAll') ?? 0;
    xpUp.value = xpList[level.value];
    points.value = SharePref.getInt('points') ?? 0;
    first.value = SharePref.getBool('first') == null ? true : false;
    onInitBadge();
  }

  // 第一次使用
  static onFirstUse() {
    increasePoints(1000);
    first.value = false;
    SharePref.setBool('first', false);
  }

  // 初始化徽章奖励
  static onInitBadge() {
    claimList.value = [
      SharePref.getBool('claimed_0') ?? false,
      SharePref.getBool('claimed_1') ?? false,
      SharePref.getBool('claimed_2') ?? false,
      SharePref.getBool('claimed_3') ?? false,
      SharePref.getBool('claimed_4') ?? false,
      SharePref.getBool('claimed_5') ?? false,
    ];
  }
  // 领取徽章奖励
  static onClaimBadgeReward(index, points) {
    increasePoints(points);
    SharePref.setBool('claimed_$index', true);
    onInitBadge();
  }

  //增加经验
  static increaseXP(int value) {
    xpAll.value += value;
    if (level.value < 6) {
      int xpNow = xp.value + value;
      int xpUpNow = xpList[level.value];
      if (xpNow >= xpUpNow) {
        xp.value = xpNow - xpUpNow;
        level.value++;
        xpUp.value = xpList[level.value];
        SharePref.setInt('level', level.value);
      } else {
        xp.value += value;
      }
    } else {
      xp.value += value;
    }
    SharePref.setInt('xp', xp.value);
    SharePref.setInt('xpAll', xpAll.value);
  }
  // 增加积分
  static increasePoints(int value) {
    points.value += value;
    SharePref.setInt('points', points.value);
  }
  // 减少积分
  static decreasePoints(int value) {
    points.value -= value;
    SharePref.setInt('points', points.value);
  }
}