// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formkey = GlobalKey<FormState>();

  var name = TextEditingController();
  // var password2 = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();

  Future<void> sample() async {
    if (formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        String uid = userCredential.user!.uid;
        final regreference =
            await FirebaseFirestore.instance.collection('Register').add({
          ' Name': name.text,
          'Mobile': mobile.text,
          'Email': email.text,
          'Password': password.text,
          // 'Confirm password': password2
        });
        print('Registered Successfully!!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } catch (e) {
        print('Unexpected error during registration: $e');
        Fluttertoast.showToast(
          msg: "Unexpected error during registration.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 120.0, right: 50),
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Color.fromARGB(255, 21, 95, 155),
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: name,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: ' NAME',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: mobile,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Mobile Number';
                      }
                      if (value.length != 10) {
                        return 'Mobile Number must be 10 digits';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Invalid Mobile Number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '  MOBILE',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    controller: email,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '  EMAIL',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password';
                      }
                      if (value != password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '  PASSWORD',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 60, top: 30),
              //   child: Container(
              //     height: 60,
              //     width: 300,
              //     decoration: BoxDecoration(
              //         color: Colors.blue[100],
              //         borderRadius: BorderRadius.circular(5),
              //         ),
              //     child: TextFormField(
              //       controller: password2,
              //       validator: (value) {
              //         if (value != password) {
              //           return ' Password do not match';
              //         }

              //         return null;
              //       },
              //       style: TextStyle(
              //         color: Colors.black,
              //       ),
              //       decoration: InputDecoration(
              //           border: OutlineInputBorder(borderSide: BorderSide.none),
              //           hintText: ' CONFIRM PASSWORD',
              //           hintStyle: TextStyle(color: Colors.black)),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 50),
                child: ElevatedButton(
                  onPressed: () {
                    sample();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Login(),
                    //     ));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Colors.blue[100],
                  )),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
