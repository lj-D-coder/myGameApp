import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygame/customer/following/follower_list.dart';
import 'package:mygame/customer/settings/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsController settingsController = Get.put(SettingsController());
  XFile? image;

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    settingsController.userProfile.clear();
    settingsController.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: settingsController.userProfile.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            var imagePicker = ImagePicker();
                            image = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 10,
                            );
                            if (image != null) {
                              setState(() {});
                              settingsController.uploadProfile(File(image!.path));
                            }
                          },
                          child: CircleAvatar(
                            minRadius: 40,
                            maxRadius: 40,
                            backgroundImage:
                                NetworkImage(settingsController.userProfile['profilePic']),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              settingsController.userProfile["name"],
                              style:
                                  Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text("Following"),
                              Text(
                                settingsController.userProfile["following"].toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                            child: VerticalDivider(
                              color: Colors.amber,
                              thickness: 2,
                              width: 50,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const FollowerList());
                            },
                            child: Column(
                              children: [
                                const Text("Follower"),
                                Text(
                                  settingsController.userProfile["follower"].toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        onTap: () {
                          _launchUrl(Uri.parse(
                              "${settingsController.userProfile["domain"].toString()}/misc/support.html"));
                        },
                        contentPadding: EdgeInsets.zero,
                        title:
                            Text("Customer Support", style: Theme.of(context).textTheme.bodyLarge),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )),
                    ListTile(
                        onTap: () {
                          _launchUrl(Uri.parse(
                              "${settingsController.userProfile["domain"].toString()}/misc/privacy-policy.html"));
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text("Privacy Policy", style: Theme.of(context).textTheme.bodyLarge),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )),
                    ListTile(
                        onTap: () {
                          _launchUrl(Uri.parse(
                              "${settingsController.userProfile["domain"].toString()}/misc/tos.html"));
                        },
                        contentPadding: EdgeInsets.zero,
                        title:
                            Text("Terms & Condition", style: Theme.of(context).textTheme.bodyLarge),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )),
                    ListTile(
                        onTap: () {
                          _launchUrl(Uri.parse(
                              "${settingsController.userProfile["domain"].toString()}/misc/cancellation.html"));
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text("Cancellation Policy",
                            style: Theme.of(context).textTheme.bodyLarge),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
