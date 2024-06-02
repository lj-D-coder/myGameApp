import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:mygame/business/business_appbar.dart';
import 'package:mygame/business/setup.dart';
import 'package:mygame/core/user_type.dart';
import 'package:mygame/customer/booking/booking.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/home_feed.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';
import 'package:mygame/customer/friends/find_friends.dart';
import 'package:mygame/customer/friends/find_friends_controller.dart';
import 'package:mygame/customer/settings/settings.dart';
import 'package:mygame/services/fcm_service.dart';

class MyHomePage extends StatefulWidget {
  final UserType userType;
  const MyHomePage({
    Key? key,
    required this.userType,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BookingController _bookingController = Get.put(BookingController());
  final FindFriendsController _findFriendsController = Get.put(FindFriendsController());
  final PushNotificationService _notificationService = PushNotificationService();

  var box = GetStorage();

  int currentIndex = 0;
  void onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final pages = [
    const HomeFeed(),
    const FindFriends(),
    const Booking(),
    const Settings(),
  ];

  @override
  void initState() {
    _notificationService.initialize(context);
    _notificationService.getToken().then((value) {
      _bookingController.saveToken(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.userType == UserType.player
        ? Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: const CommonAppBar(),
            bottomNavigationBar: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (value) {
                    onTap(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                        ),
                        label: "Players"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.menu,
                        ),
                        label: "My Ticket"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.settings,
                        ),
                        label: "Settings")
                  ]),
            ),
            body: pages.elementAt(currentIndex))
        : Scaffold(
            appBar: const BusinessAppBar(),
            drawer: Drawer(
              backgroundColor: const Color(0xff2C3444),
              width: 300,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Set Holidays/Closed days'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            body: const SetUp(),
          );
  }
}
