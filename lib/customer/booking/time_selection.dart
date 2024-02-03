import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/success.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';
import 'package:mygame/models/req/booking_request.dart';
import 'package:mygame/utils/snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  final BookingController _bookingController = Get.find();
  DateTime? userSelectedDay = DateTime.now();
  var _selectedValue;
  var _selectedBookingType;
  late Razorpay _razorpay;

  @override
  void initState() {
    // Removes all listeners
    _razorpay = Razorpay();
    attachRazorPayListeners();

    super.initState();
  }

  void attachRazorPayListeners() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.to(() => const PaymentSuccessfulPage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: const CommonAppBar(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .25,
                child: TableCalendar(
                    calendarStyle: const CalendarStyle(
                        cellMargin: EdgeInsets.only(top: 20),
                        isTodayHighlighted: false,
                        selectedDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        weekendTextStyle: TextStyle(color: Colors.white),
                        tablePadding: EdgeInsets.all(20)),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (date, locale) =>
                          DateFormat.E(locale).format(date).toUpperCase(),
                      weekdayStyle:
                          const TextStyle(fontSize: 12, color: Colors.white),
                      weekendStyle:
                          const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    headerStyle: const HeaderStyle(
                        // decoration: BoxDecoration(
                        //  border: Border(bottom: BorderSide(color: Colors.grey,))
                        // ),
                        headerPadding: EdgeInsets.symmetric(horizontal: 20),
                        titleCentered: true,
                        formatButtonShowsNext: false,
                        formatButtonVisible: false),
                    selectedDayPredicate: (day) {
                      return isSameDay(userSelectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        userSelectedDay = selectedDay;
                      });
                    },
                    onPageChanged: (date) {
                      userSelectedDay = date;
                    },
                    calendarFormat: CalendarFormat.twoWeeks,
                    focusedDay: userSelectedDay!,
                    firstDay: DateTime.now().subtract(const Duration(days: 30)),
                    lastDay: DateTime.now().add(const Duration(days: 365))),
              ),
              const Text("Check Availability"),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: List.generate(24, (index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${index + 1}:00 ',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 12,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal:
                                              10), // Make the middle hour taller
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 40,
                                      height:
                                          4, // Adjust the width of the timeline bar
                                      color: Colors
                                          .white, // Color of the timeline bar
                                    ),
                                  ],
                                ),
                                if (index != 23)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 2,
                                        height: 10,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 20,
                                        height:
                                            4, // Adjust the width of the timeline bar
                                        color: Colors
                                            .white, // Color of the timeline bar
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Scroll Left or right to check free slot",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Select time slot",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Theme.of(context).primaryColor,
                      value: _selectedValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      hint: const Text(
                        "Select your Slot",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedValue = newValue.toString();
                        });
                      },
                      items: _bookingController.timeRanges
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Select booking type",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      )),
                  const Spacer(),
                  if (_selectedBookingType == "Individual")
                    Obx(
                      () => Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            "\u20B9 ${_bookingController.price!.value * _bookingController.qty.value}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    ),
                  if (_selectedBookingType == "Playground")
                    Obx(
                      () => Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            "\u20B9 ${_bookingController.price.value} / hr",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBookingType = "Playground";
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _selectedBookingType == "Playground"
                                ? Colors.green
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Playground",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBookingType = "Individual";
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _selectedBookingType == "Individual"
                                ? Colors.green
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Individual",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (_selectedBookingType == "Individual")
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Wrapped in a larger InkWell
                            InkWell(
                              onTap: () {
                                if (_bookingController.qty > 1) {
                                  _bookingController.qty =
                                      _bookingController.qty - 1;
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                    5), // Adjust the padding as needed
                                child: const Icon(Icons.remove),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Obx(
                              () => Text(
                                _bookingController.qty.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Wrapped in a larger InkWell
                            InkWell(
                              onTap: () {
                                _bookingController.qty =
                                    _bookingController.qty + 1;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                    5), // Adjust the padding as needed
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  onPressed: () {
                    if (_selectedBookingType != null &&
                        _selectedValue != null) {
                      GetStorage box = GetStorage();
                      var userData = box.read('UserData');
                      var userId = userData["userId"];
                      BookingRequest request = BookingRequest();
                      request.userId = userId;
                      request.businessID = _bookingController
                          .singleBusinessInfo.businessData!.businessID;
                      request.date =
                          userSelectedDay.toString().split(" ").first;
                      List<String> times = _selectedValue.split(" - ");

                      request.startTime = convertTo24HourFormat(times[0]);
                      request.endTime = convertTo24HourFormat(times[1]);

                      request.bookingType =
                          _selectedBookingType.toString().toLowerCase();
                      request.matchId = null;
                      request.sideChoose = "rightTeam";
                      request.userName = [userData["data"]["userName"]];

                      PaymentInfo paymentInfo = PaymentInfo();
                      paymentInfo.paymentMode = "online";
                      paymentInfo.amountPaid = _bookingController.price.value;
                      paymentInfo.quantity = _bookingController.qty.value;
                      paymentInfo.discount = 0;
                      request.paymentInfo = paymentInfo;
                      _bookingController.makeBooking(request).then((value) {
                        var options = {
                          'key': 'rzp_test_P7zizep0w8PLAX',
                          'amount': _bookingController.price.value * 100,
                          'name': 'myGame',
                          'description':
                              '${_bookingController.bookingResponse.bookingId} matchId',
                          'prefill': {
                            'contact': '${userData["data"]["phoneNo"] ?? ""}',
                            'email': "${userData["data"]["email"] ?? ""}"
                          }
                        };
                        _razorpay.open(options);
                      });
                    } else {
                      showSnackBar(context, "Please select a bookng type");
                    }
                  },
                  child: const Text("Make Payment")),
              Spacer(),
            ]),
          )),
        ));
  }

  String convertTo24HourFormat(String time) {
    // Parsing the time and splitting hours and minutes
    List<String> parts = time.split(":");
    int hours = int.parse(parts[0]);
    String minutes = parts[1].substring(0, 2);
    String meridian = time.substring(time.length - 2);

    // Converting to 24-hour format
    if (meridian == "PM" && hours < 12) {
      hours += 12;
    } else if (meridian == "AM" && hours == 12) {
      hours = 0;
    }

    // Formatting the result
    String hoursStr = hours.toString().padLeft(2, '0');
    return "$hoursStr:$minutes";
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
