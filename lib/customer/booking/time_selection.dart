import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/booking/booking_controller.dart';
import 'package:mygame/customer/booking/success.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';
import 'package:mygame/models/req/booking_dropped.dart';
import 'package:mygame/models/req/booking_request.dart';
import 'package:mygame/models/req/get_ranges_req.dart';
import 'package:mygame/utils/constants.dart';
import 'package:mygame/utils/snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> with WidgetsBindingObserver {
  final BookingController _bookingController = Get.find();
  DateTime? userSelectedDay = DateTime.now();
  final TextEditingController _multiSlotTextEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? subscription;
  GetRangesReq getRangesReq = GetRangesReq();
  bool initialAddFlag = true;
  var _selectedValue;
  var _selectedBookingType;
  List _selectedSlotValues = [];
  late Razorpay _razorpay;

  Map occupiedDays = {};

  void setAfterFirebaseDataChanges(bool showloader) async {
    getAllMatches(userSelectedDay!.millisecondsSinceEpoch ~/ 1000).then((value) {
      setState(() {});
    });
    _selectedValue = null;
    if (_selectedBookingType == Constants.INDIVIDUAL) {
      _bookingController.getTimeRanges(getRangesReq, showloader).then((value) {
        setState(() {});
      });
    } else if (_selectedBookingType == Constants.PLAYGROUND) {
      _bookingController.getTimeRangesPlaygroud(getRangesReq, showloader).then((value) {
        setState(() {});
      });
    }
  }

  void listenToDataChanges() {
    subscription = _firestore.collection('matchesCollection').where('businessID').snapshots().listen((QuerySnapshot snapshot) {
      getRangesReq.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
      getRangesReq.date = userSelectedDay.toString().split(" ").first;
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          if (initialAddFlag == false) {
            setAfterFirebaseDataChanges(false);
          }
        } else if (change.type == DocumentChangeType.modified) {
          setAfterFirebaseDataChanges(false);
        } else if (change.type == DocumentChangeType.removed) {
          setAfterFirebaseDataChanges(false);
        }
      }
      initialAddFlag = false;
    });
  }

  Future<void> getAllMatches(timestamp) async {
    occupiedDays.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('matchesCollection').where('businessID', isEqualTo: "65bbb352f5f90fa337eeb5b4").where('matchDate', isEqualTo: timestamp).get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      print(querySnapshot.docs[i].data());
      occupiedDays.addAll({convertTimeStampT24(querySnapshot.docs[i].get("StartTimestamp")): convertTimeStampT24(querySnapshot.docs[i].get("EndTimestamp"))});
    }
    setState(() {});
  }

  String convertTimeStampT24(timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    String formattedTime = _twoDigits(dateTime.hour);
    return formattedTime;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  void initState() {
    initialAddFlag = true;
    _bookingController.price.value = double.parse(_bookingController.singleBusinessInfo.pricingData!.price!.individual!.price!);
    _bookingController.fieldPrice.value = double.parse(_bookingController.singleBusinessInfo.pricingData!.price!.field!.price!);

    _bookingController.qty.value = 1;
    _selectedBookingType = Constants.INDIVIDUAL;
    _selectedSlotValues = [];

    _razorpay = Razorpay();

    attachRazorPayListeners();

    getRangesReq.date = userSelectedDay.toString().split(" ").first;
    getRangesReq.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
    _bookingController
        .getTimeRanges(
      getRangesReq,
    )
        .then((value) {
      setState(() {});
    });

    userSelectedDay = DateTime.parse("${userSelectedDay.toString().split(" ").first} 00:00:00.000Z");
    getAllMatches(userSelectedDay!.millisecondsSinceEpoch ~/ 1000);

    listenToDataChanges();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      if (_bookingController.bookingResponse.bookingId != null) {
        BookingDropped bookingDropped = BookingDropped();
        bookingDropped.bookingId = _bookingController.bookingResponse.bookingId;
        _bookingController.droppedBooking(bookingDropped);
      }
    }
    super.didChangeAppLifecycleState(state);
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
    BookingDropped bookingDropped = BookingDropped();
    bookingDropped.bookingId = _bookingController.bookingResponse.bookingId;
    _bookingController.droppedBooking(bookingDropped);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  Future<void> makeBooking() async {
    if (_selectedBookingType != null && ((_selectedValue != null) || (_selectedSlotValues.isNotEmpty))) {
      Map<String, dynamic> options = {};
      GetStorage box = GetStorage();
      var userData = box.read('UserData');
      var userId = userData["userId"];
      BookingRequest request = BookingRequest();
      request.userId = userId;
      request.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
      request.date = userSelectedDay.toString().split(" ").first;

      if (_selectedBookingType == Constants.PLAYGROUND) {
        request.startTime = convertTo24HourFormat(_selectedSlotValues[0].toString().split(" - ").first);
        request.endTime = convertTo24HourFormat(_selectedSlotValues.last.toString().split(" - ").last);
        request.noOfSlot = _selectedSlotValues.length;
      } else {
        List<String> times = _selectedValue.split(" - ");
        request.startTime = convertTo24HourFormat(times[0]);
        request.endTime = convertTo24HourFormat(times[1]);
        request.noOfSlot = 1;
      }

      request.bookingType = _selectedBookingType.toString().toLowerCase();
      request.sideChoose = "rightTeam";

      PaymentInfo paymentInfo = PaymentInfo();
      paymentInfo.paymentMode = "online";

      if (_selectedBookingType == Constants.PLAYGROUND) {
        paymentInfo.amountPaid = _bookingController.fieldPrice.value.toInt() * _bookingController.qty.value;
        paymentInfo.quantity = 1;
      } else {
        paymentInfo.amountPaid = _bookingController.price.value.toInt() * _bookingController.qty.value;
        paymentInfo.quantity = _bookingController.qty.value;
      }

      paymentInfo.discount = 0;
      request.paymentInfo = paymentInfo;
      List<String> userNames = [];
      if (_selectedBookingType == Constants.INDIVIDUAL) {
        Map<int, String> playerNames = {};
        playerNames.addAll({0: userData["data"]["userName"]});
        if (_bookingController.qty.value > 1) {
          await showModalBottomSheet(
              backgroundColor: Theme.of(context).primaryColor,
              context: context,
              isScrollControlled: true,
              builder: (ctx) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        const Text(
                          "Please fill the player names",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        for (var i = 0; i < _bookingController.qty.value; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                if (playerNames.containsKey(i)) {
                                  playerNames.update(i, (v) => value);
                                } else {
                                  playerNames.addAll({i: value});
                                }
                              },
                              decoration: InputDecoration(hintText: i == 0 ? userData["data"]["userName"] : "Player name", hintStyle: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  for (var i = 0; i < _bookingController.qty.value; i++) {
                                    userNames.add(userData["data"]["userName"]);
                                  }
                                  print(userNames);
                                  Get.back();
                                },
                                child: const Text(
                                  "Skip",
                                  style: TextStyle(color: Colors.white),
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  for (var i = 0; i < playerNames.values.toList().length; i++) {
                                    userNames.add(playerNames.values.toList()[i]);
                                  }
                                  var diff = _bookingController.qty.value - playerNames.values.toList().length;
                                  for (var i = 0; i < diff; i++) {
                                    userNames.add(userData["data"]["userName"]);
                                  }
                                  print(userNames);
                                  Get.back();
                                },
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
          if (userNames.isNotEmpty) {
            request.userName = userNames;
            _bookingController.makeBooking(request).then((value) {
              options = rzpOptions(userData);
              _razorpay.open(options);
            }).onError((error, stackTrace) {
              showSnackBar(context, "Something went wrong");
            });
          }
        } else {
          userNames.add(userData["data"]["userName"]);
          request.userName = userNames;
          _bookingController.makeBooking(request).then((value) {
            options = rzpOptions(userData);
            _razorpay.open(options);
          }).onError((error, stackTrace) {
            showSnackBar(context, "Something went wrong");
          });
        }
      } else {
        userNames.add(userData["data"]["userName"]);
        request.userName = userNames;
        _bookingController.makeBooking(request).then((value) {
          options = rzpOptions(userData);
          _razorpay.open(options);
        }).onError((error, stackTrace) {
          showSnackBar(context, "Something went wrong");
        });
      }
    } else {
      showSnackBar(context, "Please select all the required fields");
    }
  }

  void rzpCall() {}

  Map<String, dynamic> rzpOptions(userData) {
    return {
      'key': 'rzp_test_P7zizep0w8PLAX',
      'amount': (_bookingController.bookingResponse.rzpOrder!.amount),
      'name': 'myGame',
      'order_id': _bookingController.bookingResponse.rzpOrder!.id,
      'description': '${_bookingController.bookingResponse.bookingId} matchId',
      'prefill': {'contact': '${userData["data"]["phoneNo"] ?? ""}', 'email': "${userData["data"]["email"] ?? ""}"}
    };
  }

  bool checkSlotAferCurentTime(timeRange) {
    if (isSameDay(userSelectedDay, DateTime.now())) {
      DateTime currentTime = DateTime.now();
      List<String> times = timeRange.split(' - ');
      String startTimeString = times[0];

      // Parse the start time string
      List<String> startTimeComponents = startTimeString.split(':');
      int startHour = int.parse(startTimeComponents[0]);
      int startMinute = int.parse(startTimeComponents[1].split(' ')[0]);
      String startMeridiem = startTimeComponents[1].split(' ')[1];

      // Convert start time to 24-hour format
      if (startMeridiem == 'PM' && startHour < 12) {
        startHour += 12;
      } else if (startMeridiem == 'AM' && startHour == 12) {
        startHour = 0;
      }

      // Check if the start time is after the current time
      if (currentTime.hour < startHour || (currentTime.hour == startHour && currentTime.minute < startMinute)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: const CommonAppBar(),
        body: Obx(
          () => _bookingController.getRangesLoaded.value == false
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height - 60,
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
                            dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date).toUpperCase(),
                            weekdayStyle: const TextStyle(fontSize: 12, color: Colors.white),
                            weekendStyle: const TextStyle(fontSize: 12, color: Colors.white),
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
                            if (selectedDay.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
                              clearSnackBar(context);
                              setState(() {
                                userSelectedDay = selectedDay;
                              });
                              getRangesReq.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
                              getRangesReq.date = userSelectedDay.toString().split(" ").first;
                              _selectedValue = null;

                              setAfterFirebaseDataChanges(true);
                            } else {
                              showSnackBar(context, "Cannot book past days");
                            }
                          },
                          onPageChanged: (date) {
                            userSelectedDay = date;
                            getRangesReq.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
                            getRangesReq.date = userSelectedDay.toString().split(" ").first;
                            _selectedValue = null;
                            _multiSlotTextEditingController.clear();
                            _selectedSlotValues.clear();

                            setAfterFirebaseDataChanges(true);
                            setState(() {});
                          },
                          calendarFormat: CalendarFormat.twoWeeks,
                          focusedDay: userSelectedDay!,
                          firstDay: DateTime.now().subtract(const Duration(days: 30)),
                          lastDay: DateTime.now().add(const Duration(days: 365))),
                    ),
                    if (_selectedBookingType == Constants.PLAYGROUND)
                      Column(
                        children: [
                          const Text("Check Availability"),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40.0,
                              right: 40,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: List.generate(25, (index) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$index:00",
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 59),
                                                  child: Container(
                                                    height: 12,
                                                    width: 3,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            index != 24 ? Container(height: 3, width: 60, color: occupiedDays.containsKey((index < 10 ? "0${index}" : "${index}")) ? Colors.red : Colors.white) : Container(height: 3, width: 60, color: occupiedDays.containsKey((index < 10 ? "0${index}" : "${index}")) ? Colors.red : Colors.white)
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
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Select booking type",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedBookingType = Constants.PLAYGROUND;
                              });
                              _selectedValue = null;
                              getRangesReq.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
                              getRangesReq.date = userSelectedDay.toString().split(" ").first;
                              _bookingController.getTimeRangesPlaygroud(getRangesReq, true).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: _selectedBookingType == Constants.PLAYGROUND ? Colors.green : Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: const Text(
                                Constants.PLAYGROUND,
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
                                _selectedBookingType = Constants.INDIVIDUAL;
                              });
                              _multiSlotTextEditingController.clear();
                              _selectedSlotValues.clear();
                              getRangesReq.businessID = _bookingController.singleBusinessInfo.businessData!.businessID;
                              getRangesReq.date = userSelectedDay.toString().split(" ").first;
                              _bookingController.getTimeRanges(getRangesReq, true).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: _selectedBookingType == Constants.INDIVIDUAL ? Colors.green : Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: const Text(
                                Constants.INDIVIDUAL,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            "Total:  ",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          if (_selectedBookingType == Constants.INDIVIDUAL)
                            Obx(
                              () => Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "\u20B9 ${_bookingController.price.value * _bookingController.qty.value}",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  )),
                            ),
                          if (_selectedBookingType == Constants.PLAYGROUND)
                            Obx(
                              () => Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "\u20B9 ${_bookingController.fieldPrice.value}",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  )),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade700,
                    ),
                    if (_selectedBookingType == Constants.INDIVIDUAL)
                      const SizedBox(
                        height: 20,
                      ),
                    if (_selectedBookingType == Constants.INDIVIDUAL)
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  "No. of Person",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                Text("Add teamates(optional)")
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            alignment: Alignment.center,
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Wrapped in a larger InkWell
                                InkWell(
                                  onTap: () {
                                    if (_bookingController.qty > 1) {
                                      _bookingController.qty = _bookingController.qty - 1;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5), // Adjust the padding as needed
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
                                    if (_bookingController.qty < _bookingController.singleBusinessInfo.businessData!.slot!.playerPerSide! * 2) {
                                      _bookingController.qty = _bookingController.qty + 1;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5), // Adjust the padding as needed
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (_selectedBookingType == Constants.INDIVIDUAL)
                      Divider(
                        height: 50,
                        thickness: 1,
                        color: Colors.grey.shade700,
                      ),
                    if (_selectedBookingType != Constants.INDIVIDUAL)
                      const SizedBox(
                        height: 20,
                      ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Select time slot",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )),
                    _selectedBookingType == Constants.INDIVIDUAL
                        ? Padding(
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
                                    if (_bookingController.getRangesResponse.timeRanges!.toJson()[newValue] == "close") {
                                      showSnackBar(context, "This slot is fully booked, Please select another slot");
                                    } else if (checkSlotAferCurentTime(newValue) == false) {
                                      showSnackBar(context, "Cannot select past time slot, Please select another slot");
                                    } else {
                                      setState(() {
                                        _selectedValue = newValue.toString();
                                      });
                                    }
                                  },
                                  items: _bookingController.getRangesResponse.timeRanges!
                                      .toJson()
                                      .keys
                                      .toList()
                                      .map<DropdownMenuItem<String>>(
                                        (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(value),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: 25,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: _bookingController.getRangesResponse.timeRanges!.toJson()[value]! == "close" ? Colors.red : Colors.green,
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                                child: Text(
                                                  _bookingController.getRangesResponse.timeRanges!.toJson()[value]!,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              _selectedSlotValues.clear();
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return StatefulBuilder(
                                      builder: (ctx, state) => Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 600,
                                                width: MediaQuery.of(context).size.width - 40,
                                                color: Theme.of(context).primaryColor,
                                                child: SingleChildScrollView(
                                                    child: Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Column(
                                                    children: [
                                                      ..._bookingController.getRangesResponse.timeRanges!.toJson().keys.toList().map((e) {
                                                        return InkWell(
                                                          onTap: () {
                                                            if (_bookingController.getRangesResponse.timeRanges!.toJson()[e] == "close") {
                                                              showSnackBar(context, "This slot is fully booked, Please select another slot");
                                                            } else if (checkSlotAferCurentTime(e) == false) {
                                                              showSnackBar(context, "Cannot select past time slot, Please select another slot");
                                                            } else if (_selectedSlotValues.isEmpty) {
                                                              _selectedSlotValues.add(e);
                                                              state(() {});
                                                            } else if (_selectedSlotValues.isNotEmpty) {
                                                              var found = 0;
                                                              for (var i = 0; i < _selectedSlotValues.length; i++) {
                                                                if ((e.split(" - ")[0] == _selectedSlotValues[i].toString().split(" - ")[1]) || (e.split(" - ")[1] == _selectedSlotValues[i].toString().split(" - ")[0])) {
                                                                  _selectedSlotValues.add(e);
                                                                  state(() {});
                                                                  found = 1;
                                                                }
                                                              }
                                                              if (found == 0) {
                                                                showSnackBar(context, "Error! Only adjacent free slots can be selected");
                                                              }
                                                            } else {
                                                              showSnackBar(context, "Something went wrong");
                                                            }
                                                          },
                                                          child: SizedBox(
                                                            height: 50,
                                                            width: MediaQuery.of(context).size.width - 40,
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                if (_selectedSlotValues.contains(e))
                                                                  const Icon(
                                                                    Icons.check,
                                                                    color: Colors.green,
                                                                  ),
                                                                if (_selectedSlotValues.contains(e))
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                Text(e),
                                                                const SizedBox(
                                                                  width: 30,
                                                                ),
                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  height: 25,
                                                                  width: 60,
                                                                  decoration: BoxDecoration(
                                                                    color: _bookingController.getRangesResponse.timeRanges!.toJson()[e]! == "close" ? Colors.red : Colors.green,
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                  ),
                                                                  child: Text(
                                                                    _bookingController.getRangesResponse.timeRanges!.toJson()[e]!,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ],
                                                  ),
                                                )),
                                              ),
                                              Positioned(
                                                  right: 10,
                                                  top: 10,
                                                  child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: const Icon(Icons.close, color: Colors.white, size: 30))),
                                              if (_selectedSlotValues.isNotEmpty)
                                                Positioned(
                                                    right: 10,
                                                    bottom: 10,
                                                    child: InkWell(
                                                        onTap: () {
                                                          _selectedSlotValues.sort();
                                                          _multiSlotTextEditingController.text = _selectedSlotValues.join(", ");
                                                          _bookingController.fieldPrice.value = _selectedSlotValues.length * double.parse(_bookingController.singleBusinessInfo.pricingData!.price!.field!.price!);
                                                          Get.back();
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(5.0),
                                                          ),
                                                          alignment: Alignment.center,
                                                          child: const Text(
                                                            "Done",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(decoration: InputDecoration(hintText: "Select your Slot", hintStyle: TextStyle(color: Colors.white, fontSize: 13), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade700, width: 1))), controller: _multiSlotTextEditingController),
                              ),
                            ),
                          ),
                    const Spacer(),
                    ElevatedButton(
                        style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                        onPressed: () {
                          makeBooking();
                        },
                        child: const Text("Make Payment")),
                    const SizedBox(
                      height: 50,
                    )
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
    subscription!.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
