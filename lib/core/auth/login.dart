import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygame/core/auth/login_controller.dart';
import 'package:mygame/core/auth/signup.dart';
import 'package:mygame/core/auth/verify_pin.dart';
import 'package:mygame/core/user_type.dart';
import 'package:mygame/homescreen.dart';
import 'package:mygame/utils/flow_decider.dart';
import 'package:mygame/utils/snackbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
          padding: const EdgeInsets.all(25),
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
                      height: 50,
                      width: 100,
                      child: Image.asset("assets/images/mygame.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Image.asset(
                    "assets/images/ball1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Log In',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: 28),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              errorStyle: TextStyle(color: Colors.white),
                              isDense: true,
                              enabled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              focusColor: Colors.white,
                              labelText: "Phone number",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
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
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  loginController.loginId = controller.text;
                                  loginController.phoneNo = controller.text;
                                  loginController
                                      .otpGenerate("+91${controller.text}")
                                      .then((value) {
                                    if (value) {
                                      Get.to(() => const VerifyPin(
                                            type: "Login",
                                          ));
                                    } else {
                                      showSnackBar(
                                          context, "Something Went Wrong");
                                    }
                                  });
                                }
                              },
                              child: const Text(
                                "Log In",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text("Or login with"),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  loginController
                                      .signInWithGoogle()
                                      .then((value) {
                                    loginController.loginId = value.user!.email;
                                    loginController.email = value.user!.email;
                                    loginController.userName =
                                        value.user?.displayName ?? "";
                                    loginController.userRole = "user";
                                    loginController.signIn().then((value) {
                                      if (value) {
                                        flowDecider(UserType.player);
                                      }
                                    });
                                  });
                                },
                                child: Image.asset(
                                  "assets/images/google.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  loginController
                                      .signInWithFacebook()
                                      .then((value) {
                                    loginController.loginId = value.user!.email;
                                    loginController.email = value.user!.email;
                                    loginController.userName =
                                        value.user?.displayName ?? "";
                                    loginController.userRole = "user";
                                    loginController.signIn().then((value) {
                                      if (value) {
                                        flowDecider(UserType.player);
                                      }
                                    });
                                  });
                                },
                                child: Image.asset(
                                  "assets/images/facebook.png",
                                  height: 45,
                                  width: 45,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("New to myGame? "),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => const SignUp());
                                  },
                                  child: const Text(
                                    " Register",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
