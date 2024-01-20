import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mygame/core/auth/login.dart';
import 'package:mygame/utils/flow_decider.dart';

import '../../utils/enum_mapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      var userData = box.read('UserData');
      if (userData != null) {
        flowDecider(enumMapper(userData["data"]["userRole"]));
      } else {
        Get.to(() => const Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/grass.jpeg'),
                      fit: BoxFit.cover),
                )),
            Image.asset("assets/images/mygame.png")
          ])),
    );
  }
}
