import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/lineup.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';

class AllMatches extends StatefulWidget {
  const AllMatches({super.key});

  @override
  State<AllMatches> createState() => _AllMatchesState();
}

class _AllMatchesState extends State<AllMatches> {
  final BookingController _bookingController = Get.find();
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
      appBar: const CommonAppBar(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: _bookingController.allMatchesUnderBiz.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        "${formatUnixTimestampTo12Hour(_bookingController.allMatchesUnderBiz[index].startTimestamp!)} - ${formatUnixTimestampTo12Hour(_bookingController.allMatchesUnderBiz[index].endTimestamp!)}",
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Spacer(),
                      Text("\u20B9 ${_bookingController.allMatchesUnderBiz[index].price}/slot")
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.sports_soccer_sharp, size: 30),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_bookingController
                                  .singleBusinessInfo.businessData!.businessInfo!.name ??
                              ""),
                          Text(_bookingController
                                  .singleBusinessInfo.businessData!.businessInfo!.address ??
                              ""),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _bookingController.gertMatchDetails(
                              _bookingController.allMatchesUnderBiz[index].matchId);
                          Get.to(() => const LineUp());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: _bookingController.allMatchesUnderBiz[index].playerCapacity ==
                                    _bookingController.allMatchesUnderBiz[index].playerJoined
                                ? Colors.grey
                                : Colors.yellow,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            _bookingController.allMatchesUnderBiz[index].playerCapacity ==
                                    _bookingController.allMatchesUnderBiz[index].playerJoined
                                ? "Booked"
                                : "Join",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${_bookingController.allMatchesUnderBiz[index].playerCapacity ~/ 2} a side (${_bookingController.allMatchesUnderBiz[index].playerCapacity ~/ 2}X${_bookingController.allMatchesUnderBiz[index].playerCapacity ~/ 2})",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Transform.scale(
                        scale: .7,
                        child: Slider(
                            value: _bookingController.allMatchesUnderBiz[index].playerJoined! /
                                _bookingController.allMatchesUnderBiz[index].playerCapacity!,
                            onChanged: (value) {}),
                      ),
                      Text(
                          "${_bookingController.allMatchesUnderBiz[index].playerCapacity! - _bookingController.allMatchesUnderBiz[index].playerJoined!} slot left")
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
