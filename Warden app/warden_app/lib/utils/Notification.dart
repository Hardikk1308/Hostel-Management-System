import 'package:flutter/material.dart';


class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFEDFF),
       appBar: AppBar(
          toolbarHeight: 60,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: const Text('Notification'),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.only(right: 15),
              ),
            )
          ],
          actionsIconTheme: const IconThemeData(color: Colors.white, size: 30),
          backgroundColor: const Color(0xff407BFF),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications,
                size: 100,
                color: Colors.black38,),
                Text('Notification',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black38
                ),)
              ],
            ),
          ),
        ),


    );
  }
}