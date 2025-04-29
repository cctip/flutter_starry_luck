// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '/widget/page_header.dart';

class GalacticHand extends StatefulWidget {
  const GalacticHand({super.key});

  @override
  State<GalacticHand> createState() => GalacticHandState();
}

class GalacticHandState extends State<GalacticHand> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF191919),
        child: Column(
          children: [
            PageHeader(title: 'Galactic Hand'),
            ContentBox(),
            GuessBox()
          ],
        ),
      ),
    );
  }

  Widget ContentBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 416,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/game_galactic_hand/table.png'), fit: BoxFit.cover)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            child: Container(
              width: 114,
              height: 63,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/game_galactic_hand/card_group.png'))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(33, 33, 33, 0.72),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text('52', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  )
                ]
              )
            )
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/game_galactic_hand/card_hollow.png', width: 72),
                SizedBox(width: 3),
                Image.asset('assets/images/game_galactic_hand/card_hollow.png', width: 72),
                SizedBox(width: 3),
                Image.asset('assets/images/game_galactic_hand/card_hollow.png', width: 72),
                SizedBox(width: 3),
                Image.asset('assets/images/game_galactic_hand/card_hollow.png', width: 72),
                SizedBox(width: 3),
                Image.asset('assets/images/game_galactic_hand/card_hollow.png', width: 72),
              ]
            )
          )
        ],
      ),
    );
  }

  Widget GuessBox() {
    List guessList = ['Pair', 'Two Pair', 'Three of kind', 'Straight', 'Flush', 'Full house', 'Four of kind', 'Straight flush', 'Royal flush'];
    return Container(
      padding: EdgeInsets.only(top: 32, left: 20, right: 20),
      child: Column(children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(guessList.length, (index) => Container(
            width: (MediaQuery.of(context).size.width - 56) / 3,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF313131),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Text(guessList[index], style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.64), fontSize: 16, fontWeight: FontWeight.w600)),
          ))
        ),
        SizedBox(height: 32),
        Image.asset('assets/images/game_galactic_hand/button.png')
      ]),
    );
  }
}