import 'package:flutter/material.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/pages/ChatPage.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:pitmon_test/util/colors.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

class heartbeat extends StatefulWidget {
  const heartbeat({Key? key}) : super(key: key);

  @override
  _heartbeatPage createState() => _heartbeatPage();
}

//운동시작, 운동종료, 운동방법

class _heartbeatPage extends State<heartbeat> {
  late final BluetoothDevice device;
  String btInput = '';
  String btOutput = '';
  int count = 0;

  @override
  Widget build(BuildContext context) {
    //사이즈 조정용 변수
    final Size size = MediaQuery.of(context).size;
    Size centerButtonSize = Size(size.width * 0.82, 30);
    //블루투스 연결된 device 저장.
    final device = Provider.of<userData>(context, listen: false).device;
    double beat = Provider.of<userData>(context, listen: false).beat;
    count = Provider.of<userData>(context, listen: false).count;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightGreen,
        elevation: 0,
        title: const Center(
          child: Text('심박수 측정',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
            ),
            Container(
              child: Center(
                child: Text(
                  //카운트
                  '심박수 : $count',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ), //Count 횟수, 블루투스에서 받아오는 메시지 추후 입력
              ),
            ),
            SizedBox(
              width: 1,
              height: 100,
            ),
            Container(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    //버튼 누를 시 실행
                    Provider.of<userData>(context, listen: false)
                        .editFlag('c'); //심작박동 시작이 c
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(server: device)));
                    count = Provider.of<userData>(context, listen: false).count;
                    setState(() {});
                  },
                  style:
                      buildDoubleButtonStyle(lightBlue, centerButtonSize * 2),
                  child: Text(
                    '측정 화면으로',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
              height: 30,
            ),
            Container(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    //버튼 누를 시 실행
                    count = Provider.of<userData>(context, listen: false).count;
                    print(count);

                    setState(() {});
                  },
                  style: buildDoubleButtonStyle(lightBlue, centerButtonSize),
                  child: Text(
                    '새로고침',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
