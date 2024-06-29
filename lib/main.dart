import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample/firebase_options.dart';
import 'package:firebase_sample/screens/login.dart';
import 'package:firebase_sample/screens/onboard.dart';
import 'package:firebase_sample/screens/splash.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      splitScreenMode: true,
      minTextAdapt: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 206, 229, 231),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: splash(),
    );
  }
}
