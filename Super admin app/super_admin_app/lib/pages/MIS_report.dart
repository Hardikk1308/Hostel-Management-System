import 'package:flutter/material.dart';

import '../utils/Notification.dart';

class Mis_report extends StatefulWidget {
  // final String text;
  // final String text2;
  const Mis_report({
    super.key,
  });

  @override
  State<Mis_report> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Mis_report> {
  static const style1 = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('MIS Report'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Notify();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.notification_add))),
          )
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Text(
                  '',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Date',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    const Text(
                      'Total Student ',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    const Text(
                      'Total Student Present',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    const Text(
                      'Total Student Absent',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    const Text(
                      'Total Student not present(Red Cases)',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    const Text(
                      'Student on leave',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    const Text(
                      'Student not attending classes',
                      style: style1,
                    ),
                    const Divider(
                      thickness: 1.5,
                      indent: 0,
                      height: 50,
                      color: Colors.black45,
                    ),
                    Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // minimumSize: const Size(150, 40),
                        backgroundColor: const Color(0xff407BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: 
                        
                          // Text(
                          //   'Download',
                          //   style: TextStyle(fontSize: 18, color: Colors.white),
                          // ),
                          // // SizedBox(width: 10,),
                          const Icon(Icons.download,color: Colors.white,)
                        
                    
                    ))
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
