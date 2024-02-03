import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/api/otp_service.dart';
import 'package:mygame/models/res/booking_response.dart';
import 'package:mygame/models/res/single_biz_info.dart';
import 'package:mygame/utils/loading.dart';

class BookingController extends GetxController {
  BuildContext? context;
  Dio? dio;
  late OtpService otpService;
  late Api apiService;
  List<String> timeRanges = [];
  RxBool businessDeatilsLoaded = false.obs;

  late GetStorage box;
  SingleBusinessInfo singleBusinessInfo = SingleBusinessInfo();
  BookingResponse bookingResponse = BookingResponse();

  RxInt price = 0.obs;
  RxInt qty = 1.obs;
  int? selectedDay;

  @override
  void onInit() {
    box = GetStorage();
    dio = Dio();
    dio!.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    otpService = OtpService(dio!);
    apiService = Api(dio!);
    price.value = 0;
    qty.value = 1;

    context = Get.context;
    super.onInit();
  }

  void getRanges() {
    Map<String, dynamic> businessHours =
        singleBusinessInfo.businessData!.businessHours!.toJson();

    Map<String, dynamic> slot = {
      "gameLength": 60,
    };
    timeRanges.clear();
    timeRanges.add("Select Your Slot");
    timeRanges.addAll(generateTimeRanges(businessHours, slot));
    print(timeRanges);
  }

  List<String> generateTimeRanges(
      Map<String, dynamic> businessHours, Map<String, dynamic> slot) {
    String openTime = businessHours["openTime"];
    String closeTime = businessHours["closeTime"];
    int gameLength = slot["gameLength"];

    List<String> timeRanges = [];

    DateTime startTime = parseTime(openTime);
    DateTime endTime = parseTime(closeTime);

    while (startTime.add(Duration(minutes: gameLength)).isBefore(endTime)) {
      String startTimeString = formatTime(startTime);
      String endTimeString =
          formatTime(startTime.add(Duration(minutes: gameLength)));

      timeRanges.add("$startTimeString - $endTimeString");
      startTime = startTime.add(Duration(minutes: gameLength));
    }

    return timeRanges;
  }

  DateTime parseTime(String time) {
    final timeFormat = DateFormat('h:mm a');
    return timeFormat.parse(time);
  }

  String formatTime(DateTime time) {
    final timeFormat = DateFormat('h:mm a');
    return timeFormat.format(time);
  }

  Future<void> getBusinessDetails() async {
    try {
      final data = await apiService.getBusinessInfo(
          "application/json", "65bbb352f5f90fa337eeb5b4");
      if (data.status == 200) {
        singleBusinessInfo = data.data;
        businessDeatilsLoaded.value = true;
        price.value = int.parse(
            singleBusinessInfo.pricingData!.price!.individual!.price!);
        getRanges();
      }
    } catch (err) {
      throw err;
    }
  }

  void setFieldPrice() {
    price.value =
        int.parse(singleBusinessInfo.pricingData!.price!.field!.price!);
  }

  Future<void> makeBooking(req) async {
    try {
      showDialog();
      final data = await apiService.booking("application/json", req);
      if (data.status == 200) {
        bookingResponse = data;
      }
      closeDialog();
    } catch (err) {
      throw err;
    }
  }

  Future<void> confirmBooking(request) async {
    try {
      final data = await apiService.confirmBooking("application/json", request);
      if (data.status == 200) {}
    } catch (err) {
      throw err;
    }
  }

  void showDialog() {
    Get.dialog(const Loading());
  }

  void closeDialog() {
    Get.back();
  }
}