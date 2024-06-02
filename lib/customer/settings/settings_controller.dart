import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/utils/loading.dart';

class SettingsController extends GetxController {
  Dio? dio;
  late Api apiService;
  late GetStorage box;

  var followerList = [].obs;
  var userProfile = {}.obs;

  @override
  void onInit() {
    box = GetStorage();
    dio = Dio();
    dio!.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    apiService = Api(dio!);
    super.onInit();
  }

  void showDialog() {
    Get.dialog(const Loading());
  }

  void closeDialog() {
    Get.back();
  }

  Future<void> uploadProfile(File image) async {
    var userData = await box.read("UserData");
    var id = userData["userId"];
    try {
      showDialog();
      final data = await apiService.uploadProfile(id, image);
      if (data.status == 200) {
        getProfile();
      }
      closeDialog();
    } catch (err) {
      print(err);
    }
  }

  Future<void> getFollower() async {
    var userData = await box.read("UserData");
    var id = userData["userId"];
    try {
      showDialog();
      final data = await apiService.getFollower("application/json", id);
      if (data.status == 200) {
        followerList.value = data.data!.followers ?? [];
      }
      closeDialog();
    } catch (err) {
      print(err);
    }
  }

  Future<void> getProfile() async {
    var userData = await box.read("UserData");
    var id = userData["userId"];
    try {
      showDialog();
      final data = await apiService.getProfile("application/json", id);
      if (data.status == 200) {
        userProfile.addAll({
          'name': data.userData!.userName ?? "",
          'follower': data.userData!.follower ?? "",
          'following': data.userData!.following ?? "",
          'domain': data.userData!.domain ?? "",
          'profilePic': data.userData!.profilePicture ?? "",
        });
      }
      closeDialog();
    } catch (err) {
      print(err);
    }
  }
}
