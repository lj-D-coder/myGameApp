import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:mygame/core/auth/signup_controller.dart';
import 'package:mygame/core/auth/verify_pin.dart';

import '../../utils/snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.put(SignUpController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/grass.jpeg",
                  ),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                      height: 60,
                      width: 100,
                      child: Image.asset("assets/images/mygame.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: Image.asset(
                    "assets/images/ball2.png",
                    fit: BoxFit.cover,
                    // height: 250,
                    // width: 250,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _signUpKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: 28),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameController,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                isDense: true,
                                enabled: true,
                                errorStyle: TextStyle(color: Colors.white),
                                errorBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                focusColor: Colors.white,
                                labelText: "Name",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: phoneController,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            // obscureText: true,
                            // obscuringCharacter: "*",
                            decoration: const InputDecoration(
                                errorBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                isDense: true,
                                enabled: true,
                                errorStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                focusColor: Colors.white,
                                labelText: "Phone Number",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                suffixIcon: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                )),
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(250, 50))),
                              onPressed: () {
                                if (_signUpKey.currentState!.validate()) {
                                  _signUpKey.currentState!.save();
                                  if (_signUpController.verifyInput(
                                      nameController.text,
                                      phoneController.text)) {
                                    _signUpController
                                        .otpGenerate(
                                            "+91${phoneController.text}")
                                        .then((value) {
                                      if (value) {
                                        _signUpController.loginId =
                                            phoneController.text;
                                        _signUpController.phoneNo =
                                            phoneController.text;
                                        _signUpController.userName =
                                            nameController.text;

                                        _signUpController.userRole = "user";
                                        Get.to(() => const VerifyPin(
                                              type: "SignUp",
                                            ));
                                      } else {
                                        showSnackBar(
                                            context, "Something went wrong");
                                      }
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Already Register? "),
                              const Text(" | "),
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Text("Login")),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "*An OTP will be sent through phone call or SMS",
                            style: TextStyle(fontSize: 9),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
