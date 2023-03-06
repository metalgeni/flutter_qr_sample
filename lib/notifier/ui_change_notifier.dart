import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UIChangeNotifier with ChangeNotifier {
  bool isUseSytemSet = false;

  bool isDarkmode = false;
  bool isCupertino = false;
  bool isUseSystemFontSize = true;
  double fontSize = 0;
  ThemeMode themeMode = ThemeMode.system;
  Brightness brightness = Brightness.light;
  bool isPressQRDetect = false;

  RefreshSystemSetting(bool _isSystemSet) {
    isUseSytemSet = _isSystemSet;
    notifyListeners();
  }

  RefreshDarkMode(bool _isDarkmode) {
    isDarkmode = _isDarkmode;
    brightness = _isDarkmode ? Brightness.dark : Brightness.light;

    notifyListeners();
  }

  RefreshCupertino(bool _isCupertino) {
    isCupertino = _isCupertino;
    notifyListeners();
  }

  RefreshUseSystemFontSize(bool _isUseSystemFontSize) {
    isUseSystemFontSize = _isUseSystemFontSize;
    notifyListeners();
  }

  RefreshUseQRDetect(bool _isQRDetect) {
    isPressQRDetect = _isQRDetect;
    notifyListeners();
  }
}
