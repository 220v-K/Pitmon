import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:pitmon_test/util/colors.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int age = 0;
  double weight = 0.0;
  double userExp = 0;
  int userLevel = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Size centerButtonSize = Size(size.width * 0.82, 30);
    userExp = Provider.of<userData>(context, listen: false).exp;
    userLevel = Provider.of<userData>(context, listen: false).level;
    return Scaffold(
      //상단 바
      appBar: AppBar(
        backgroundColor: lightGreen,
        elevation: 0,
        title: Center(
          child: const Text('Pitmon',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
      //텍스트 입력 칸
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            if (userLevel == 1)
              Container(
                  child: Center(
                      child: Image.asset("assets/images/level1.jpg",
                          width: 200, height: 200, fit: BoxFit.contain))),
            if (userLevel == 2)
              Container(
                  child: Center(
                      child: Image.asset("assets/images/level2.jpg",
                          width: 200, height: 200, fit: BoxFit.contain))),
            if (userLevel == 3)
              Container(
                  child: Center(
                      child: Image.asset("assets/images/level3.jpg",
                          width: 200, height: 200, fit: BoxFit.contain))),
            Container(
                child: Center(
              child: Text(
                '레벨 : $userLevel\n경험치 : ${userExp.toStringAsFixed(3)}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )),
            Container(
              //나이 입력 텍스트박스
              height: 70,
              width: 700,
              margin: EdgeInsets.only(top: 1.0),
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
            Container(
              //누를 시 경험치 +300(테스트용)
              child: Center(
                  child: Column(
                children: [
                  SizedBox(height: 5.0), //간격 조정 사이즈박스
                  TextButton(
                    onPressed: () {
                      double newExp =
                          Provider.of<userData>(context, listen: false).exp +
                              300.0;
                      Provider.of<userData>(context, listen: false)
                          .editExp(newExp);
                      if (userLevel == 1 && newExp > 1000.0) {
                        Provider.of<userData>(context, listen: false)
                            .editlevel(2);
                        newExp = newExp - 1000.0;
                        Provider.of<userData>(context, listen: false)
                            .editExp(newExp);
                      }
                      if (userLevel == 2 && newExp > 2000.0) {
                        Provider.of<userData>(context, listen: false)
                            .editlevel(3);
                        newExp = newExp - 2000.0;
                        Provider.of<userData>(context, listen: false)
                            .editExp(newExp);
                      }
                      setState(() {});
                    },
                    style: buildDoubleButtonStyle(lightBlue, centerButtonSize),
                    child: const Text(
                      '경험치 + 300',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                child: Center(
              child: Text(
                '입력된 나이 : $age\n몸무게 : $weight',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )),
          ],
        ),
      )),

      //하단 네비게이터
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
