import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/customer/booking/all_matches.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/time_selection.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessDetails extends StatefulWidget {
  final String businessId;
  const BusinessDetails({super.key, required this.businessId});

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  final BookingController _bookingController = Get.find();

  @override
  void initState() {
    _bookingController.getBusinessDetails(widget.businessId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const CommonAppBar(),
      body: Obx(
        () => _bookingController.businessDeatilsLoaded.value == true
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 90,
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Column(
                          //   children: [Icon(Icons.person), Text("500K")],
                          // ),
                          // const Spacer(),
                          Column(
                            children: [
                              Text(
                                _bookingController
                                        .singleBusinessInfo.businessData!.businessInfo!.name ??
                                    "",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                _bookingController
                                        .singleBusinessInfo.businessData!.businessInfo!.address ??
                                    "",
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                              )
                            ],
                          ),
                          // const Spacer(),
                          // const Column(
                          //   children: [
                          //     Icon(
                          //       Icons.thumb_up,
                          //       color: Colors.red,
                          //     ),
                          //     Text("500K")
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 5,
                      thickness: 5,
                      indent: 160,
                      endIndent: 160,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            _bookingController
                                    .singleBusinessInfo.businessData!.businessInfo!.bannerUrl ??
                                "https://editorial.uefa.com/resources/025c-0f8e775cc072-f99f8b3389ab-1000/the_new_tottenham_hotspur_stadium_has_an_unusual_flexible_playing_surface.jpeg",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                  fit: BoxFit.cover,
                                  "https://editorial.uefa.com/resources/025c-0f8e775cc072-f99f8b3389ab-1000/the_new_tottenham_hotspur_stadium_has_an_unusual_flexible_playing_surface.jpeg");
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: const EdgeInsets.all(14),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 49, 63, 91),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     margin: const EdgeInsets.all(5),
                          //     height: 50,
                          //     width: 100,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(80),
                          //       color: Colors.black38,
                          //     ),
                          //     child: const Text(
                          //       "Info",
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              _bookingController.getAllMatchesUnderBusiness(widget.businessId);
                              Get.to(() => const AllMatches(), transition: Transition.downToUp);
                              // Get.to(() => const LineUp(), transition: Transition.downToUp);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.black38,
                              ),
                              child: const Text(
                                "Upcomming",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.black38,
                            width: MediaQuery.of(context).size.width * .85,
                            height: 500,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .85,
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.sports_soccer_sharp, size: 50),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 200,
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Phone no: ",
                                                style: Theme.of(context).textTheme.labelLarge,
                                              ),
                                              Text(
                                                "${_bookingController.singleBusinessInfo.businessData!.businessInfo!.phoneNo}",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Email: ",
                                                style: Theme.of(context).textTheme.labelLarge,
                                              ),
                                              Text(
                                                "${_bookingController.singleBusinessInfo.businessData!.businessInfo!.email}",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Address: ",
                                                style: Theme.of(context).textTheme.labelLarge,
                                              ),
                                              Text(
                                                "${_bookingController.singleBusinessInfo.businessData!.businessInfo!.address}",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Business Time: ",
                                                style: Theme.of(context).textTheme.labelLarge,
                                              ),
                                              Text(
                                                "${_bookingController.singleBusinessInfo.businessData!.businessHours!.openTime} - ${_bookingController.singleBusinessInfo.businessData!.businessHours!.closeTime}",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.grey.withOpacity(0.5), // Semi-transparent grey color
                                      ),
                                      overlayColor: WidgetStatePropertyAll(
                                        Colors.white.withOpacity(0.2), // Color when pressed
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.to(() => const TimeSelection());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Book",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      Colors.green.withOpacity(0.8), // Glow color
                                                  blurRadius: 8.0,
                                                  spreadRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            child: Image.asset(
                                              "assets/images/arrowGreen.png",
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
                          Container(
                            width: MediaQuery.of(context).size.width * .12,
                            height: 500,
                            color: const Color.fromARGB(255, 49, 63, 91),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse(_bookingController.singleBusinessInfo
                                              .businessData!.businessInfo!.instagram ??
                                          ""));
                                    },
                                    child: Image.asset("assets/images/inst.png")),
                                InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse(_bookingController.singleBusinessInfo
                                              .businessData!.businessInfo!.facebook ??
                                          ""));
                                    },
                                    child: Image.asset("assets/images/fb.png")),
                                Image.asset("assets/images/btn.png"),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }
}
