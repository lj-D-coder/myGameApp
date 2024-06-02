import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/friends/find_friends_controller.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({super.key});

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  final FindFriendsController findFriendsController = Get.find();
  var box = GetStorage();
  @override
  void initState() {
    findFriendsController.tempFollowList.value = [];
    findFriendsController.recommendList.value = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      findFriendsController.friend();
    });
    super.didChangeDependencies();
  }

  String formatUnixTimestampTo12Hour(int unixTimestamp) {
    // Convert Unix timestamp to milliseconds
    var dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);
    // Format the datetime to 12-hour format
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => findFriendsController.recommendList.isEmpty
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: findFriendsController.recommendList.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 20, right: 15, bottom: 10),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 49, 63, 91),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(findFriendsController
                                          .recommendList[index].profilePicture),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(findFriendsController.recommendList[index].name ?? ""),
                                        if (findFriendsController.recommendList[index].address !=
                                            null)
                                          Text(findFriendsController.recommendList[index].address ??
                                              ""),
                                      ],
                                    ),
                                    const Spacer(),
                                    findFriendsController.tempFollowList.contains(
                                            findFriendsController.recommendList[index].userId)
                                        ? InkWell(
                                            onTap: () {
                                              findFriendsController.tempFollowList.remove(
                                                  findFriendsController
                                                      .recommendList[index].userId);
                                              findFriendsController.unfollow(findFriendsController
                                                  .recommendList[index].userId);
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 80,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: const Text("Following"),
                                            ),
                                          )
                                        : findFriendsController.recommendList[index].following
                                            ? InkWell(
                                                onTap: () {
                                                  findFriendsController.unfollow(
                                                      findFriendsController
                                                          .recommendList[index].userId);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 80,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: const Text("Following"),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  findFriendsController.follow(findFriendsController
                                                      .recommendList[index].userId);
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 80,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: const Text("Follow"),
                                                ),
                                              ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
          )
        ],
      ),
    );
  }
}
