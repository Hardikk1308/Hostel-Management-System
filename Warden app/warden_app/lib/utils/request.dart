import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaveRequestsPage extends StatefulWidget {
  @override
  _LeaveRequestsPageState createState() => _LeaveRequestsPageState();
}

class _LeaveRequestsPageState extends State<LeaveRequestsPage> {
  List<dynamic> leaveRequests = [];

  Future<void> fetchLeaveRequests() async {
    const url = 'http://192.168.202.101:7000/api/leave/leave-details/:erpid';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          leaveRequests = jsonDecode(response.body);
        });
      } else {
        print('Failed to fetch leave requests: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLeaveRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Requests'),
      ),
      body: ListView.builder(
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          final leaveRequest = leaveRequests[index];
          return ListTile(
            title: Text(leaveRequest['name']),
            subtitle: Text('Room: ${leaveRequest['room_no']}'),
          );
        },
      ),
    );
  }
}
