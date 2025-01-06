import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Outing extends StatefulWidget {
  final String erpId;
  final String studentName;
  final String roomNumber;
  final String hostelName;

  const Outing(
      {super.key,
      required this.erpId,
      required this.studentName,
      required this.roomNumber,
      required this.hostelName});

  @override
  _OutingState createState() => _OutingState();
}

class _OutingState extends State<Outing> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _leaveDateController = TextEditingController();
  final TextEditingController _leaveTimeController = TextEditingController();

  DateTime? leaveDate;
  TimeOfDay? leaveTime;

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );

  final Dio _dio = Dio();

  Future<void> _pickLeaveDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        leaveDate = picked;
        _leaveDateController.text =
            "${leaveDate!.year}-${leaveDate!.month}-${leaveDate!.day}";
      });
    }
  }

  Future<void> _pickLeaveTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != leaveTime) {
      setState(() {
        leaveTime = picked;
        _leaveTimeController.text =
            "${leaveTime!.hour}:${leaveTime!.minute} ${leaveTime!.period.name.toUpperCase()}";
      });
    }
  }

  Future<void> submitRequest() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await _dio.post(
          'https://hm-system-l1p1.onrender.com/api/leave/outing-request',
          data: {
            "erpid": widget.erpId,
            "name": widget.studentName,
            "roomNumber": widget.roomNumber,
            "hostelname": widget.hostelName,
            "title": _titleController.text,
            "reason": _reasonController.text,
            "leaveDate": _leaveDateController.text,
            "leaveTime": _leaveTimeController.text,
          },
        );
        print(response.statusCode);
        print(response.data);

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Request submitted successfully!",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              elevation: 10,
            ),
          );
          // Navigate back to the previous page
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to submit request')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
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
        title: const Text('Outing Home'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Reason',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),

                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a reason';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Leave Date Picker
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: leaveDate == null
                            ? "No leave date selected"
                            : "Leave Date: ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: leaveDate == null
                                ? ""
                                : "${leaveDate!.day}/${leaveDate!.month}/${leaveDate!.year}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff407BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _pickLeaveDate,
                      child: const Text("Select Leave Date",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Leave Time Picker
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: leaveTime == null
                            ? "No leave time selected"
                            : "Leave Time: ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: leaveTime == null
                                ? ""
                                : "${leaveTime!.hour}:${leaveTime!.minute} ${leaveTime!.period.name.toUpperCase()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff407BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _pickLeaveTime,
                      child: const Text("Select Leave Time",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: submitRequest,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                      backgroundColor: const Color(0xff407BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit Request',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
