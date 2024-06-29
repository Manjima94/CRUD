// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/screens/forgot1.dart';
import 'package:firebase_sample/screens/page1.dart';
import 'package:firebase_sample/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email2 = TextEditingController();
  var password2 = TextEditingController();

  final formkey = GlobalKey<FormState>();

  Future<void> _savedatatosharedpreferences(String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('Details', data);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back !',
                  style: TextStyle(
                      color: Colors.cyan[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                Image(
                  image: AssetImage('images/login.png'),
                  height: ScreenUtil().setHeight(200),
                  width: ScreenUtil().setWidth(200),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(270),
                    child: TextFormField(
                      controller: email2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.cyan[800],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: '      EMAIL',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(270),
                    child: TextFormField(
                      controller: password2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.cyan[800],
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: '      PASSWORD',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ));
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        String email = email2.text.trim();
                        String password = password2.text.trim();
                        var querysnapshot = await FirebaseFirestore.instance
                            .collection('Register')
                            .where('Email', isEqualTo: email)
                            .limit(1)
                            .get();

                        if (querysnapshot.docs.isNotEmpty) {
                          var userData = querysnapshot.docs.first.data();
                          if (userData['Password'] == password) {
                            await _savedatatosharedpreferences(
                                userData['data']);
                          }
                        }
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => page1(),
                          ));
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      fixedSize: MaterialStatePropertyAll(Size(
                        ScreenUtil().setWidth(200),
                        ScreenUtil().setHeight(40),
                      )),
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.cyan[800],
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont you have a account?',
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
                                builder: (context) => Signup(),
                              ));
                        },
                        child: Text(
                          'Signup',
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
