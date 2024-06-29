import 'package:firebase_sample/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/Checklist.png'),
              height: ScreenUtil().setHeight(300),
              width: ScreenUtil().setWidth(300),
            ),
            Padding(
              padding: const EdgeInsets.only(top:60.0,bottom: 10),
              child: Text(
                'Get Things done with TaskMe',
                style: TextStyle(
                  color: Colors.cyan[800],
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              "Don't miss on anything in your daily life tasks list.",
              style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:220.0),
              child: ElevatedButton(onPressed: (){  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ));}, style: ButtonStyle(
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                          fixedSize: MaterialStatePropertyAll(Size(
                            ScreenUtil().setWidth(300),
                            ScreenUtil().setHeight(40),
                          )),
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.cyan[800],
                          ),
                        ),
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
            ), 
          ],
        ),
      ),
    );
  }
}
