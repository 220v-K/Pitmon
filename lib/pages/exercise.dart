import 'package:flutter/material.dart';
import 'package:pitmon_test/constants.dart';
import 'package:pitmon_test/widget/bottomNavBar.dart';

class exercise extends StatelessWidget {
  const exercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
