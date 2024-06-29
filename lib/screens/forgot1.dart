import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/screens/page1.dart';
import 'package:flutter/material.dart';

class Password1 extends StatefulWidget {
  const Password1({super.key});

  @override
  State<Password1> createState() => _Password1State();
}

class _Password1State extends State<Password1> {
  Future<bool> checkEmailExists(String email) async {
    try {
      var querysnapshot = await FirebaseFirestore.instance
          .collection('Register')
          .where('Email', isEqualTo: emailf)
          .get();
      return querysnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error : $e');
      return false;
    }
  }

  final formkey = GlobalKey<FormState>();
  var emailf = TextEditingController();
  var pass = TextEditingController();
  var passc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: emailf,
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
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: '  EMAIL',
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: pass,
                    validator: (value) {
                      if (value!.isEmpty ?? true) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'PASSWORD',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: passc,
                    validator: (value) {
                      if (value!.isEmpty ?? true) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '  CONFIRM PASSWORD',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState?.validate() ?? true) {
                      bool emailExists = await checkEmailExists(emailf.text);
                      if (emailExists) {
                        print('exists');
                      } else {
                        print('Does not exist');
                      }
                    }
                    if (pass.text == passc.text) {
                      print('Equal');
                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection('Register')
                          .where('Email', isEqualTo: emailf.text)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        DocumentReference userDocRef =
                            querySnapshot.docs.first.reference;
                        await userDocRef.update({
                          'Password': passc.text,
                        });
                        print('Passwor updated');

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => page1(),
                            ));
                      } else {
                        print('Password donot match');
                      }
                    }
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
            ],
          ),
        ),
      ),
    );
  }
}
