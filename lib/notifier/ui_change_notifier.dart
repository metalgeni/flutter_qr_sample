import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UIChangeNotifier with ChangeNotifier {
  bool isPressQRDetect = false;
  RefreshUseQRDetect(bool _isQRDetect) {
    isPressQRDetect = _isQRDetect;
    notifyListeners();
  }
}
