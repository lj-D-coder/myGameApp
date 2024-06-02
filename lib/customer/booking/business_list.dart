import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/business_details.dart';

class AllBusinessListClient extends StatefulWidget {
  const AllBusinessListClient({super.key});

  @override
  State<AllBusinessListClient> createState() => _AllBusinessListState();
}

class _AllBusinessListState extends State<AllBusinessListClient> {
  final BookingController bookingController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingController.allBusinessList.clear();
    bookingController.getAllBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Business List",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Obx(
        () => bookingController.allBusinessList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => BusinessDetails(
                          businessId:
                              bookingController.allBusinessList[index].businessData?.businessID));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(bookingController
                                  .allBusinessList[index].businessData?.businessInfo?.bannerUrl ??
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
                              color: Theme.of(context).primaryColor.withOpacity(.8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookingController.allBusinessList[index].businessData
                                          ?.businessInfo?.name ??
                                      "",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      bookingController.allBusinessList[index].businessData
                                              ?.businessInfo?.address ??
                                          "",
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Contact:- ${bookingController.allBusinessList[index].businessData?.businessInfo?.phoneNo.toString() ?? bookingController.allBusinessList[index].businessData?.businessInfo?.email ?? ""}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: bookingController.allBusinessList.length,
              )
            : const Center(child: Text("No business found")),
      ),
    );
  }
}
