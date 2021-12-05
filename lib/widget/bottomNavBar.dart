import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitmon_test/pages/BluetoothDeviceListEntry.dart';
import 'package:pitmon_test/pages/SelectBondedDevicePage.dart';
import 'package:pitmon_test/pages/exercisepage.dart';
import 'package:pitmon_test/pages/homepage.dart';
import 'package:pitmon_test/pages/heartbeat.dart';
import 'package:pitmon_test/constants.dart';
import 'package:provider/provider.dart';
import 'package:pitmon_test/providers/userdata.dart';

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
      // decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //   BoxShadow(
      //     offset: Offset(0, -10),
      //     blurRadius: 30,
      //     color: kPrimaryColor.withOpacity(0.4),
      //   ),
      // ]),
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
              //블루투스 연결 화면으로 이동 후 선택된 블루투스 디바이스 정보를 Provider에 저장.
              selectDeviceSaving(context);
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/fitness.svg",
              width: 25,
              height: 25,
            ),
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

selectDeviceSaving(BuildContext context) async {
  // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
  // Navigator.pop이 호출된 이후 완료될 것입니다.
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (device) => SelectBondedDevicePage()),
  );
  Provider.of<userData>(context, listen: false).editDevice(result);
}
