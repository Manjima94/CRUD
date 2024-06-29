// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/screens/login.dart';
import 'package:firebase_sample/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
          'Name': name.text,
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
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 206, 229, 231),
            automaticallyImplyLeading: false),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Welcome Onboard',
                  style: TextStyle(
                    color: Colors.cyan[800],
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Lets help you to meet your tasks...',
                  style: TextStyle(
                    color: Colors.cyan[800],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Image(
                  image: AssetImage('images/signup.png'),
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(200),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 30),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setHeight(250),
                    child: TextFormField(
                      controller: name,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.cyan[800],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: ' NAME',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 30),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setHeight(250),
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
                          fillColor: Colors.cyan[800],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: '  MOBILE',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 30),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setHeight(250),
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
                          fillColor: Colors.cyan[800],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: '  EMAIL',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 30),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setHeight(250),
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
                          fillColor: Colors.cyan[800],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: '  PASSWORD',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      sample();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Colors.cyan[800],
                    )),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.cyan[800],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.cyan[800],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
