import 'package:flutter/material.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';

class heartbeat extends StatelessWidget {
  const heartbeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
