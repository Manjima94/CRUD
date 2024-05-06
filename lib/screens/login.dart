import 'package:firebase_sample/screens/page1.dart';
import 'package:firebase_sample/screens/signin.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 222, 179, 220),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 238, 181, 235),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 120.0, right: 50),
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
                      color: Color.fromARGB(255, 149, 76, 154),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    controller: email ,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '      EMAIL',
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
                      color: Color.fromARGB(255, 153, 81, 145),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    controller: password,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '      PASSWORD',
                        hintStyle: TextStyle(color: Colors.white)),
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
                        'Signin',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => page1(),
                        ));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 143, 74, 156))),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
