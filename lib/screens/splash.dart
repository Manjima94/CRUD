// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_sample/screens/onboard.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboard()),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                      'TaskMe',
                      style: TextStyle(letterSpacing: 5,
                color: Colors.cyan[800],
                fontSize: 50,
                fontFamily: 'Rosarivo',
                fontWeight: FontWeight.w900),
                    ),AnimatedIcon(icon: AnimatedIcons.event_add, progress:kAlwaysCompleteAnimation ),
                    Icon(Icons.check_box,color: Colors.cyan[800],size: 60,)
            ],
          )),
    );
  }
}
