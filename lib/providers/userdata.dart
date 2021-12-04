import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class userData with ChangeNotifier {
  int userAge = 0;
  double userWeight = 0.0;
  int exp = 0;
  int level = 1;
  int count = 0;
  double beat = 0.0;
  String address = '0';
  String flag = 'd';

  late BluetoothDevice device;

  void editAge(int age) {
    userAge = age;
    notifyListeners();
  }

  void editWeight(double weight) {
    userWeight = weight;
    notifyListeners();
  }

  void editExp(int exp) {
    this.exp = exp;
    notifyListeners();
  }

  void editlevel(int level) {
    this.level = level;
    notifyListeners();
  }

  void editFlag(String flag) {
    this.flag = flag;
    notifyListeners();
  }

  void editCount(int count) {
    this.count = count;
    notifyListeners();
  }

  void editAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  void editBeat(double beat) {
    this.beat = beat;
    notifyListeners();
  }

  void editDevice(BluetoothDevice device) {
    this.device = device;
    notifyListeners();
  }
}
