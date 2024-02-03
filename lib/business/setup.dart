import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygame/business/business_controller.dart';
import 'package:mygame/models/req/pricing_request.dart';
import 'package:mygame/models/res/single_biz_info.dart' as model;
import 'package:mygame/utils/snackbar.dart';
import 'package:location/location.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class SetUp extends StatefulWidget {
  const SetUp({super.key});

  @override
  State<SetUp> createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GetStorage box = GetStorage();
  final _formKey = GlobalKey<FormState>();
  bool showInfo = false;
  final BusinessController businessController = Get.find();
  FocusNode individualPricenode = FocusNode();
  FocusNode teamPriceNode = FocusNode();
  FocusNode fieldBookingNode = FocusNode();
  XFile? image;
  LocationData? locationData;

  final businessNameTextController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final breakStart = TextEditingController();
  final breakEnd = TextEditingController();
  final gameLengthController = TextEditingController();
  final playerPerSide = TextEditingController();
  final emailController = TextEditingController();
  final gstTextController = TextEditingController();

  final locationText = TextEditingController();
  final address = TextEditingController();
  final individualPrice = TextEditingController();
  final teamPrice = TextEditingController();
  final fieldBooking = TextEditingController();
  List myMraker = [];

  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
  }

  String? _selectedValue = "Is custom length game"; // Initial value
  Map<String, dynamic> localbookingType = {};
  saveData() {
    if (businessNameTextController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        startTimeController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        gameLengthController.text.isNotEmpty &&
        playerPerSide.text.isNotEmpty &&
        address.text.isNotEmpty) {
      model.BusinessData businessData = model.BusinessData();
      model.BusinessInfo businessInfo = model.BusinessInfo();
      model.BookingType bookingType = model.BookingType();
      model.BusinessStatus businessStatus = model.BusinessStatus();
      model.BusinessHours businessHours = model.BusinessHours();
      model.Slot slot = model.Slot();
      businessInfo.name = businessNameTextController.text;
      businessInfo.email = emailController.text;
      businessInfo.gstNo = gstTextController.text;
      businessInfo.address = address.text;
      model.Location location = model.Location();
      location.latitude = locationText.text.split(",").first;
      location.longitude = locationText.text.split(",")[1];
      businessInfo.location = location;
      businessStatus.setupComplete = false;
      businessHours.openTime = startTimeController.text;
      businessHours.closeTime = endTimeController.text;
      businessHours.breakStart = breakStart.text;
      businessHours.breakEnd = breakEnd.text;
      bookingType = model.BookingType.fromJson(localbookingType);
      slot.playerPerSide = int.parse(playerPerSide.text);
      slot.customGameLength = _selectedValue == "yes" ? true : false;
      slot.gameLength = int.parse(gameLengthController.text);
      businessData.businessInfo = businessInfo;
      businessData.businessStatus = businessStatus;
      businessData.slot = slot;
      businessData.businessHours = businessHours;
      businessData.bookingType = bookingType;
      businessController.saveBusinessData(businessData);
    }
  }

  savePrice() {
    if (individualPrice.text.isNotEmpty ||
        teamPrice.text.isNotEmpty ||
        fieldBooking.text.isNotEmpty) {
      PricingRequest pricingRequest = PricingRequest();
      Price price = Price();
      Individual individual = Individual();
      Team team = Team();
      Field field = Field();
      individual.price = individualPrice.text;
      individual.type = "person";
      team.price = teamPrice.text;
      team.type = "team";
      field.price = fieldBooking.text;
      field.type = "field";
      price.individual = individual;
      price.team = team;
      price.field = field;
      var userData = box.read("UserData");
      var id = userData["userId"];
      pricingRequest.businessID = id;
      pricingRequest.price = price;

      businessController.savePrice(pricingRequest);
    } else {
      showSnackBar(context, "Fill at least one price");
    }
  }

  saveImage() {
    if (image != null && image!.path.isNotEmpty) {
      businessController.uploadFile(File(image!.path));
    } else {
      showSnackBar(context, "Please select one image");
    }
  }

  void initializeData() {
    if (businessController.singleBusinessInfo.businessData != null) {
      businessNameTextController.text = businessController
              .singleBusinessInfo.businessData!.businessInfo!.name ??
          "";
      emailController.text = businessController
              .singleBusinessInfo.businessData!.businessInfo!.email ??
          "";
      startTimeController.text = businessController
              .singleBusinessInfo.businessData!.businessHours!.openTime ??
          "";
      endTimeController.text = businessController
              .singleBusinessInfo.businessData!.businessHours!.closeTime ??
          "";
      breakStart.text = businessController
              .singleBusinessInfo.businessData!.businessHours!.breakStart ??
          "";
      breakEnd.text = businessController
              .singleBusinessInfo.businessData!.businessHours!.breakEnd ??
          "";
      gstTextController.text = businessController
              .singleBusinessInfo.businessData!.businessInfo!.gstNo ??
          "";

      playerPerSide.text = businessController
          .singleBusinessInfo.businessData!.slot!.playerPerSide
          .toString();

      localbookingType = businessController
          .singleBusinessInfo.businessData!.bookingType!
          .toJson();

      gameLengthController.text = businessController
          .singleBusinessInfo.businessData!.slot!.gameLength
          .toString();
      if (businessController
              .singleBusinessInfo.businessData!.businessInfo!.location !=
          null) {
        locationText.text =
            "${businessController.singleBusinessInfo.businessData!.businessInfo!.location!.latitude!},${businessController.singleBusinessInfo.businessData!.businessInfo!.location!.longitude!}";
      }

      address.text = businessController
              .singleBusinessInfo.businessData!.businessInfo!.address ??
          "";
      _selectedValue = businessController
                  .singleBusinessInfo.businessData!.slot!.customGameLength ==
              true
          ? "Yes"
          : "No";

      WidgetsBinding.instance.addPostFrameCallback((time) {
        showDialog(
            context: context,
            builder: (ctx) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: StatefulBuilder(
                  builder: (ctx, state) => Center(
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        height: 250,
                        width: 350,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Welcome to myGame!",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const Text(
                                    "We have already pre-filled some information!",
                                    style: TextStyle(fontSize: 17),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Ok"))
                                ]),
                          ),
                        )),
                  ),
                ),
              );
            });
      });
    }
  }

  @override
  void initState() {
    getLocation();
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Business Setup",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 25,
                    )),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => businessController.step.value == 1
                  ? Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: businessNameTextController,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Business Name is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              isDense: true,
                              focusColor: Colors.white,
                              labelText: "Business Name *",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              isDense: true,
                              focusColor: Colors.white,
                              labelText: "Email *",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: gstTextController,
                            cursorColor: Colors.white,
                            validator: (value) {},
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              isDense: true,
                              focusColor: Colors.white,
                              labelText: "GST (optional) *",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  startTimeController.text =
                                      value!.format(context);
                                });
                              });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                controller: startTimeController,
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Open Time is required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText: "Open Time *",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  endTimeController.text =
                                      value!.format(context);
                                });
                              });
                            },
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: endTimeController,
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Close Time is required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  isDense: true,
                                  helperStyle: TextStyle(),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText: "Close Time *",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  breakStart.text = value!.format(context);
                                });
                              });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                controller: breakStart,
                                cursorColor: Colors.white,
                                validator: (value) {},
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText: "Break Start (optional)",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  breakEnd.text = value!.format(context);
                                });
                              });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                controller: breakEnd,
                                cursorColor: Colors.white,
                                validator: (value) {},
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText: "Break End (optional)",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: playerPerSide,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Player per side is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              helperStyle: TextStyle(),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusColor: Colors.white,
                              labelText: "Player per side length",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: gameLengthController,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Game Length is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              helperStyle: TextStyle(),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusColor: Colors.white,
                              labelText: "Game length (in minutes) *",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            padding: EdgeInsets.all(16.0),
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
                                  "Is custom length game",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: const TextStyle(color: Colors.white),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedValue = newValue.toString();
                                  });
                                },
                                items: <String>[
                                  'Is custom length game',
                                  'Yes',
                                  'No'
                                ]
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, top: 8.0),
                                  child: Text("Select Booking Type"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      localbookingType.keys.map((String key) {
                                    return CheckboxListTile(
                                      dense: true,
                                      title: Text(key),
                                      value: localbookingType[key]!,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          localbookingType[key] = value!;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (locationData != null) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                height: 500,
                                                width: 500,
                                                child: PointerInterceptor(
                                                  child: StatefulBuilder(
                                                    builder: (context, state) {
                                                      return GoogleMap(
                                                          markers: Set.from(
                                                              myMraker),
                                                          onTap: (tappedPoint) {
                                                            myMraker = [];
                                                            myMraker.add(Marker(
                                                                markerId: MarkerId(
                                                                    tappedPoint
                                                                        .toString()),
                                                                position:
                                                                    tappedPoint));
                                                            locationText.text =
                                                                "${tappedPoint.latitude},${tappedPoint.longitude}";

                                                            state(() {});
                                                            Get.back();
                                                          },
                                                          onMapCreated:
                                                              (GoogleMapController
                                                                  controller) {
                                                            _controller
                                                                .complete(
                                                                    controller);
                                                          },
                                                          myLocationEnabled:
                                                              true,
                                                          myLocationButtonEnabled:
                                                              true,
                                                          initialCameraPosition:
                                                              CameraPosition(
                                                                  zoom: 30,
                                                                  target: LatLng(
                                                                      locationData!
                                                                          .latitude!,
                                                                      locationData!
                                                                          .longitude!)));
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 25,
                                                top: 25,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: const CircleAvatar(
                                                    maxRadius: 15,
                                                    minRadius: 15,
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                showSnackBar(
                                    context, "Location still initializing");
                              }
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                controller: locationText,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                validator: (value) {},
                                decoration: const InputDecoration(
                                  isDense: true,
                                  helperStyle: TextStyle(),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText: "Location on Map",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: address,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              helperStyle: TextStyle(),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusColor: Colors.white,
                              labelText: "Address*",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      showInfo = true;
                                    });
                                  },
                                  child: const Icon(Icons.info)),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      saveData();
                                    }
                                  },
                                  child: const Text("SAVE")),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedOpacity(
                            opacity: showInfo ? 1 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white.withOpacity(.1),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            showInfo = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                        ),
                                      )),
                                  const Text(
                                      "Open  Time:- Your business open time",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          height: 1.7)),
                                  const Text(
                                      "Close Time:- Your business closing time",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          height: 1.7)),
                                  const Text(
                                      "Break Time:- Lunch/Break time if any in your business",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          height: 1.7)),
                                  const Text(
                                      "Game  Length:- Time for 1 game (e.g 45 min or 90 min)",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          height: 1.7)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : businessController.step.value == 2
                      ? Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                focusNode: individualPricenode,
                                controller: individualPrice,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                decoration: const InputDecoration(
                                  prefix: Text(
                                    "\u20B9 ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  isDense: true,
                                  helperStyle: TextStyle(),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText:
                                      "Indiviual Price (price for single player)",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                focusNode: teamPriceNode,
                                controller: teamPrice,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                decoration: const InputDecoration(
                                  prefix: Text(
                                    "\u20B9 ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  isDense: true,
                                  helperStyle: TextStyle(),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText:
                                      "Team Price (price for team booking)",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                focusNode: fieldBookingNode,
                                controller: fieldBooking,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                                decoration: const InputDecoration(
                                  prefix: Text(
                                    "\u20B9 ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  isDense: true,
                                  helperStyle: TextStyle(),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusColor: Colors.white,
                                  labelText:
                                      "Field Booking Price (rate per hour)",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    savePrice();
                                  },
                                  child: const Text("SAVE")),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (image != null)
                              Container(
                                height: 200,
                                child: Image.file(File(image!.path),
                                    fit: BoxFit.cover),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                var imagePicker = ImagePicker();
                                image = await imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 10,
                                );
                                if (image != null) {
                                  print(image!.path);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    image != null
                                        ? Text("Change Image for Banner Url")
                                        : Text("Select Image for Banner Url")
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    saveImage();
                                  },
                                  child: const Text("SAVE")),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
