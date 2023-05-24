import 'package:flutter/material.dart';

class FlagProvider extends ChangeNotifier {
  int flagCount = 0;

  void flagPlus() {
    flagCount++;
    notifyListeners();
  }

  void flagMinus() {
    flagCount > 0 ? flagCount-- : null;
    notifyListeners();
  }

  void flagRestart() {
    flagCount = 0;
    notifyListeners();
  }

  void flagInit(int minesCount) {
    flagCount = minesCount;
    notifyListeners();
  }
}