import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? userSelectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: 16,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.only(left:20,right: 15,bottom: 10),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 49, 63, 91),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: Column(
                      children: [
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple,
                            maxRadius: 20,
                          ),
                          subtitle: Text("Khuman Lampak Stadium"),
                          title: Text(
                            "The Imphal Football",
                          ),
                          trailing: Icon(Icons.pin_drop),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Scheduled",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.grey.shade400)),
                                      Text("10:00 am to 12:00 pm",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.grey.shade400)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text("\u20B9 250"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.center,
                                              height: 25,
                                              width: 50,
                                              child: Text(
                                                "Line Up",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Colors.black),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.center,
                                              height: 25,
                                              width: 50,
                                              child: Text(
                                                "BUY",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
