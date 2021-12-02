import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class userData with ChangeNotifier {
  int userAge = 0;
  double userWeight = 0.0;
  int exp = 0;
  int level = 1;

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
}
