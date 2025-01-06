import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/Notification.dart';

class Attendece extends StatefulWidget {
  const Attendece({Key? key}) : super(key: key);

  @override
  State<Attendece> createState() => _AttendeceState();
}

class _AttendeceState extends State<Attendece> {
  static const decoration =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor:Color.fromARGB(255, 247, 245, 245),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white, size: 25),
            title: const Text('Attendence'),
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            backgroundColor: const Color(0xff407BFF),

            //NOTIFICATION
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
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
                  icon: Icon(Icons.notification_add),
                ),
              ),
            ],
            bottom: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('Today', style: decoration),
                  ),
                  Tab(
                    child: Text('Overall', style: decoration),
                  ),
                ]),
          ),
        ));
  }
}
