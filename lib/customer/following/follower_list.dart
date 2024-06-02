import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/settings/settings_controller.dart';

class FollowerList extends StatefulWidget {
  const FollowerList({super.key});

  @override
  State<FollowerList> createState() => _FollowerListState();
}

class _FollowerListState extends State<FollowerList> {
  final SettingsController settingsController = Get.find();
  var box = GetStorage();
  @override
  void initState() {
    settingsController.followerList.value = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      settingsController.getFollower();
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Text(
                "Follower List",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20),
              ),
            ),
            Obx(
              () => settingsController.followerList.isEmpty
                  ? Container()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: settingsController.followerList.length,
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
                                        backgroundImage: NetworkImage(
                                            settingsController.followerList[index].profilePicture ??
                                                ""),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Text(settingsController.followerList[index].userName ??
                                              ""),
                                        ],
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 25,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: const Text("Follows you"),
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
      ),
    );
  }
}
