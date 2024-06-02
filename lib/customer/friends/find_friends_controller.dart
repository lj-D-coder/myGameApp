import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mygame/api/api.dart';
import 'package:mygame/models/req/follow_req.dart';
import 'package:mygame/models/req/friend_req.dart';
import 'package:mygame/utils/loading.dart';

class FindFriendsController extends GetxController {
  var recommendList = [].obs;
  var tempFollowList = [].obs;

  Dio? dio;
  late Api apiService;

  late GetStorage box;

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

  Future<void> friend() async {
    try {
      var lat = box.read('lat') ?? 0.0;
      var lng = box.read('lng') ?? 0.0;
      var userData = await box.read("UserData");
      var id = userData["userId"];
      FriendReq friendReq = FriendReq();
      friendReq.userLocation = [93.995125, 24.482052];
      // friendReq.userLocation = [lng, lat];
      friendReq.userId = id;
      friendReq.radius = 20000;
      showDialog();
      final data = await apiService.findFriends("application/json", friendReq);
      closeDialog();
      if (data.status == 200) {
        recommendList.value = data.nearbyPlayers ?? [];
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> follow(
    userId,
  ) async {
    try {
      FollowReq followReq = FollowReq();
      // friendReq.userLocation = [lng, lat];
      var userData = await box.read("UserData");
      var id = userData["userId"];
      followReq.userId = userId;
      followReq.followerId = id;
      showDialog();
      final data = await apiService.follow("application/json", followReq);
      closeDialog();
      if (data.status == 200) {
        tempFollowList.add(userId);
        friend();
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> unfollow(
    userId,
  ) async {
    try {
      var userData = await box.read("UserData");
      var id = userData["userId"];
      FollowReq followReq = FollowReq();
      followReq.followerId = id;
      showDialog();
      final data = await apiService.unfollow("application/json", userId, followReq);
      closeDialog();
      if (data.status == 200) {
        friend();
      }
    } catch (err) {
      throw err;
    }
  }
}
