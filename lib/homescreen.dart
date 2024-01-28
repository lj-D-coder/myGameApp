import 'package:flutter/material.dart';
import 'package:mygame/business/business_appbar.dart';
import 'package:mygame/business/setup.dart';
import 'package:mygame/core/user_type.dart';
import 'package:mygame/customer/booking/booking.dart';
import 'package:mygame/customer/booking/home_feed.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';

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
  int currentIndex = 0;
  void onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final pages = [
    const HomeFeed(),
    const Booking(),
    const Booking(),
    const Booking(),
  ];

  @override
  Widget build(BuildContext context) {
    return widget.userType == UserType.player
        ? Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: const CommonAppBar(),
            bottomNavigationBar: Container(
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
                          Icons.pin_drop,
                        ),
                        label: "Game"),
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
