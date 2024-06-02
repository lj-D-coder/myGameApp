import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/booking/booking_controller.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final BookingController bookingController = Get.find();
  @override
  void initState() {
    bookingController.myBookingList.value = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      bookingController.getClientBooking();
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
            () => bookingController.myBookingList.isEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: const Center(child: Text("No recent bookings")),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: bookingController.myBookingList.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 20, right: 15, bottom: 10),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 49, 63, 91),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child:
                                        Text("${bookingController.myBookingList[index].receiptNo}"),
                                  ),
                                  subtitle: Text(
                                      "Booking id : ${bookingController.myBookingList[index].bookingId}"),
                                  title: Text(
                                    "Business Name: ${bookingController.myBookingList[index].businessName}",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Scheduled",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(color: Colors.grey.shade400)),
                                              Text(
                                                  "Start ${formatUnixTimestampTo12Hour(bookingController.myBookingList[index].matchStartTime)} - End  ${formatUnixTimestampTo12Hour(bookingController.myBookingList[index].matchEndTime)} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(color: Colors.grey.shade400)),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  "\u20B9 ${bookingController.myBookingList[index].paymentInfo.amountPaid}"),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
