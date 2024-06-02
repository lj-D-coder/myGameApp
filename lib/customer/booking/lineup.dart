import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/time_selection.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';

class LineUp extends StatefulWidget {
  const LineUp({super.key});

  @override
  State<LineUp> createState() => _LineUpState();
}

class _LineUpState extends State<LineUp> {
  final BookingController bookingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Obx(
        () => bookingController.singleMatchDetails.value.data == null
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Line Up",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Team A",
                              ),
                              Text(
                                "${bookingController.singleMatchDetails.value.data!.teams!.leftTeam!.length} / ${bookingController.singleMatchDetails.value.data!.playerCapacity! ~/ 2}",
                              ),
                              for (var i = 0;
                                  i <
                                      bookingController
                                              .singleMatchDetails.value.data!.playerCapacity! ~/
                                          2;
                                  i++)
                                i <
                                        bookingController
                                            .singleMatchDetails.value.data!.teams!.leftTeam!.length
                                    ? Container(
                                        height: 100,
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                "assets/images/user.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  bookingController.singleMatchDetails.value.data!
                                                      .teams!.leftTeam![i],
                                                  overflow: TextOverflow.ellipsis,
                                                ))
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        alignment: Alignment.center,
                                        child: const Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.person_add,
                                                size: 35,
                                              ),
                                            ),
                                            Text(
                                              "Free Slot",
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      )
                            ],
                          ),
                          const VerticalDivider(
                            width: 3,
                            color: Colors.grey,
                            thickness: 3,
                            endIndent: 140,
                            indent: 100,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Team B",
                              ),
                              Text(
                                "${bookingController.singleMatchDetails.value.data!.teams!.rightTeam!.length} / ${bookingController.singleMatchDetails.value.data!.playerCapacity! ~/ 2}",
                              ),
                              for (var i = 0;
                                  i <
                                      bookingController
                                              .singleMatchDetails.value.data!.playerCapacity! ~/
                                          2;
                                  i++)
                                i <
                                        bookingController
                                            .singleMatchDetails.value.data!.teams!.rightTeam!.length
                                    ? Container(
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                "assets/images/user.png",
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  bookingController.singleMatchDetails.value.data!
                                                      .teams!.rightTeam![i],
                                                  overflow: TextOverflow.ellipsis,
                                                ))
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.person_add,
                                                size: 35,
                                              ),
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Free Slot",
                                                  overflow: TextOverflow.ellipsis,
                                                ))
                                          ],
                                        ),
                                      )
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.grey.withOpacity(0.5), // Semi-transparent grey color
                        ),
                        overlayColor: MaterialStatePropertyAll(
                          Colors.white.withOpacity(0.2), // Color when pressed
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (ctx) {
                              return Center(
                                  child: AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                content: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Choose Team",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => TimeSelection(), arguments: {
                                                'side': "leftTeam",
                                                'date': bookingController
                                                    .singleMatchDetails.value.data!.matchDate,
                                                'startTime': bookingController
                                                    .singleMatchDetails.value.data!.startTimestamp,
                                                'bookingType': bookingController
                                                    .singleMatchDetails.value.data!.bookingType,
                                                'endTime': bookingController
                                                    .singleMatchDetails.value.data!.endTimestamp,
                                              });
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              color: Theme.of(context).primaryColor,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Join Left\nTeam",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Get.to(() => TimeSelection(), arguments: {
                                                  'side': "rightTeam",
                                                  'date': bookingController
                                                      .singleMatchDetails.value.data!.matchDate,
                                                  'startTime': bookingController.singleMatchDetails
                                                      .value.data!.startTimestamp,
                                                  'bookingType': bookingController
                                                      .singleMatchDetails.value.data!.bookingType,
                                                  'endTime': bookingController
                                                      .singleMatchDetails.value.data!.endTimestamp,
                                                });
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                color: Theme.of(context).primaryColor,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Join Right\nTeam",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            }).then((value) {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Join",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.8), // Glow color
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/red.png",
                                height: 24, // Adjust the height as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
