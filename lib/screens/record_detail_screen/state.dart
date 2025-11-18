import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecordDetailsState extends GetxController {
  final transactions = [];

  void onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onTapSave() {}

  void onTapDelete() {}
}
