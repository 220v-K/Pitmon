import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:pitmon_test/util/colors.dart';

class homepage extends StatelessWidget {
  int age = 0;
  double weight = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Size centerButtonSize = Size(size.width * 0.82, 30);
    return Scaffold(
      //상단 바
      appBar: AppBar(
        backgroundColor: lightGreen,
        elevation: 0,
        title: Center(
          child: const Text('사용자 정보 입력',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
      //텍스트 입력 칸
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
                child: Center(child: Image.asset("assets/images/level1.jpg"))),
            Container(
                child: Center(
              child: Text(
                '경험치 : /*exp*/', // --------------------------------------------------------------------------
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            )),
            Container(
              //나이 입력 텍스트박스
              height: 70,
              width: 700,
              margin: EdgeInsets.only(top: 5.0),
              color: Colors.white,
              child: TextField(
                onChanged: (text) {
                  age = int.parse(text);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Your Age'),
              ),
            ),
            Container(
              //몸무게 입력 텍스트박스
              height: 65,
              width: 700,
              color: Colors.white,
              child: TextField(
                onChanged: (text) {
                  weight = double.parse(text);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Your Weight'),
              ),
            ),
            Container(
              //입력 완료
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Provider.of<userData>(context, listen: false).editAge(age);
                    Provider.of<userData>(context, listen: false)
                        .editWeight(weight);
                  },
                  style: buildDoubleButtonStyle(lightBlue, centerButtonSize),
                  child: const Text(
                    '입력 완료',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //하단 네비게이터
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
