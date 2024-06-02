import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mygame/main.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize(BuildContext context) async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _fcm.subscribeToTopic("GENERAL");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) => Center(
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor.withOpacity(1),
                ),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (message.notification!.title != null)
                        Text("${message.notification!.title}"),
                      const SizedBox(
                        height: 10,
                      ),
                      if (message.notification!.body != null)
                        Text(
                          "${message.notification!.body}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (message.data.containsKey("image"))
                        const SizedBox(
                          height: 5,
                        ),
                      if (message.data.containsKey("image"))
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 200,
                              width: 300,
                              child: Image.network(message.data["image"],
                                  height: 200, width: 300, fit: BoxFit.cover),
                            ))
                    ],
                  ),
                  Positioned(
                      top: 10,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.yellow,
                        ),
                      ))
                ]),
              ),
            ),
          ),
        );
      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    }
    getToken();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');

    return token;
  }
}
