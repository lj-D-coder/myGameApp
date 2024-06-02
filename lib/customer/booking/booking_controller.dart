import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/api/otp_service.dart';
import 'package:mygame/models/req/save_token_req.dart';
import 'package:mygame/models/req/update_location_req.dart';
import 'package:mygame/models/res/booking_response.dart';
import 'package:mygame/models/res/get_ranges_response.dart';
import 'package:mygame/models/res/home_feed_response.dart';
import 'package:mygame/models/res/match_details.dart';
import 'package:mygame/models/res/single_biz_info.dart';
import 'package:mygame/utils/loading.dart';

class BookingController extends GetxController {
  BuildContext? context;
  Dio? dio;
  late OtpService otpService;
  late Api apiService;
  List<String> timeRanges = [];
  RxBool businessDeatilsLoaded = false.obs;
  RxBool getRangesLoaded = false.obs;

  late GetStorage box;
  SingleBusinessInfo singleBusinessInfo = SingleBusinessInfo();
  BookingResponse bookingResponse = BookingResponse();
  RxString confirmBookingStatus = "".obs;
  GetRangesResponse getRangesResponse = GetRangesResponse();
  HomeFeedResponse homeFeedResponse = HomeFeedResponse();
  RxList<NearbyGround> nearbyGround = <NearbyGround>[].obs;
  RxList<Matches> matches = <Matches>[].obs;
  RxList allMatchesUnderBiz = [].obs;
  var singleMatchDetails = MatchDetailResponse().obs;
  var myBookingList = [].obs;
  var allBusinessList = [].obs;

  RxDouble price = 0.0.obs;
  RxDouble fieldPrice = 0.0.obs;
  RxInt qty = 1.obs;
  int? selectedDay;

  @override
  void onInit() {
    confirmBookingStatus.value = "";
    box = GetStorage();
    dio = Dio();
    dio!.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    otpService = OtpService(dio!);
    apiService = Api(dio!);
    price.value = 0;
    qty.value = 1;
    context = Get.context;

    super.onInit();
  }

  void getRanges() {
    Map<String, dynamic> businessHours = singleBusinessInfo.businessData!.businessHours!.toJson();

    Map<String, dynamic> slot = {
      "gameLength": 60,
    };
    timeRanges.clear();
    timeRanges.add("Select Your Slot");
    timeRanges.addAll(generateTimeRanges(businessHours, slot));
    print(timeRanges);
  }

  List<String> generateTimeRanges(Map<String, dynamic> businessHours, Map<String, dynamic> slot) {
    String openTime = businessHours["openTime"];
    String closeTime = businessHours["closeTime"];
    int gameLength = slot["gameLength"];

    List<String> timeRanges = [];

    DateTime startTime = parseTime(openTime);
    DateTime endTime = parseTime(closeTime);

    while (startTime.add(Duration(minutes: gameLength)).isBefore(endTime)) {
      String startTimeString = formatTime(startTime);
      String endTimeString = formatTime(startTime.add(Duration(minutes: gameLength)));

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

  Future<void> getBusinessDetails(businessId) async {
    businessDeatilsLoaded.value = false;
    try {
      final data = await apiService.getBusinessInfo("application/json", businessId);
      if (data.status == 200) {
        singleBusinessInfo = data.data;
        businessDeatilsLoaded.value = true;
        price.value = double.parse(singleBusinessInfo.pricingData!.price!.individual!.price!);
        fieldPrice.value = double.parse(singleBusinessInfo.pricingData!.price!.field!.price!);
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> getTimeRanges(req, [showLoader]) async {
    try {
      if (showLoader != null && showLoader == true) {
        showDialog();
      }
      final data = await apiService.getTimeRanges("application/json", req);
      if (showLoader != null && showLoader == true) {
        closeDialog();
      }
      if (data.status == 200) {
        getRangesResponse = data;
        getRangesLoaded.value = true;
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> getTimeRangesPlaygroud(req, [showLoader]) async {
    try {
      if (showLoader != null && showLoader == true) {
        showDialog();
      }
      final data = await apiService.getTimeRangesPlayground("application/json", req);
      if (showLoader != null && showLoader == true) {
        closeDialog();
      }
      if (data.status == 200) {
        getRangesResponse = data;
        getRangesLoaded.value = true;
      }
    } catch (err) {
      throw err;
    }
  }

  void setFieldPrice() {
    price.value = double.parse(singleBusinessInfo.pricingData!.price!.field!.price!);
  }

  Future<void> makeBooking(req) async {
    try {
      showDialog();
      final data = await apiService.booking("application/json", req);
      closeDialog();
      if (data.status == 200) {
        bookingResponse = data;
      } else {
        throw data.message ?? "";
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> confirmBooking(request) async {
    try {
      final data = await apiService.confirmBooking("application/json", request);
      if (data.message == "Success") {
        confirmBookingStatus.value = "success";
      } else {
        confirmBookingStatus.value = "failed";
      }
    } catch (err) {
      confirmBookingStatus.value = "failed";
      throw err;
    }
  }

  Future<void> droppedBooking(request) async {
    try {
      final data = await apiService.droppedBooking("application/json", request);
      if (data.status == 200) {
      } else {}
    } catch (err) {
      throw err;
    }
  }

  Future<void> homeFeed(request) async {
    try {
      final data = await apiService.homeFeed("application/json", request);
      if (data.status == 200) {
        homeFeedResponse = data;
        nearbyGround.value = data.nearbyGround ?? [];
        matches.value = data.matches ?? [];
      } else {}
    } catch (err) {
      throw err;
    }
  }

  Future<void> saveToken(token) async {
    try {
      var userData = await box.read("UserData");
      var id = userData["userId"];
      FirebaseSaveTokenReq firebaseSaveTokenReq = FirebaseSaveTokenReq();
      firebaseSaveTokenReq.firebaseToken = token;
      firebaseSaveTokenReq.userId = id;
      final data = await apiService.saveToken("application/json", firebaseSaveTokenReq);
      if (data.status == 200) {
      } else {}
    } catch (err) {
      throw err;
    }
  }

  Future<void> getAllBusiness() async {
    try {
      final data = await apiService.getAllBusiness("application/json");
      if (data.status == 200) {
        allBusinessList.value = data.data ?? [];
      } else {}
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateUserLocation(lat, lng) async {
    var userData = await box.read("UserData");
    var id = userData["userId"];
    UpdateLocationReq updateLocationReq = UpdateLocationReq();
    updateLocationReq.latitude = lat.toString();
    updateLocationReq.longitude = lng.toString();
    updateLocationReq.userId = id;
    try {
      showDialog();
      final data = await apiService.updateUserLocation("application/json", updateLocationReq);
      closeDialog();
      if (data.status == 200) {}
    } catch (err) {
      rethrow;
    }
  }

  Future<void> getAllMatchesUnderBusiness(id) async {
    try {
      final data = await apiService.getAllMatchesUnderBusiness("application/json", id);
      if (data.status == 200) {
        allMatchesUnderBiz.value = data.data ?? [];
      } else {}
    } catch (err) {
      throw err;
    }
  }

  Future<void> gertMatchDetails(id) async {
    try {
      singleMatchDetails.value.data = null;
      final data = await apiService.getMatchDetails("application/json", id);
      if (data.status == 200) {
        singleMatchDetails.value = data;
      } else {}
    } catch (err) {
      throw err;
    }
  }

  Future<void> getClientBooking() async {
    var userData = box.read("UserData") ?? {};
    try {
      showDialog();
      final data = await apiService.getClientBooking("application/json", userData['userId']);
      closeDialog();
      if (data.status == 200) {
        myBookingList.value = data.data ?? [];
      }
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
