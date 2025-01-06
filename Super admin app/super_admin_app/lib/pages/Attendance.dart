import 'package:flutter/material.dart';
import '../utils/Notification.dart';

class Attandance extends StatefulWidget {
  const Attandance({super.key});

  @override
  State<Attandance> createState() => _AttandanceState();
}

class _AttandanceState extends State<Attandance> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 247, 245, 245),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: Text('Attandance (Red cases)'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Padding(
                padding: EdgeInsets.only(right: 5),
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
                    icon: Icon(Icons.notification_add))),
          )
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
    );
  }
}