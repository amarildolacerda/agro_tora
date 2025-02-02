


import 'package:flutter/material.dart';

class AreaChangeNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

final AreaChangeNotifier areaNotifyChanged = AreaChangeNotifier();