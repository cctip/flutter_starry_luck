// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

import '/common/share_pref.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd HH:mm:ss');

class GameController extends GetxController {
  static final game_gh_played = RxInt(0);
  static final game_nr_played = RxInt(0);
  static final game_sg_played = RxInt(0);
  static final game_ff_played = RxInt(0);
  static final game_sf_played = RxInt(0);
  static final game_qr_played = RxInt(0);
  static final game_gh_won = RxInt(0);
  static final game_nr_won = RxInt(0);
  static final game_sg_won = RxInt(0);
  static final game_ff_won = RxInt(0);
  static final game_sf_won = RxInt(0);
  static final game_qr_won = RxInt(0);

  static final game_palySeconds = RxInt(0); // 游玩时间-秒
  static final game_palyTime = RxDouble(0); // 游玩时间-小时

  // 初始化
  static init() {
    game_palySeconds.value = SharePref.getInt('game_palySeconds') ?? 0;
    game_palyTime.value = game_palySeconds.value / 3600;
    
    game_gh_played.value = SharePref.getInt('game_gh_played') ?? 0;
    game_nr_played.value = SharePref.getInt('game_nr_played') ?? 0;
    game_sg_played.value = SharePref.getInt('game_sg_played') ?? 0;
    game_ff_played.value = SharePref.getInt('game_ff_played') ?? 0;
    game_sf_played.value = SharePref.getInt('game_sf_played') ?? 0;
    game_qr_played.value = SharePref.getInt('game_qr_played') ?? 0;
    game_gh_won.value = SharePref.getInt('game_gh_won') ?? 0;
    game_nr_won.value = SharePref.getInt('game_nr_won') ?? 0;
    game_sg_won.value = SharePref.getInt('game_sg_won') ?? 0;
    game_ff_won.value = SharePref.getInt('game_ff_won') ?? 0;
    game_sf_won.value = SharePref.getInt('game_sf_won') ?? 0;
    game_qr_won.value = SharePref.getInt('game_qr_won') ?? 0;
  }

  // 开始游戏
  static startGame(String type) {
    String now = formater.format(DateTime.now());
    SharePref.setString('gameStartTime', now);
    int count = SharePref.getInt('game_${type}_played') ?? 0;
    SharePref.setInt('game_${type}_played', count + 1);
    init();
  }
  // 赢得游戏
  static winGame(String type) {
    calcGameTime();
    int count = SharePref.getInt('game_${type}_won') ?? 0;
    SharePref.setInt('game_${type}_won', count + 1);
    init();
  }
  // 计算时间
  static calcGameTime() {
    String startTime = SharePref.getString('gameStartTime');
    DateTime start = DateTime.parse(startTime);
    DateTime now = DateTime.now();
    int diffTime = now.difference(start).inSeconds;
    SharePref.setInt('game_palySeconds', game_palySeconds.value + diffTime);
  }
}