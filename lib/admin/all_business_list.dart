import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/admin/admin_controller.dart';
import 'package:mygame/admin/dialog/add_edit_dialog.dart';
import 'package:mygame/models/req/add_business_model.dart';
import 'package:mygame/utils/snackbar.dart';

class AllBusinessList extends StatefulWidget {
  const AllBusinessList({super.key});

  @override
  State<AllBusinessList> createState() => _AllBusinessListState();
}

class _AllBusinessListState extends State<AllBusinessList> {
  final AdminController adminController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("myGame"),
      ),
      body: Obx(
        () => adminController.allBusinessList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onLongPress: () {},
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(adminController
                                  .allBusinessList[index]
                                  .businessData
                                  ?.businessInfo
                                  ?.bannerUrl ??
                              "https://media.hudle.in/venues/2eb223fa-f9f5-4f64-a73c-40986bb91442/photo/d6d08022281596c32755ac999fa26fb9c6af2f4c"),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 5, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  adminController.allBusinessList[index]
                                          .businessData?.businessInfo?.name ??
                                      "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      adminController
                                              .allBusinessList[index]
                                              .businessData
                                              ?.businessInfo
                                              ?.address ??
                                          "",
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Contact:- ${adminController.allBusinessList[index].businessData?.businessInfo?.phoneNo.toString() ?? adminController.allBusinessList[index].businessData?.businessInfo?.email ?? ""}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 10,
                            child: PopupMenuButton(
                              color: Colors.white,
                              iconColor: Colors.white,
                              padding: EdgeInsets.zero,
                              onSelected: (value) {
                                // Handle the selected option
                                // You can implement different actions based on the selected value
                                if (value == 'update') {
                                  addEditDialog(
                                      context,
                                      adminController
                                          .allBusinessList[index].businessData);
                                } else if (value == 'delete') {
                                  adminController.deleteBusiness(adminController
                                          .allBusinessList[index]
                                          .businessData!
                                          .businessID ??
                                      "0");
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                const PopupMenuItem(
                                  textStyle: TextStyle(color: Colors.white),
                                  value: 'update',
                                  child: Text('Update'),
                                ),
                                const PopupMenuItem(
                                  textStyle: TextStyle(color: Colors.white),
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: adminController.allBusinessList.length,
              )
            : Container(
                child: Center(child: Text("No business found")),
              ),
      ),
    );
  }
}
