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
      duration: Duration(seconds: 1),
      upperBound: 1.2,
      lowerBound: 0.8,
    );

    _tickAnimationController.forward();
    confirmBookingRequest.bookingId =
        _bookingController.bookingResponse.bookingId;
    _bookingController.confirmBooking(confirmBookingRequest);
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
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _tickAnimationController,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Payment Successful',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your payment was processed successfully!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
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
                  icon: Icon(
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
    );
  }
}
