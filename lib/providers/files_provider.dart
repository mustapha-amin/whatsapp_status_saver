import 'dart:io';

import 'package:flutter/material.dart';

class FilesProvider extends ChangeNotifier {
  List<String> whatsappStatusesPaths = [];

  void updateStatuses(String? newStatusPath, {bool isAddition = true}) {
    isAddition
        ? whatsappStatusesPaths.add(newStatusPath!)
        : whatsappStatusesPaths.remove(newStatusPath);
    notifyListeners();
  }
}
