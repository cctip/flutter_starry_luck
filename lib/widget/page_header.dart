import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({super.key, required this.title, required this.rule});
  final String title;
  final String rule;

  @override
  State<PageHeader> createState() => PageHeaderState();
}

class PageHeaderState extends State<PageHeader> {
  // 规则
  _showRule() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (_) => Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 32),
            decoration: BoxDecoration(
              color: Color(0xFF212121)
            ),
            child: Column(
              children: [
                Image.asset('assets/images/rules/slider.png'),
                Image.asset('assets/images/rules/${widget.rule}.png'),
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF191919),
      child: Container(
        height: 64 + MediaQuery.of(context).padding.top,
        padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
            ),
            SizedBox(width: 8),
            Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(width: 8),
            GestureDetector(
              onTap: _showRule,
              child: Image.asset('assets/icons/icon_info.png', width: 16),
            ),
            Spacer(),
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
                  Text('1000', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFAA1C), Color(0xFFFF8743)],
                  stops: [0, 1], // 调整渐变范围
                ),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Color(0xFF191919),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Image.asset('assets/images/avator/avator.png'),
              ),
            )
          ],
        ),
      )
    );
  }
}