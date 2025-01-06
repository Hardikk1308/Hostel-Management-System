import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:super_admin_app/pages/Dashboard_superadmin.dart';
import 'package:super_admin_app/utils/Profilepage.dart';


import 'Notification.dart';
import 'Side_navbar.dart';

class Homeepage extends StatefulWidget {

  final jwt_token;
  const Homeepage({Key? key, this.jwt_token}) : super(key: key);
 
  @override
  State<Homeepage> createState() => _HomeepageState();
}

class _HomeepageState extends State<Homeepage> {
late String erpid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Map<String,dynamic> JwtDecoderToken = JwtDecoder.decode(widget.jwt_token);
     erpid = JwtDecoderToken['erpid'];
  }
  int currentindex = 0;
  final List<String> titles = [
    'Dashboard',
    'Profile',
  ];

  final screen = [
    const Dashboards(jwt_token: null,),
    const Profilepage(
      text: 'Super Admin',
      // text2: 'Couse',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 245, 245),
        drawer: const Navbar(),
        appBar: AppBar(
          toolbarHeight: 60,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: Text(titles[currentindex]),
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
        body:Center(child: Column(
          children: [
            Text(erpid),
          ],
        )
        ,)
        //  screen[currentindex],
       /* bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedItemColor: const Color(0xff407BFF),
          selectedLabelStyle: const TextStyle(
              color: Color(0xff407BFF),
              fontSize: 15,
              fontWeight: FontWeight.w600),
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color(0xff407BFF),
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color(0xff407BFF),
                size: 30,
              ),
              label: 'Profile',
            ),
          ],
        ),*/
      ),
    );
  }
}
