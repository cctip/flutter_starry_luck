import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => UserCardState();
}

class UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}