import 'package:flutter/material.dart';
import 'package:warden_app/Modules/Issuenotification.dart';
import '../pages/Isueesdetails.dart';

class Complain extends StatefulWidget {
  const Complain({super.key});

  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  final List<issue> issues = [
    issue(
      issues: "Electrical issue",
      roomName: "Room 101",
      roomNumber: '101',
    ),
    issue(
      issues: "Water issue",
      roomName: "Room 106",
      roomNumber: '106',
    ),
    issue(
      issues: "Technical issue",
      roomName: "Room 103",
      roomNumber: '103',
    ),
    issue(
      issues: "Electrical issue",
      roomName: "Room 109",
      roomNumber: '109',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Issues'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: ListView.builder(
        itemCount: issues.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Material(
              elevation: 5,
              color: Colors.black,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                ),
                height: 80,
                child: ListTile(
                  title: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 15),
                        child: CircleAvatar(
                          radius: 30,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6,),
                          Text(
                            '${issues[index].issues}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Room ${issues[index].roomNumber}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailIssue(selectedIssue: issues[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
