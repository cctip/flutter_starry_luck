// ignore_for_file: non_constant_identifier_names

import '/common/share_pref.dart';
import 'package:get/get.dart';

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

  // 初始化
  static init() {
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
    int count = SharePref.getInt('game_${type}_played') ?? 0;
    SharePref.setInt('game_${type}_played', count + 1);
    init();
  }
  // 赢得游戏
  static winGame(String type) {
    int count = SharePref.getInt('game_${type}_won') ?? 0;
    SharePref.setInt('game_${type}_won', count + 1);
    init();
  }
}