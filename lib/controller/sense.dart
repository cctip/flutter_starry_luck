import '/common/share_pref.dart';
import 'package:get/get.dart';

class SenseController extends GetxController {
  static final List<String> chapters = [
    'What Is Cryptocurrency?',
    'Basics of Bitcoin',
    'The History and Evolution of Cryptocurrency',
    'Types of Cryptocurrency Wallets and How to Create One',
    'How to Buy and Sell Cryptocurrency',
    'Understanding Basic Security Measures to Avoid Scams and Phishing Attacks',
    'Basic Chart Analysis in the Cryptocurrency Market',
    'Explaining Common Cryptocurrency Terminology and Abbreviations',
  ];
  static final readIndex = RxInt(0); // 当前阅读常识
  static final isReaded = RxBool(false);
  static final senseReaded_1 = RxBool(false);
  static final senseReaded_2 = RxBool(false);
  static final senseReaded_3 = RxBool(false);
  static final senseReaded_4 = RxBool(false);
  static final senseReaded_5 = RxBool(false);
  static final senseReaded_6 = RxBool(false);
  static final senseReaded_7 = RxBool(false);

  static init() {
    senseReaded_1.value = SharePref.getBool('senseReaded_1') ?? false;
    senseReaded_2.value = SharePref.getBool('senseReaded_2') ?? false;
    senseReaded_3.value = SharePref.getBool('senseReaded_3') ?? false;
    senseReaded_4.value = SharePref.getBool('senseReaded_4') ?? false;
    senseReaded_5.value = SharePref.getBool('senseReaded_5') ?? false;
    senseReaded_6.value = SharePref.getBool('senseReaded_6') ?? false;
    senseReaded_7.value = SharePref.getBool('senseReaded_7') ?? false;
  }

  static readSense(index) {
    readIndex.value = index;
    switch(index) {
      case 0: isReaded.value = senseReaded_1.value; break;
      case 1: isReaded.value = senseReaded_2.value; break;
      case 2: isReaded.value = senseReaded_3.value; break;
      case 3: isReaded.value = senseReaded_4.value; break;
      case 4: isReaded.value = senseReaded_5.value; break;
      case 5: isReaded.value = senseReaded_6.value; break;
      case 6: isReaded.value = senseReaded_7.value; break;
    }
  }
  static finishSense() {
    switch(readIndex.value) {
      case 0: senseReaded_1.value = true; break;
      case 1: senseReaded_2.value = true; break;
      case 2: senseReaded_3.value = true; break;
      case 3: senseReaded_4.value = true; break;
      case 4: senseReaded_5.value = true; break;
      case 5: senseReaded_6.value = true; break;
      case 6: senseReaded_7.value = true; break;
    }
    isReaded.value = true;
    SharePref.setBool('senseReaded_${readIndex.value + 1}', true);
  }
}