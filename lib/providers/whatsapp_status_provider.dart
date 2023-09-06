import 'dart:io';

import 'package:flutter/material.dart';

class WhatsappStatusProvider extends ChangeNotifier {
  List<String> whatsappStatusesPaths = [];

  void updateStatuses(String? newStatusPath, {bool isAddition = true}) {
    isAddition
        ? whatsappStatusesPaths.add(newStatusPath!)
        : whatsappStatusesPaths.remove(newStatusPath);
    notifyListeners();
  }
}
