import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UIChangeNotifier with ChangeNotifier {
  //double h = MediaQuery.of(context).textScaleFactor;

  bool isCupertino = false;
  bool isUseSystemFontSize = true;
  double fontSize = 0;
  ThemeMode themeMode = ThemeMode.system;

  bool isQRDetect = false;

  // RefreshData(int index) async {
  //   notifyListeners();
  // }

  RefreshCupertino(bool _isCupertino) {
    isCupertino = _isCupertino;
    notifyListeners();
  }

  RefreshUseSystemFontSize(bool _isUseSystemFontSize) {
    isUseSystemFontSize = _isUseSystemFontSize;
    notifyListeners();
  }

  RefreshUseQRDetect(bool _isQRDetect) {
    isQRDetect = _isQRDetect;
    notifyListeners();
  }
}
