import 'package:flutter/material.dart';

class SetUp extends StatefulWidget {
  const SetUp({super.key});

  @override
  State<SetUp> createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  final _formKey = GlobalKey<FormState>();
  bool showInfo = false;

  final businessNameTextController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final breakTimeController = TextEditingController();
  final gameLengthController = TextEditingController();

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
            Form(
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
                      labelStyle: TextStyle(color: Colors.white, fontSize: 13),
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
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        setState(() {
                          startTimeController.text = value!.format(context);
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
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 13),
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
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        setState(() {
                          endTimeController.text = value!.format(context);
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
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 13),
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
                      labelStyle: TextStyle(color: Colors.white, fontSize: 13),
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
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
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
                          const Text("Open  Time:- Your business open time",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  height: 1.7)),
                          const Text("Close Time:- Your business closing time",
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
            ),
          ],
        ),
      ),
    );
  }
}
