import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/business_details.dart';
import 'package:mygame/customer/booking/business_list.dart';
import 'package:mygame/customer/booking/lineup.dart';
import 'package:mygame/models/req/homefeed_request.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final BookingController _bookingController = Get.find();
  final ScrollController _textAController = ScrollController();
  final ScrollController _textBController = ScrollController();
  final ScrollController _pageController = ScrollController();
  bool _scrolling = false;
  HomeFeedRequest homeFeedRequest = HomeFeedRequest();
  LocationData? locationData;
  var box = GetStorage();

  getMinMaxPosition(double tryScrollTo) {
    return tryScrollTo < _pageController.position.minScrollExtent
        ? _pageController.position.minScrollExtent
        : tryScrollTo > _pageController.position.maxScrollExtent
            ? _pageController.position.maxScrollExtent
            : tryScrollTo;
  }

  @override
  void initState() {
    var lat = box.read('lat') ?? 0.0;
    var lng = box.read('lng') ?? 0.0;
    if (lat != null && lng != null) {
      _bookingController.updateUserLocation(lat, lng);
      homeFeedRequest.userLocation = [lng, lat];
      // [
      //   93.995125,
      //   24.482052
      // ]
      homeFeedRequest.radius = 20000;
      _bookingController.homeFeed(homeFeedRequest);
    } else {}

    super.initState();
  }

  String formatUnixTimestampTo12Hour(int unixTimestamp) {
    // Convert Unix timestamp to milliseconds
    var dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    // Format the datetime to 12-hour format
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is OverscrollNotification &&
              notification.velocity == 0 &&
              (notification.metrics.axisDirection == AxisDirection.down ||
                  notification.metrics.axisDirection == AxisDirection.up)) {
            var scrollTo =
                getMinMaxPosition(_pageController.position.pixels + (notification.overscroll));
            _pageController.jumpTo(scrollTo);
          } else if (notification is OverscrollNotification &&
              (notification.metrics.axisDirection == AxisDirection.down ||
                  notification.metrics.axisDirection == AxisDirection.up)) {
            var yVelocity = notification.velocity;
            _scrolling = true;
            var scrollTo = getMinMaxPosition(_pageController.position.pixels + (yVelocity / 5));
            _pageController
                .animateTo(scrollTo,
                    duration: const Duration(milliseconds: 1000), curve: Curves.linearToEaseOut)
                .then((value) => _scrolling = false);
          } else if (notification is ScrollEndNotification &&
              notification.depth > 0 &&
              !_scrolling &&
              (notification.metrics.axisDirection == AxisDirection.down ||
                  notification.metrics.axisDirection == AxisDirection.up)) {
            var yVelocity = notification.dragDetails?.velocity.pixelsPerSecond.dy ?? 0;
            var scrollTo = getMinMaxPosition(_pageController.position.pixels - (yVelocity / 5));
            var scrollToPractical = scrollTo < _pageController.position.minScrollExtent
                ? _pageController.position.minScrollExtent
                : scrollTo > _pageController.position.maxScrollExtent
                    ? _pageController.position.maxScrollExtent
                    : scrollTo;
            _pageController.animateTo(scrollToPractical,
                duration: const Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
          }
          return true;
        },
        child: ListView(controller: _pageController, children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 63, 91),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Grounds nearby you",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          Get.to(() => const AllBusinessListClient());
                        },
                        child: const Text("View All"))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: _bookingController.nearbyGround.length,
                      itemBuilder: (ctx, index) => Container(
                        margin: const EdgeInsets.all(5),
                        width: 220,
                        height: 200,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => BusinessDetails(
                                  businessId: _bookingController.nearbyGround[index].businessID!,
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  width: 220,
                                  height: 200,
                                  child: Image.network(
                                    _bookingController.nearbyGround[index].bannerUrl ??
                                        "https://editorial.uefa.com/resources/025c-0f8e775cc072-f99f8b3389ab-1000/the_new_tottenham_hotspur_stadium_has_an_unusual_flexible_playing_surface.jpeg",
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          "https://editorial.uefa.com/resources/025c-0f8e775cc072-f99f8b3389ab-1000/the_new_tottenham_hotspur_stadium_has_an_unusual_flexible_playing_surface.jpeg");
                                    },
                                  ),
                                ),
                                Positioned(
                                    child: Container(
                                  height: 60,
                                  color: Colors.black.withOpacity(.5),
                                )),
                                Positioned(
                                    bottom: 30,
                                    left: 10,
                                    child: Text(_bookingController.nearbyGround[index].name ?? "")),
                                Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child:
                                        Text(_bookingController.nearbyGround[index].address ?? ""))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 63, 91),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Trending Matches",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Obx(
                    () => _bookingController.matches.isNotEmpty
                        ? ListView.builder(
                            controller: _textAController,
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: _bookingController.matches.length,
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
                                        "${formatUnixTimestampTo12Hour(_bookingController.matches[index].startTimestamp!)} - ${formatUnixTimestampTo12Hour(_bookingController.matches[index].endTimestamp!)}",
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                      const Spacer(),
                                      Text("\u20B9 ${_bookingController.matches[index].price}/slot")
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
                                          Text(_bookingController.matches[index].name ?? ""),
                                          Text(
                                            _bookingController.matches[index].address ?? "",
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          _bookingController
                                              .getBusinessDetails(
                                                  _bookingController.matches[index].businessId)
                                              .then((value) {
                                            _bookingController.gertMatchDetails(
                                                _bookingController.matches[index].matchId);
                                            Get.to(() => const LineUp(), arguments: {});
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: const Text(
                                            "Join",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${_bookingController.matches[index].playerCapacity! ~/ 2} a side (${_bookingController.matches[index].playerCapacity! ~/ 2}X${_bookingController.matches[index].playerCapacity! ~/ 2})",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: .7,
                                        child: Slider(
                                            value: _bookingController.matches[index].playerJoined! /
                                                _bookingController.matches[index].playerCapacity!,
                                            onChanged: (value) {}),
                                      ),
                                      Text(
                                          "${_bookingController.matches[index].playerCapacity! - _bookingController.matches[index].playerJoined!} slot left",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: const Text("No matches found"),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   padding: const EdgeInsets.all(15),
          //   height: 250,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: const Color.fromARGB(255, 49, 63, 91),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Column(
          //     children: [
          //       const Row(
          //         children: [
          //           Text(
          //             "Your Feed",
          //             style: TextStyle(
          //               fontSize: 17,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       ConstrainedBox(
          //         constraints: const BoxConstraints(
          //           maxHeight: 180,
          //         ),
          //         child: ListView.builder(
          //           physics: ClampingScrollPhysics(),
          //           controller: _textBController,
          //           padding: EdgeInsets.zero,
          //           scrollDirection: Axis.vertical,
          //           itemCount: 5,
          //           itemBuilder: (ctx, index) => Container(
          //             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          //             margin: const EdgeInsets.all(5),
          //             height: 80,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: Colors.black38,
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Row(
          //                   children: [
          //                     const CircleAvatar(
          //                       minRadius: 20,
          //                     ),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                     const Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         Text(
          //                           "Has join a matched @ 1/23/2024",
          //                           style: TextStyle(fontSize: 10),
          //                         ),
          //                         Text(
          //                           "Khuman Lampak Staium",
          //                         )
          //                       ],
          //                     ),
          //                     const Spacer(),
          //                     Container(
          //                       alignment: Alignment.center,
          //                       height: 30,
          //                       width: 80,
          //                       decoration: BoxDecoration(
          //                         color: Colors.yellow,
          //                         borderRadius: BorderRadius.circular(15),
          //                       ),
          //                       child: const Text(
          //                         "Join",
          //                         style: TextStyle(color: Colors.black),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ]),
      ),
    );
  }
}
