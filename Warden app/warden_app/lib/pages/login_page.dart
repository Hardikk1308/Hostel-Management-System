import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/Homepage_warden.dart';

class LoginPage extends StatefulWidget {
  final bool? obscureText;

  const LoginPage({Key? key, this.obscureText = false}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );

  bool _isLoading = false;

  Future<void> _login() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await http.post(
      Uri.parse('https://hm-system-l1p1.onrender.com/api/auth/login'), // Replace with your backend login API URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'erpid': numberController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        final user = data['user'];

        // Check if the user is an admin
        if (user['isAdmin'] != true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Access denied: Only admins can log in.')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final userId = user['_id'];

        // Store the user ID in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('_id', userId);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        // Navigate to HomePage and pass the userId
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(user: userId), // Pass the userId
        ));
      } else {
        // Show error message if 'success' is false
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${data['message']}')),
        );
      }
    } else {
      // If the response code is not 200, show a failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.body}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('_id');
    if (userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: userId)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth > 800
        ? 100.0
        : screenWidth > 600
            ? 50.0
            : 30.0;
    final double imageSize = screenWidth > 800
        ? screenWidth * 0.5
        : screenWidth > 600
            ? screenWidth * 0.7
            : screenWidth * 0.9;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Login.png',
                    width: imageSize,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'HELLO THERE!',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black38,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: -4, horizontal: 10),
                      focusedBorder: border,
                      enabledBorder: border,
                      focusedErrorBorder: border,
                      errorBorder: border,
                      labelText: "ERP ID",
                      labelStyle: const TextStyle(
                        color: Colors.black38,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ERP ID is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscureText,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black38,
                    decoration: InputDecoration(
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: obscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: -4, horizontal: 10),
                      focusedBorder: border,
                      enabledBorder: border,
                      focusedErrorBorder: border,
                      errorBorder: border,
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.black38,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(230, 45),
                      backgroundColor: const Color(0xff407BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}