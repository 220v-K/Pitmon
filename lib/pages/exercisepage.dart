import 'package:flutter/material.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';
import 'package:pitmon_test/util/helper.dart';
import 'package:pitmon_test/util/colors.dart';
import 'package:flutter_blue/flutter_blue.dart';

class exercisePage extends StatefulWidget {
  const exercisePage({Key? key}) : super(key: key);

  @override
  _exercisePageState createState() => _exercisePageState();
}

//운동시작, 운동종료, 운동방법

class _exercisePageState extends State<exercisePage> {
  final FlutterBlue flutterBlue =
      FlutterBlue.instance; //Bluetooth instance Declaration
  String btInput = '';
  String btOutput = '';

  @override
  Widget build(BuildContext context) {
    var service = Provider.of<userData>(context, listen: false).service;

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
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Center(
              child: Text(
                'Bluetooth Input',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
              ), //Count 횟수, 블루투스에서 받아오는 메시지 추후 입력
            ),
          )),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
