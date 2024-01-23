import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/business/business_appbar.dart';
import 'package:mygame/business/business_controller.dart';
import 'package:mygame/business/drawer.dart';
import 'package:mygame/business/setup.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  final BusinessController businessController = Get.put(BusinessController());
  bool loading = true;

  @override
  void initState() {
    businessController.getBusinessData().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const BusinessAppBar(),
      drawer: const BusinessDrawer(),
      body: loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Obx(
              () => businessController.setUpComplete.value == true
                  ? businessController.bookingList.isEmpty
                      ? const Center(
                          child: Text("Empty booking list"),
                        )
                      : ListView.builder(
                          itemCount: businessController.bookingList.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).primaryColor,
                              child: Text("Booking $index"),
                            );
                          })
                  : const SetUp(),
            ),
    );
  }
}
