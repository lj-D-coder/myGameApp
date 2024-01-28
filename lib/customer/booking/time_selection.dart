import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';
import 'package:mygame/utils/snackbar.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  DateTime? userSelectedDay = DateTime.now();
  var _selectedValue;
  var _selectedBookingType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: const CommonAppBar(),
        body: Container(
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
                      // Call `setState()` when updating the selected day
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
                                      style: const TextStyle(fontSize: 7),
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
                        "Select your Slot",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedValue = newValue.toString();
                        });
                      },
                      items: <String>[
                        'Select your Slot',
                        '8 am to 9 am',
                        '9 am to 10 am',
                        '10 am to 11 am',
                        '11 am to 12 am',
                        '12 am to 1 pm',
                        '2 pm to 3 pm',
                        '4 am to 5 pm',
                        '6 am to 7 pm',
                      ]
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
                  if (_selectedBookingType != null)
                    const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Text(
                          "\u20B9 500",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))
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
                    const SizedBox(
                      width: 30,
                    ),
                    if (_selectedBookingType == "Individual")
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.remove),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "1",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.add)
                            ],
                          ))
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  onPressed: () {
                    if (_selectedBookingType != null) {
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
}
