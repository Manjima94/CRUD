// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
 
  Profile(
      {super.key,
   });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  File? image;
  
  final picker = ImagePicker();

  Future<void> _uploadimage() async {
    if (formKey.currentState!.validate() && image != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_image')
            .child(DateTime.now().millisecondsSinceEpoch.toString());
        await ref.putFile(image!);

        final imageURL = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('Register').add({
          'imageURL': imageURL,
        });
        setState(() {
          image = null;
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pick != null ? File(pick.path) : null;
      });
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:  Color.fromARGB(255, 206, 229, 231),),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundColor: Colors.cyan[800],
                radius: 50,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: 50,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    fontFamily: 'InriaSerif',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              'Mobile',
                              style: TextStyle(
                                  fontFamily: 'InriaSerif',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: 'InriaSerif',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ]),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            ':',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            ':',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            ':',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text('',

                            style: TextStyle(
                                fontFamily: 'InriaSerif',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontFamily: 'InriaSerif',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontFamily: 'InriaSerif',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ElevatedButton( style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Colors.cyan[800],
                    )),
                  onPressed: () {
                    _uploadimage();
                  },
                  child: Text('Submit', style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),)),
            )
          ],
        ),
      ),
    );
  }
}
