// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/screens/login.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formkey = GlobalKey<FormState>();

  var name = TextEditingController();
  var name2 = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();

  Future<void> sample() async {
    final regreference =
        await FirebaseFirestore.instance.collection('Register').add({
      'First Name': name.text,
      'Last Name': name2.text,
      'Email': email.text,
      'Password': password.text,
      'Mobile': mobile.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          backgroundColor: Colors.brown[200],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 120.0, right: 50),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 78, 52, 42),
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: ' FIRST NAME',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: name2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: ' LASTNAME',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: email,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: '  EMAIL',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: password,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: '  PASSWORD',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 30),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: mobile,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: '  MOBILE',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      sample();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
