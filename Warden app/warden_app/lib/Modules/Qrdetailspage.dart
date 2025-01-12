import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QRResultPage extends StatelessWidget {
  final String erpid;
  final VoidCallback onScanAgain;

  QRResultPage({required this.erpid, required this.onScanAgain});

  Future<void> markAttendance(String status, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://hm-system-l1p1.onrender.com/api/attendance/mark-present'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'erpid': erpid, // Assuming `result` contains the student details
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Attendance marked as $status successfully!')),
          );
          Navigator.of(context).pop(); // Pop to scan again
          onScanAgain(); // Reset scanner
        } else {
          throw Exception(responseData['message'] ?? 'Failed to mark attendance');
        }
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Mark Attendance'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Student Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                erpid,
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => markAttendance('Present', context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Present",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => markAttendance('Absent', context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Absent",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
