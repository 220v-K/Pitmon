import 'package:flutter/material.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:pitmon_test/util/colors.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:flutter_blue/flutter_blue.dart';

class exercisePage extends StatefulWidget {
  const exercisePage({Key? key}) : super(key: key);

  @override
  _exercisePageState createState() => _exercisePageState();
}

//운동시작, 운동종료, 운동방법

class _exercisePageState extends State<exercisePage> {
  final FlutterBlue device = FlutterBlue.instance;
  String btInput = '';
  String btOutput = '';

  @override
  Widget build(BuildContext context) {
    //사이즈 조정용 변수
    final Size size = MediaQuery.of(context).size;
    Size centerButtonSize = Size(size.width * 0.82, 30);
    //블루투스 연결된 device 주소 저장.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGreen,
        elevation: 0,
        title: const Center(
          child: Text('Exercise',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'Bluetooth Input',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                ), //Count 횟수, 블루투스에서 받아오는 메시지 추후 입력
              ),
            ),
            Container(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    //버튼 누를 시 실행
                  },
                  style: buildDoubleButtonStyle(lightBlue, centerButtonSize),
                  child: const Text(
                    '입력 완료',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
