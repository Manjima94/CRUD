import 'package:flutter/material.dart';

class Password1 extends StatefulWidget {
  const Password1({super.key});

  @override
  State<Password1> createState() => _Password1State();
}

class _Password1State extends State<Password1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Center(
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
                      ), Padding(
                padding: const EdgeInsets.only( top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
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
                        hintText: 'PASSWORD',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ), Padding(
                padding: const EdgeInsets.only( top: 30),
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
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
              onPressed: ()  {
               
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => page1(),
                //     ));
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
    ),);
  }
}


