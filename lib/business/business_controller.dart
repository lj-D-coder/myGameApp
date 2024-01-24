import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/core/auth/login.dart';
import 'package:mygame/models/req/pricing_request.dart';
import 'package:mygame/models/res/single_biz_info.dart';
import 'package:mygame/utils/loading.dart';

class BusinessController extends GetxController {
  BuildContext? context;
  Dio? dio;
  late Api apiService;
  late GetStorage box;
  SingleBusinessInfo singleBusinessInfo = SingleBusinessInfo();
  RxBool setUpComplete = false.obs;
  RxList bookingList = [].obs;
  RxInt step = 1.obs;

  @override
  void onInit() {
    box = GetStorage();
    dio = Dio();
    dio!.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    apiService = Api(dio!);
    context = Get.context;
    super.onInit();
  }

  Future<void> getBusinessData() async {
    try {
      var userData = await box.read("UserData");
      var id = userData["userId"];
      final data = await apiService.getBusinessInfo("application/json", id);
      if (data.status == 200) {
        singleBusinessInfo = data.data;
        if (singleBusinessInfo.businessData!.businessStatus!.setupComplete ==
                false ||
            singleBusinessInfo.businessData!.businessStatus!.setupComplete ==
                null) {
          setUpComplete.value = false;
        } else if (singleBusinessInfo
                .businessData!.businessStatus!.setupComplete ==
            true) {
          bookingList.value = [];
          setUpComplete.value = true;
        } else {
          Get.offAll(const Login());
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> saveBusinessData(BusinessData info) async {
    try {
      var userData = await box.read("UserData");
      var id = userData["userId"];
      showDialog();
      final data =
          await apiService.saveBusinessInfo("application/json", id, info);
      closeDialog();
      if (data.status == 200) {
        step.value = 2;
        getBusinessData();
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> savePrice(PricingRequest info) async {
    try {
      showDialog();
      final data = await apiService.savePrice("application/json", info);
      closeDialog();
      if (data.status == 200) {
        step.value = 3;
      }
    } catch (err) {
      print(err);
    }
  }

  void showDialog() {
    Get.dialog(const Loading());
  }

  void closeDialog() {
    Get.back();
  }
}
