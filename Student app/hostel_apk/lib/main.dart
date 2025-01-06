import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hostel_apk/pages/login_page.dart';
import 'package:hostel_apk/utils/HomePage_std.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  String? _user;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('_id');

    if (userId != null) {
      // User is logged in, store userId and skip to HomePage
      setState(() {
        _isLoggedIn = true;
        _user = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // If the user is logged in, navigate to HomePage; otherwise, show LoginPage
      home: _isLoggedIn
          ? HomePage(user: _user!)  // Pass the userId to HomePage
          : const LoginPage(),
    );
  }
}
