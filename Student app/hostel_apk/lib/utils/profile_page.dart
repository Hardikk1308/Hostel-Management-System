import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  final String user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String studentName = 'Loading...';
  String course = 'Loading...';
  String erpId = 'Loading...';
  String gender = 'Loading...';
  String email = 'Loading...';
  String phone = 'Loading...';
  String hostel = 'Loading...';
  String room = 'Loading...';
  String Qrcode = 'Loading...';

  Uint8List imageBytes = Uint8List(0);

  final Dio dio = Dio();

  Future<void> fetchUserData(String userId) async {
  try {
    final response = await dio.get(
      'https://hm-system-l1p1.onrender.com/api/register/get-student/$userId',
      queryParameters: {'userId': userId},
    );

    if (response.statusCode == 200) {
      final data = response.data;
      print('API Response: $data');

      setState(() {
        studentName = data['student']?['name'] ?? 'N/A';
        course = data['student']?['course'] ?? 'N/A';
        erpId = data['student']?['erpid']?.toString() ?? 'N/A';
        gender = data['student']?['gender'] ?? 'N/A';
        email = data['student']?['email'] ?? 'N/A';
        phone = data['student']?['phone']?.toString() ?? 'N/A';
        hostel = data['student']?['hostel']?['hostelname'] ?? 'N/A';
        room = data['student']?['room']?['roomNumber'] ?? 'N/A';

        // Handle QR Code
        if (data['student']?['qrCode'] != null &&
            data['student']?['qrCode'].isNotEmpty) {
          try {
            imageBytes = base64.decode(data['student']?['qrCode']);
          } catch (e) {
            print('Error decoding QR code: $e');
            imageBytes = Uint8List(0);
          }
        } else {
          print('QR code data is empty or null');
          imageBytes = Uint8List(0);
        }
      });

      // Store data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('studentName', studentName);
      await prefs.setString('erpId', erpId);
      await prefs.setString('roomNumber', room);
      await prefs.setString('hostelName', hostel);
    } else {
      print('Error: Status Code ${response.statusCode}');
      throw Exception('Error: ${response.statusCode}');
    }
  } on DioError catch (e) {
    print('DioError: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('DioError: ${e.message}')),
    );
  } catch (e) {
    print('Unexpected Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unexpected Error: $e')),
    );
  }
}
  @override
  void initState() {
    super.initState();
    fetchUserData(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Image.memory(imageBytes),
                const SizedBox(height: 10),
                Text(
                  studentName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ProfileDetailRow(label: 'ERP ID:', value: erpId),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Course:', value: course),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Room Number:', value: room),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Gender:', value: gender),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Contact:', value: phone),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Hostel Name:', value: hostel),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Email:', value: email),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
