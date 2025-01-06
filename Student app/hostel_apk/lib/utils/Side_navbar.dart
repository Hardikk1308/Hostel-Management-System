import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/dashboard.dart';
import '../pages/login_page.dart';
import 'Notification.dart';

class Navbar extends StatefulWidget {
  final String studentName;
  final String course;
  final String user;
  const Navbar(
      {super.key,
      required this.studentName,
      required this.course,
      required this.user});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff407BFF)),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.studentName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.course,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              )),
          const DrawerHeader(
            curve: Curves.bounceInOut,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Rungta educational foundation\nkohka bhilai-490025'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Dashboards(
                  course: widget.course,
                  studentName: widget.studentName,
                  user: widget.user,
                );
              }));
            },
            child: ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: Colors.black38,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Notify();
                }));
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.key,
                    color: Colors.black38,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Change Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 210,
          ),
          GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('_id'); // Make sure to use '_id' as the key

              // Navigate back to LoginPage and clear the current stack of pages
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            child: const ListTile(
              title: Row(
                children: [
                  Text(
                    'Log out',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.black45,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
