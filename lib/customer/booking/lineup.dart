import 'package:flutter/material.dart';
import 'package:mygame/customer/common_widgets/common_app_bar.dart';

class LineUp extends StatefulWidget {
  const LineUp({super.key});

  @override
  State<LineUp> createState() => _LineUpState();
}

class _LineUpState extends State<LineUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Line Up",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Team A",
                      ),
                      const Text("3/7"),
                      for (var i = 0; i <= 6; i++)
                        i <= 3
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      "assets/images/user.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  const Text("James bond")
                                ],
                              )
                            : Container(
                                padding: const EdgeInsets.all(15),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      size: 30,
                                    ),
                                    Text("Empty Spot")
                                  ],
                                ),
                              )
                    ],
                  ),
                  const VerticalDivider(
                    width: 3,
                    color: Colors.grey,
                    thickness: 3,
                    endIndent: 140,
                    indent: 100,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Team B",
                      ),
                      const Text("4/7"),
                      for (var i = 0; i <= 6; i++)
                        i <= 4
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      "assets/images/user.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  const Text("James bond")
                                ],
                              )
                            : Container(
                                padding: const EdgeInsets.all(15),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      size: 30,
                                    ),
                                    Text("Empty Spot")
                                  ],
                                ),
                              ),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.grey.withOpacity(0.5), // Semi-transparent grey color
                ),
                overlayColor: MaterialStatePropertyAll(
                  Colors.white.withOpacity(0.2), // Color when pressed
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Join",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.8), // Glow color
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/red.png",
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
    );
  }
}
