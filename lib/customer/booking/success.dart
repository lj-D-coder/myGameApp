import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/core/user_type.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/homescreen.dart';
import 'package:mygame/models/req/confirm_booking.dart';

class PaymentSuccessfulPage extends StatefulWidget {
  const PaymentSuccessfulPage({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessfulPage> createState() => _PaymentSuccessfulPageState();
}

class _PaymentSuccessfulPageState extends State<PaymentSuccessfulPage>
    with TickerProviderStateMixin {
  late AnimationController _tickAnimationController;
  final BookingController _bookingController = Get.find();
  final ConfirmBookingRequest confirmBookingRequest = ConfirmBookingRequest();

  @override
  void initState() {
    super.initState();
    _tickAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      upperBound: 1.2,
      lowerBound: 0.8,
    );

    confirmBookingRequest.bookingId =
        _bookingController.bookingResponse.bookingId;
    _bookingController.confirmBooking(confirmBookingRequest).then((value) {
      _tickAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _tickAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: _bookingController.confirmBookingStatus.value == ""
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                              scale: _tickAnimationController,
                              child: _bookingController
                                          .confirmBookingStatus.value ==
                                      "success"
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 150,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 150,
                                    )),
                          const SizedBox(height: 20),
                          _bookingController.confirmBookingStatus.value ==
                                  "success"
                              ? const Text(
                                  'Payment Successful',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  "Payment Failed",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                          const SizedBox(height: 20),
                          _bookingController.confirmBookingStatus.value ==
                                  "success"
                              ? const Text(
                                  'Your payment was processed successfully!',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                )
                              : const Text(
                                  'Your payment has failed.\n Please contact customer care',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                        ],
                      ),
                    ),
                    // Close icon at the top right corner
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 35,
                          ),
                          onPressed: () {
                            // Add any action you want when the close button is pressed
                            Get.offAll(() => const MyHomePage(
                                  userType: UserType.player,
                                )); // Closes the page
                          },
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
