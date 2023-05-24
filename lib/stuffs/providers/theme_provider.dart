import 'package:flutter/material.dart';
import 'package:saper/stuffs/constants.dart';

class ThemeProvider extends ChangeNotifier {
  Color themeColor = kOrangeColor;
  Color themeBackgroundColor = kColorBackGround1;

  void themeOrange() {
    themeColor = kOrangeColor;
    themeBackgroundColor = kColorBackGround1;
    notifyListeners();
  }

  void themeBlue() {
    themeColor = kBlueColor;
    themeBackgroundColor = kColorBackGround2;
    notifyListeners();
  }

  void themeGreen() {
    themeColor = kGreenColor;
    themeBackgroundColor = kColorBackGround3;
    notifyListeners();
  }
}