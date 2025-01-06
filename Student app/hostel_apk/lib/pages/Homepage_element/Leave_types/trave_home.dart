import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TravelHome extends StatefulWidget {
  final String erpId;
  final String studentName;
  final String roomNumber;
  final String hostelName;
  const TravelHome(
      {Key? key,
      required this.erpId,
      required this.roomNumber,
      required this.hostelName,
      required this.studentName})
      : super(key: key);

  @override
  State<TravelHome> createState() => _TravelHomeState();
}

class _TravelHomeState extends State<TravelHome> {
  final _formKey = GlobalKey<FormState>();

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );

  // Controllers for manual inputs
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentNumberController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  DateTime? leaveDate;
  TimeOfDay? leaveTime;
  DateTime? returnDate;

  // Functions to pick date and time
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
      });
    }
  }

  Future<void> _pickReturnDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        returnDate = picked;
      });
    }
  }

  // Function to pick time
  Future<void> _pickLeaveTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != leaveTime) {
      setState(() {
        leaveTime = picked;
      });
    }
  }

  // Function to format time
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() ||
        leaveDate == null ||
        leaveTime == null ||
        returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Please fill all fields correctly!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final requestData = {
      "studentName": widget.studentName,
      "erpid": widget.erpId,
      "roomNumber": widget.roomNumber,
      "hostelname": widget.hostelName,
      "parentName": _parentNameController.text,
      "parentNumber": _parentNumberController.text,
      "title": _titleController.text,
      "reason": _reasonController.text,
      "leaveDate": "${leaveDate!.year}-${leaveDate!.month}-${leaveDate!.day}",
      "leaveTime":
          "${leaveTime!.hour}:${leaveTime!.minute} ${leaveTime!.period.name.toUpperCase()}",
      "returnDate":
          "${returnDate!.year}-${returnDate!.month}-${returnDate!.day}",
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://hm-system-l1p1.onrender.com/api/leave/leave-request'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

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

        Navigator.pop(context);
      } else {
        throw Exception(
          "Failed to submit request.",
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave for Home Application"),
        centerTitle: true,
        backgroundColor: const Color(0xff407BFF),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Parent Name
              const Text(
                "Parents Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: _parentNameController,
                decoration: InputDecoration(
                    labelText: "Parent Name",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border),
                validator: (value) =>
                    value!.isEmpty ? "Parent Name is required" : null,
              ),
              const SizedBox(height: 10),

              // Parent Number
              const Text(
                "Parents Number",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: _parentNumberController,
                decoration: InputDecoration(
                    labelText: "Parent Number",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Parent Number is required" : null,
              ),
              const SizedBox(height: 10),

              // Title
              const Text(
                "Title",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border),
                validator: (value) =>
                    value!.isEmpty ? "Title is required" : null,
              ),
              const SizedBox(height: 10),

              // Reason
              const Text(
                "Reason",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                    labelText: "Reason",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.02),
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border),
                validator: (value) =>
                    value!.isEmpty ? "Reason is required" : null,
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 10),

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
                          text:
                              leaveTime == null ? "" : _formatTime(leaveTime!),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
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
                    child: const Text(
                      "Select Leave Time",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              // Return Date Picker
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: returnDate == null
                          ? "No return date selected"
                          : "Return Date: ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: returnDate == null
                              ? ""
                              : "${returnDate!.day}/${returnDate!.month}/${returnDate!.year}",
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
                    onPressed: _pickReturnDate,
                    child: const Text("Select Return Date",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xff407BFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
