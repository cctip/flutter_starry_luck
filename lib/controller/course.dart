import '/common/share_pref.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

var formater = DateFormat('yyyy-MM-dd');

class CourseController extends GetxController {
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
  
  // 章节>课程>主题>文章 chapter>lesson>topic>section
  static final readedList = RxString(''); // 已阅读列表
  static final favorites = RxString(''); // 1_1_1: 第1章_第1课_主题1

  static final curChapter = RxInt(0); // 当前章节
  static final deepChapter = RxInt(0); // 已完成到章节
  static final readLesson = RxInt(0); // 当前阅读课程
  static final readTopic = RxInt(0); // 当前阅读主题
  static final readSection = RxInt(0); // 当前阅读文章

  static init() {
    readedList.value = SharePref.getString('readedList') ?? '';
    favorites.value = SharePref.getString('favorites') ?? '';
    curChapter.value = SharePref.getInt('curChapter') ?? 0;
    deepChapter.value = SharePref.getInt('deepChapter') ?? 0;
  }

  // 收藏
  static setFavorite(index) {
    List<String> list = favorites.value.split(',');
    String itemStr = '${curChapter}_${readLesson}_$index';
    if (list.contains(itemStr)) {
      list.remove(itemStr);
    } else {
      list.add(itemStr);
    }
    favorites.value = listToString(list);
    SharePref.setString('favorites', favorites.value);
  }
  // 取消收藏
  static cancleFavorite(itemStr) {
    List<String> list = favorites.value.split(',');
    list.remove(itemStr);
    favorites.value = listToString(list);
    SharePref.setString('favorites', favorites.value);
  }
  static String listToString(List<String> list) {
    String result = '';
    for (var str in list) {
      result = result == '' ? str : '$result,$str';
    }
    return result.toString();
  }


  // 修改章节
  static onChangeChapter(index) {
    curChapter.value = index;
    SharePref.setInt('curChapter', curChapter.value);
    onReadLesson(0);
  }
  // 阅读课程
  static onReadLesson(index) {
    readLesson.value = index;
    readTopic.value = 0;
    readSection.value = 0;
  }
  // 阅读主题
  static onReadTopic(index) {
    readTopic.value = index;
  }
  // 阅读文章
  static onReadSection(index) {
    readSection.value = index;
  }
  // 文章阅读完成
  static onReadedSection(index) {
    String today = formater.format(DateTime.now()); // 今天
    SharePref.setString('readTime', today);
    List<String> list = readedList.value.split(',');
    String itemStr = '${curChapter}_${readLesson}_${readTopic}_$index';
    if (readedList.value == '') {
      readedList.value += itemStr;
      SharePref.setString('readedList', readedList.value);
    } else if (!list.contains(itemStr)) {
      readedList.value += ',$itemStr';
      SharePref.setString('readedList', readedList.value);
    }
  }
}