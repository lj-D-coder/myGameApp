import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/admin/admin_dashboard.dart';
import 'package:mygame/core/user_type.dart';
import 'package:mygame/homescreen.dart';

void flowDecider(UserType type) {
  if (type == UserType.player) {
    Get.offAll(() => MyHomePage(userType: type));
  } else if (type == UserType.business) {
    Get.offAll(() => MyHomePage(userType: type));
  } else if (type == UserType.admin) {
    Get.offAll(() => const AdminDashBoard());
  } else {
    Get.showSnackbar(const GetSnackBar(
      messageText: Text("User Role Not Found"),
    ));
  }
}
