import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/api/otp_service.dart';
import 'package:mygame/utils/loading.dart';

class SignUpController extends GetxController {
  BuildContext? context;
  Dio? dio;
  late OtpService otpService;
  late Api apiService;
  late String otpSessionDetails;

  late Map<String, dynamic> userDetails;
  String? loginId;
  String? userName;
  String? phoneNo;
  String? email;
  String? userRole;

  @override
  void onInit() {
    dio = Dio();
    dio!.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    otpService = OtpService(dio!);
    apiService = Api(dio!);
    context = Get.context;
    super.onInit();
  }

  bool verifyInput(String name, String phone) {
    if (name.isNotEmpty && phone.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> otpGenerate(String phone) async {
    try {
      showDialog();
      final response = await otpService.generateOtp(phone);
      closeDialog();

      if (response.Status == "Success") {
        otpSessionDetails = response.Details ?? "";
        return true;
      } else {
        return false;
      }
    } catch (err) {
      closeDialog();
      return false;
    }
  }

  Future<bool> verifyPin(String otp) async {
    try {
      showDialog();
      final response = await otpService.verifyPin(otpSessionDetails, otp);
      closeDialog();

      if (response.Status == "Success") {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      closeDialog();
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      showDialog();
      final response =
          await apiService.signUp(loginId, userName, phoneNo, email, userRole);
      closeDialog();

      if (response.success == true) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      closeDialog();
      return false;
    }
  }

  void showDialog() {
    Get.dialog(const Loading());
  }

  void closeDialog() {
    Get.back();
  }
}
