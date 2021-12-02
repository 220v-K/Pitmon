import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitmon_test/pages/btconnect.dart';
import 'package:pitmon_test/pages/exercisepage.dart';
import 'package:pitmon_test/pages/homepage.dart';
import 'package:pitmon_test/pages/heartbeat.dart';
import 'package:pitmon_test/constants.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: 0,
      ),
      height: 80,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, -10),
          blurRadius: 30,
          color: kPrimaryColor.withOpacity(0.4),
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/home.svg"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => homepage()));
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/bluetooth.svg"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => btconnect()));
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/fitness.svg"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => exercisePage()));
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/heart.svg"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => heartbeat()));
            },
          ),
        ],
      ),
    );
  }
}
