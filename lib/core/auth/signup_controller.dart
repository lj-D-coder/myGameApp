import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  BuildContext? context;

  @override
  void onInit() {
    context = Get.context;
    super.onInit();
  }

  bool verifyInput(String name, String phone) {
    if (name.isNotEmpty && phone.isNotEmpty) {
      return true;
    }
    return false;
  }

  // Future<bool> signUp(String name, String phone) async {

  // }
}
