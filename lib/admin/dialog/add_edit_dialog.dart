import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/admin/admin_controller.dart';
import 'package:mygame/models/req/add_business_model.dart' as addModel;
import 'package:mygame/models/res/single_biz_info.dart';

import '../../utils/snackbar.dart';

void addEditDialog(context, [BusinessData? data]) {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();
  final TextEditingController controller7 = TextEditingController();
  final TextEditingController controller8 = TextEditingController();
  final TextEditingController controller9 = TextEditingController();
  final TextEditingController controller10 = TextEditingController();
  final TextEditingController controller11 = TextEditingController();
  bool customGame = false;
  final AdminController adminController = Get.put(AdminController());

  void saveBusinessData() {
    if (controller1.text.isNotEmpty &&
        controller2.text.isNotEmpty &&
        controller3.text.isNotEmpty &&
        controller4.text.isNotEmpty &&
        controller6.text.isNotEmpty &&
        controller7.text.isNotEmpty &&
        controller10.text.isNotEmpty) {
      addModel.AddBusinessModel model = addModel.AddBusinessModel();
      addModel.BusinessInfo info = addModel.BusinessInfo();
      addModel.BusinessHours hours = addModel.BusinessHours();
      addModel.Slot slot = addModel.Slot();
      addModel.Location location = addModel.Location();
      info.name = controller1.text;
      info.address = controller2.text;
      info.email = controller4.text;
      info.phoneNo = int.parse(controller3.text);
      info.gstNo = controller5.text;
      hours.openTime = controller6.text;
      hours.closeTime = controller7.text;
      hours.breakStart = controller8.text;
      hours.breakEnd = controller9.text;
      location.latitude = "0";
      location.longitude = "0";
      slot.customGameLength = true;
      slot.gameLength = int.parse(controller10.text);
      info.location = location;
      model.businessInfo = info;
      model.businessHours = hours;
      model.slot = slot;
      if (controller4.text.contains('@') == false) {
        showSnackBar(context, "Please enter a valid email");
      } else {
        if (data != null) {
          adminController.updateBusiness(data.businessID.toString(), model);
          Get.back();
        } else {
          adminController.addBusiness(model);
        }
      }
    } else {
      showSnackBar(context, "Please fill all the mandatory data");
    }
  }

  clearController() {
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    controller7.clear();
    controller8.clear();
    controller9.clear();
    controller10.clear();
    controller11.clear();
  }

  if (data != null) {
    controller1.text = data.businessInfo!.name ?? "";
    controller2.text = data.businessInfo!.address ?? "";
    controller3.text = data.businessInfo!.phoneNo.toString();
    controller4.text = data.businessInfo!.email ?? "";
    controller5.text = data.businessInfo!.gstNo ?? "";
    controller6.text = data.businessHours!.openTime ?? "";
    controller7.text = data.businessHours!.closeTime ?? "";
    controller8.text = data.businessHours!.breakStart ?? "";
    controller9.text = data.businessHours!.breakEnd ?? "";
    controller10.text = data.slot!.gameLength.toString();
  }

  showDialog(
      context: context,
      builder: (ctx) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: StatefulBuilder(
            builder: (ctx, state) => Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: MediaQuery.of(context).size.height - 100,
                  width: 350,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                          TextFormField(
                            controller: controller1,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                                hintText: "Business Name"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: controller2,
                            decoration:
                                const InputDecoration(hintText: "Address Name"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: controller3,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                                hintText: "Phone no",
                                counterText: "",
                                counter: Container()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: controller4,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(hintText: "Email"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: controller5,
                            decoration: const InputDecoration(
                                hintText: "Gst No (optional)"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                controller6.text = value!.format(context);
                              });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                controller: controller6,
                                decoration: const InputDecoration(
                                    hintText: "Open Time"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                controller7.text = value!.format(context);
                              });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                controller: controller7,
                                decoration: const InputDecoration(
                                    hintText: "Close Time"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  controller8.text = value!.format(context);
                                });
                              },
                              child: IgnorePointer(
                                ignoring: true,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: controller8,
                                  decoration: const InputDecoration(
                                      hintText: "Break Start (optional)"),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  controller9.text = value!.format(context);
                                });
                              },
                              child: IgnorePointer(
                                ignoring: true,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: controller9,
                                  decoration: const InputDecoration(
                                      hintText: "Break End (optional)"),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: controller10,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: "Game Length (in minutes)"),
                          ),
                          // SizedBox(
                          //   height: 25,
                          // ),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "Custom Game Length",
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                saveBusinessData();
                              },
                              child: const Text("Done"))
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        );
      }).then((value) {
    clearController();
  });
}
