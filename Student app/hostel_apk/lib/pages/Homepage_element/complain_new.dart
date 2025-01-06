import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/Notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> issueTypes = [
  'Plumbing',
  'Electrical',
  'Housekeeping',
  'Internet',
  'Water',
  'Other',
];

class RegisterComplaint extends StatefulWidget {
  @override
  _RegisterComplaintState createState() => _RegisterComplaintState();
}

class _RegisterComplaintState extends State<RegisterComplaint> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedIssueType;
  bool _isLoading = false;
  String _message = '';
  String? _userId;

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('_id');
    if (id != null) {
      setState(() {
        _userId = id;
      });
      print("Loaded User ID: $_userId");
    } else {
      print("No User ID found in SharedPreferences.");
    }
  }

  Future<void> _registerComplaint() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_userId == null) {
      setState(() {
        _message = 'User ID not found. Please log in again.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://hm-system-l1p1.onrender.com/api/complaint/registercomplaint',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': _userId,
          'type': _selectedIssueType,
          'description': _descriptionController.text,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success']) {
        setState(() {
          _message = 'Complaint registered successfully.';
        });

        // Reset the form
        _formKey.currentState?.reset();
        _descriptionController.clear();
        setState(() {
          _selectedIssueType = null;
        });

        print("Complaint registered: ${data['newComplaint']}");
      } else {
        setState(() {
          _message = data['msg'] ?? 'Failed to register complaint.';
        });
      }
    } catch (error) {
      setState(() {
        _message = 'An error occurred. Please check your connection and try again.';
      });
      print('Error registering complaint: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Register Complaint'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Notify();
              }));
            },
            icon: const Icon(Icons.notification_add),
          )
        ],
        backgroundColor: const Color(0xff407BFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.09,
            horizontal: screenHeight * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border,
                    labelStyle: const TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                    labelText: 'Issue type',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.02,
                    ),
                  ),
                  value: _selectedIssueType,
                  items: issueTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedIssueType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an issue type.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border,
                    labelStyle: const TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                    labelText: 'Description',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.02,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.09),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff407BFF),
                          ),
                          onPressed: _registerComplaint,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.27,
                              vertical: screenHeight * 0.01,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                if (_message.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    _message,
                    style: TextStyle(
                      color: _message.contains('successfully')
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
