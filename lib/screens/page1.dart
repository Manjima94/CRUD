// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var name = TextEditingController();
  var content = TextEditingController();
  
  TextEditingController taskcontroller = TextEditingController();
  late String taskIdForupdate;
  // Future<void> edit() async {
  //   final todoreference = await FirebaseFirestore.instance
  //       .collection('Todo')
  //       .add({'Name': name.text, 'Activity': content.text});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      StreamBuilder(
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
              return Card(
                color: Colors.blue[100],
                child: ListTile(
                  title: Text(todo['task']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
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
                                      if (taskcontroller.text.isNotEmpty) {
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
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('todos')
                              .doc(todo.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[200],
          shape: CircleBorder(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add Task'),
                  content: TextField(
                    controller: taskcontroller,
                    decoration: InputDecoration(hintText: 'Enter your task'),
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
                          FirebaseFirestore.instance.collection('todos').add({
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
          child: Icon(Icons.add,size: 30),
        ),
      )
    ]));
  }
}
