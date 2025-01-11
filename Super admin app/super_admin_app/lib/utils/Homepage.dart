import 'package:flutter/material.dart';
import 'package:super_admin_app/pages/Dashboard_superadmin.dart';
import 'package:super_admin_app/utils/Profilepage.dart';
import 'Notification.dart';
import 'Side_navbar.dart';
// ignore: library_prefixes
import 'package:dio/dio.dart' as dioCall;

class HomePage extends StatefulWidget {
  final String user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {                                                                                                                                                                                     
  String studentName = 'Loading...';
  String course = 'Loading...';

  int currentIndex = 0;
  final List<String> titles = ['Dashboard', 'Profile'];

  Future<void> fetchUserData(String userId) async {
    try {
      final dio = dioCall.Dio();

      final res = await dio.get(
        'https://hm-system-l1p1.onrender.com/api/register/get-student/$userId',
        queryParameters: {"userId": userId},
      );

      final response = res.data;

      if (res.statusCode == 200) {
        setState(() {
          studentName = response['student']['name'];
          course = response['student']['course'];
        });
      } else {
        throw Exception(
            'Failed to load user data, status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(widget.user);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Dashboards(
        Adminname: studentName,
        course: course,
        user: widget.user,
      ), // Pass the data here
      Profilepage(user: widget.user),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        drawer: Navbar(
          Adminname: studentName,
          course: course,
          user: widget.user,
        ),
        appBar: AppBar(
          toolbarHeight: 60,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          title: Text(titles[currentIndex]),
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
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          selectedItemColor: const Color(0xff407BFF),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
