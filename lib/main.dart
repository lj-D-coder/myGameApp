import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mygame/core/splash/splash_screen.dart';
import 'package:mygame/core/theme/my_game_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        defaultTransition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 500),
        debugShowCheckedModeBanner: false,
        title: 'MyGame',
        theme: myGameThemeLight,
        home: const SplashScreen());
  }
}
