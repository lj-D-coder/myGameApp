import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mygame/core/auth/login.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _newPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
          padding: const EdgeInsets.only(left:20,right:20,top: 20),
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
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    "assets/images/ball3.png",
                    fit: BoxFit.cover,
                    // height: 250,
                    // width: 250,
                  ),
                ),
                const SizedBox(height: 20,),
                Form(
                    key: _newPassword,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                      child: Column(
                        children: [
                          Text(
                            'Create New Password',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: 28),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'New Password is required';
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
                              labelText: "New Password",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              suffixIcon: Icon(Icons.lock,color: Colors.white,)
                            ),
                            
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password is required';
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
                              labelText: "Confirm Password",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                              ),
                              suffixIcon: Icon(Icons.lock,color: Colors.white,)
                            ),
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
                                // if (_newPassword.currentState!.validate()) {
                                //   _newPassword.currentState!.save();
                                // }
                                Get.offAll(() => Login());
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
