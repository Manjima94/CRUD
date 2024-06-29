// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/screens/login.dart';
import 'package:firebase_sample/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  File? image;
  XFile? pick;
  var taskdone = true;
  var t;

  TimeOfDay? selectedtime;

  void picktime() async {
    var t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      selectedtime = t;
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var name = TextEditingController();
  var content = TextEditingController();
  TextEditingController taskcontroller = TextEditingController();
  late String taskIdForupdate;
  // Future<void> edit() async {
  //   final todoreference = await FirebaseFirestore.instance
  //       .collection('Todo')
  //       .add({'Name': name.text, 'Activity': content.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 206, 229, 231),
            toolbarHeight: 80,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                  icon: Icon(Icons.person_pin, size: 35)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Are You Sure?',
                            style: TextStyle(color: Colors.cyan[800]),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.cyan[800])),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ));
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.cyan[800])),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 27,
                  ))
            ]),
        body: Stack(children: [
          Text(
            '    Daily Tasks ',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.cyan[800],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
            child: Container(
              height: ScreenUtil().setHeight(500),
              width: ScreenUtil().setWidth(400),
              decoration: BoxDecoration(
                  color: Colors.cyan[800],
                  borderRadius: BorderRadius.circular(30)),
              child: StreamBuilder(
                stream: _firestore.collection('todos').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // final user = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var todo = snapshot.data!.docs[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      taskdone = !taskdone;
                                    });
                                  },
                                  icon: taskdone
                                      ? Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.check_box,
                                          color: Colors.white,
                                        )),
                             
                              Text(todo['task'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [ IconButton(
                                  onPressed: () async {
                                    t = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    picktime();
                                    if (t != null) {
                                      print(t);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.alarm_on,
                                    color: Colors.white,
                                  )),
                              Text(selectedtime != null
                                  ? selectedtime!.format(context)
                                  : '',style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                taskIdForupdate = todo.id;
                                taskcontroller.text = todo['task'];
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Edit Task'),
                                      content: TextField(
                                        controller: taskcontroller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your task',
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (taskcontroller
                                                .text.isNotEmpty) {
                                              FirebaseFirestore.instance
                                                  .collection('todos')
                                                  .doc(taskIdForupdate)
                                                  .update({
                                                'task': taskcontroller.text,
                                              });
                                              name.clear();
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text('Update'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('todos')
                                    .doc(todo.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.cyan[800],
              shape: CircleBorder(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add Task'),
                      content: TextField(
                        controller: taskcontroller,
                        decoration:
                            InputDecoration(hintText: 'Enter your task'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (taskcontroller.text.isNotEmpty) {
                              FirebaseFirestore.instance
                                  .collection('todos')
                                  .add({
                                'task': taskcontroller.text,
                              });
                              name.clear();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add, color: Colors.white, size: 40),
            ),
          )
        ]));
  }
}
