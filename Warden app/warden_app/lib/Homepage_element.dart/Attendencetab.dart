import 'package:flutter/material.dart';
import 'package:warden_app/utils/Sidenav.dart';

import '../pages/QR_scanner.dart';
import '../utils/Notification.dart';

class Attendence extends StatefulWidget {
  final String user;

  const Attendence({super.key, required this.user});

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
    String studentName = 'Loading...';
  String course = 'Loading...';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        drawer: Navbar(studentName: studentName, course: course, user: widget.user,),
        appBar: AppBar(
          toolbarHeight: 60,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: Text('Attendance'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          actions: [
            IconButton(
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
              icon: const Icon(Icons.notification_add),
            ),
          ],
          backgroundColor: const Color(0xff407BFF),
        ),

      body: QRViewExample(),
    );
  }
}