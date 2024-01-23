import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/models/req/add_business_model.dart';
import 'package:mygame/models/res/single_biz_info.dart';
import 'package:mygame/utils/loading.dart';
import 'package:mygame/utils/snackbar.dart';

class AdminController extends GetxController {
  late BuildContext context;
  late Dio dio;
  late Api api;
  RxList<SingleBusinessInfo> allBusinessList = <SingleBusinessInfo>[].obs;
  @override
  void onInit() {
    context = Get.context!;
    dio = Dio();
    api = Api(dio);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    super.onInit();
  }

  void showDialog() {
    Get.dialog(const Loading());
  }

  void closeDialog() {
    Get.back();
  }

  Future<void> addBusiness(AddBusinessModel req) async {
    try {
      showDialog();
      print(req);
      final data = await api.addBusiness("application/json", req);
      closeDialog();
      if (data.success == true) {
        Get.back();
        if (context.mounted) {
          showSnackBar(context, "Business Added Sucessfully");
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> getAllBusiness() async {
    try {
      showDialog();
      final data = await api.getAllBusiness("application/json");
      closeDialog();
      if (data.status == 200) {
        allBusinessList.value = data.data ?? [];
      } else {
        if (context.mounted) {
          showSnackBar(context, "Something Went Wrong");
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteBusiness(String id) async {
    try {
      showDialog();
      final data = await api.deleteBusiness("application/json", id);
      closeDialog();
      if (data.status == 200) {
        getAllBusiness();
      } else {
        if (context.mounted) {
          showSnackBar(context, "Something Went Wrong");
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateBusiness(String id, AddBusinessModel model) async {
    try {
      showDialog();
      final data = await api.updateBusiness("application/json", id, model);
      closeDialog();
      if (data.status == 200) {
        getAllBusiness();
      } else {
        if (context.mounted) {
          showSnackBar(context, "Something Went Wrong");
        }
      }
    } catch (err) {
      print(err);
    }
  }
}
