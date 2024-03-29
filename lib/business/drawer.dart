import 'package:flutter/material.dart';
import 'package:mygame/utils/logout.dart';

class BusinessDrawer extends StatefulWidget {
  const BusinessDrawer({super.key});

  @override
  State<BusinessDrawer> createState() => _BusinessDrawerState();
}

class _BusinessDrawerState extends State<BusinessDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      width: 250,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            height: 50,
            width: 250,
            child: Text("myGame",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          textWithPadding(const Text("Booking List")),
          textWithPadding(const Text("Settings")),
          textWithPadding(InkWell(
              onTap: () {
                logout();
              },
              child: const Text("Logout")))
        ],
      ),
    );
  }

  Widget textWithPadding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: widget,
    );
  }
}
