import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:super_admin_app/pages/Login_page.dart';
import 'package:super_admin_app/utils/Notification.dart';

import '../pages/Dashboard_superadmin.dart';



class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xff407BFF)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Super Admin Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Designation',
                        style: TextStyle(
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
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Image(image: AssetImage('assets/images/rungta.png')),
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
                return const Dashboards(jwt_token: null,);
              }));
            },
            child: ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black38,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Send Notification',
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
              title:  Row(
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
                    'Change Passsword',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
             
            ),
          ),
          SizedBox(
            height: 210,
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Row(
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
