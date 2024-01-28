import 'package:flutter/material.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  final ScrollController _textAController = ScrollController();
  final ScrollController _textBController = ScrollController();
  final ScrollController _pageController = ScrollController();
  bool _scrolling = false;

  getMinMaxPosition(double tryScrollTo) {
    return tryScrollTo < _pageController.position.minScrollExtent
        ? _pageController.position.minScrollExtent
        : tryScrollTo > _pageController.position.maxScrollExtent
            ? _pageController.position.maxScrollExtent
            : tryScrollTo;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is OverscrollNotification &&
              notification.velocity == 0 &&
              (notification.metrics.axisDirection == AxisDirection.down ||
                  notification.metrics.axisDirection == AxisDirection.up)) {
            var scrollTo = getMinMaxPosition(
                _pageController.position.pixels + (notification.overscroll));
            _pageController.jumpTo(scrollTo);
          } else if (notification is OverscrollNotification &&
              (notification.metrics.axisDirection == AxisDirection.down ||
                  notification.metrics.axisDirection == AxisDirection.up)) {
            var yVelocity = notification.velocity;
            _scrolling = true;
            var scrollTo = getMinMaxPosition(
                _pageController.position.pixels + (yVelocity / 5));
            _pageController
                .animateTo(scrollTo,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.linearToEaseOut)
                .then((value) => _scrolling = false);
          } else if (notification is ScrollEndNotification &&
              notification.depth > 0 &&
              !_scrolling &&
              (notification.metrics.axisDirection == AxisDirection.down ||
                  notification.metrics.axisDirection == AxisDirection.up)) {
            var yVelocity =
                notification.dragDetails?.velocity.pixelsPerSecond.dy ?? 0;
            var scrollTo = getMinMaxPosition(
                _pageController.position.pixels - (yVelocity / 5));
            var scrollToPractical =
                scrollTo < _pageController.position.minScrollExtent
                    ? _pageController.position.minScrollExtent
                    : scrollTo > _pageController.position.maxScrollExtent
                        ? _pageController.position.maxScrollExtent
                        : scrollTo;
            _pageController.animateTo(scrollToPractical,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.linearToEaseOut);
          }
          return true;
        },
        child: ListView(controller: _pageController, children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 63, 91),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Grounds nearby you",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (ctx, index) => Container(
                      margin: const EdgeInsets.all(5),
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "https://media.hudle.in/venues/2eb223fa-f9f5-4f64-a73c-40986bb91442/photo/d6d08022281596c32755ac999fa26fb9c6af2f4c",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 63, 91),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Trending Matches",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "View All",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _textAController,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (ctx, index) => Container(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      margin: const EdgeInsets.all(5),
                      height: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "12 am to 1 pm",
                                style: TextStyle(color: Colors.red),
                              ),
                              Spacer(),
                              Text("\u20B9 250")
                            ],
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Imphal Football"),
                                  Text(
                                    "Khuman Lampak Staium",
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  "Join",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "7a side (7X7)",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Transform.scale(
                                scale: .7,
                                child: Slider(value: .7, onChanged: (value) {}),
                              ),
                              const Text("3 left")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 63, 91),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Your Feed",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 180,
                  ),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: _textBController,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (ctx, index) => Container(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      margin: const EdgeInsets.all(5),
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Has join a matched @ 1/23/2024",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    "Khuman Lampak Staium",
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  "Join",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
