// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/screens/forgot1.dart';
import 'package:firebase_sample/screens/page1.dart';
import 'package:firebase_sample/screens/signin.dart';
import 'package:flutter/material.dart';
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
        body: Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create Account',
            style: TextStyle(
                color: Color.fromARGB(255, 21, 95, 155),
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: email2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '      EMAIL',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: password2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '      PASSWORD',
                    hintStyle: TextStyle(color: Colors.black)),
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
                      builder: (context) => Password1(),
                    ));
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 15),
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
                      builder: (context) => Signin(),
                    ));
              },
              child: Text(
                'Forgot Password 2?',
                style: TextStyle(fontSize: 15),
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
                      await _savedatatosharedpreferences(userData['data']);
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
                backgroundColor: MaterialStatePropertyAll(Colors.blue[100]),
              ),
              child: Text(
                'LOGIN',
                style: TextStyle(color: Colors.black, fontSize: 17),
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
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signin(),
                        ));
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
