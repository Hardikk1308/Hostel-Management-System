import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:super_admin_app/utils/Homepage.dart';

class LoginPage extends StatefulWidget {
  final bool? obscureText;
  const LoginPage({super.key, this.obscureText = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  final TextEditingController erpidController = TextEditingController(); // Changed
  final TextEditingController passwordController = TextEditingController();
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginUser() async {
    if (erpidController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "erpid": erpidController.text, // Changed
        "password": passwordController.text
      };

      try {
        var response = await http.post(
          Uri.parse('http://192.168.202.126:7000/api/auth/login'), // Replace with your actual endpoint URL
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['success']) { // Changed from 'status' to 'success'
            // Save the JWT token using SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String token = jsonResponse['data']['token']; // Adjusted to match JSON structure
            await prefs.setString('jwt_token', token);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Homeepage(jwt_token: token,))); // Corrected the class name

            // Decode the JWT token
            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
            print('Decoded Token: $decodedToken');

            // Add your logic for successful login
            print('Login successful');
          } else {
            print('Something went wrong');
          }
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('ERPID and password cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Login.png'),
                const Text(
                  'HELLO THERE!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'ERPID is required'; // Changed
                    }
                    return null;
                  },
                  controller: erpidController, // Changed
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: -4, horizontal: 10),
                    focusedBorder: border,
                    enabledBorder: border,
                    focusedErrorBorder: border,
                    errorBorder: border,
                    labelText: "ERPID", // Changed
                    labelStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 15,
                    ),
                  ),
                  keyboardType: TextInputType.number, // Changed to number
                  cursorColor: Colors.black38,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: obscureText,
                  maxLines: 1,
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
                    errorBorder: border,
                    focusedErrorBorder: border,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: -4, horizontal: 10),
                    focusedBorder: border,
                    enabledBorder: border,
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 15,
                    ),
                  ),
                  cursorColor: Colors.black38,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(230, 45),
                    backgroundColor: const Color(0xff407BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginUser();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
