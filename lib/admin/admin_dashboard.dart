import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:mygame/admin/admin_controller.dart';
import 'package:mygame/admin/dialog/add_edit_dialog.dart';
import 'package:mygame/utils/logout.dart';

import 'all_business_list.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  final AdminController adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("myGame"),
        actions: [
          InkWell(
              onTap: () {
                logout();
              },
              child: const Icon(Icons.logout)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Admin Dashboard",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
              child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      addEditDialog(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Business",
                            ),
                            Icon(Icons.add)
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      adminController.getAllBusiness().then((value) {
                        Get.to(() => const AllBusinessList());
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all\nbusiness",
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                  ),
                )
              ]))
        ],
      )),
    );
  }
}
