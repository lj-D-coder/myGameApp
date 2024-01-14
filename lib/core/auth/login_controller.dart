import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/api/otp_service.dart';
import 'package:mygame/models/req/sign_up_request.dart';
import 'package:mygame/utils/loading.dart';

class LoginController extends GetxController {
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

  late GetStorage box;

  @override
  void onInit() {
    box = GetStorage();
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

  Future<bool> signIn() async {
    try {
      showDialog();
      SignUpRequest request = SignUpRequest();
      request.loginId = loginId;
      request.phoneNo = phoneNo;
      request.userName = userName;
      request.userRole = userRole;

      final response = await apiService.signUp("application/json", request);
      closeDialog();

      if (response.success == true) {
        var userData = JwtDecoder.decode(response.JWT_token.toString());
        print(userData);

        box.write("UserData", userData);

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
