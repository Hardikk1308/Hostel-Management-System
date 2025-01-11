import 'package:flutter/material.dart';


class Profilepage extends StatefulWidget {
  final String user;
  // final String text2;
  const Profilepage({super.key, required this.user, });

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  static const style1 = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.black12,
                ),
                Text(
                 ' widget.text,',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        'Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 280),
                      child: Text(
                        'Email',
                        style: style1,
                      ),
                    ),
                    // Divider(
                    //   thickness: 1.5,
                    //   indent: 0,
                    //   height: 50,
                    //   color: Colors.black45,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 270,),
                    //   child: Text(
                    //     'Course:',
                    //     style: style1,
                    //   ),
                    // ),
                    // Divider(
                    //   thickness: 1.5,
                    //   indent: 0,
                    //   height: 50,
                    //   color: Colors.black45,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 225),
                    //   child: Text(
                    //     'Room number:',
                    //     style: style1,
                    //   ),
                    // ),
                    Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 270),
                      child: Text(
                        'Gender:',
                        style: style1,
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 270),
                      child: Text(
                        'Contact:',
                        style: style1,
                      ),
                    ),
                    // Divider(
                    //   thickness: 1.5,
                    //   indent: 0,
                    //   height: 50,
                    //   color: Colors.black45,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 240),
                    //   child: Text(
                    //     'Hosel name:',
                    //     style: style1,
                    //   ),
                    // ),
                    Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
