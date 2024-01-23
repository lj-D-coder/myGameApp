import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mygame/core/auth/login.dart';

void logout() {
  GetStorage box = GetStorage();
  box.erase();
  Get.offAll(() => const Login());
}
