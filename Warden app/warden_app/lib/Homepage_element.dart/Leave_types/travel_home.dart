import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TravelHome extends StatefulWidget {
  const TravelHome({super.key});

  @override
  State<TravelHome> createState() => _TravelHomeState();
}

class _TravelHomeState extends State<TravelHome> {
  List<dynamic> leaveDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaveDetails();
  }

  Future<void> fetchLeaveDetails() async {
    const String apiUrl =
        'https://hm-system-l1p1.onrender.com/api/leave/leave-all-details';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success']) {
          setState(() {
            leaveDetails = data['leaves'];
            isLoading = false;
          });
        } else {
          throw Exception('Failed to fetch leave details');
        }
      } else {
        throw Exception('Failed to fetch leave details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  Future<void> approveLeave(String id) async {
  final String apiUrl =
      'https://hm-system-l1p1.onrender.com/api/leave/approve-leave/$id';
  try {
    final response = await http.post(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success']) {
        await fetchLeaveDetails(); // Fetch updated leave details
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave approved successfully!')),
        );
      } else {
        throw Exception('Failed to approve leave');
      }
    } else {
      throw Exception('Failed to approve leave');
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error: Unable to approve leave')),
    );
  }
}

Future<void> declineLeave(String id) async {
  final String apiUrl =
      'https://hm-system-l1p1.onrender.com/api/leave/decline-leave/$id';
  try {
    final response = await http.post(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success']) {
        await fetchLeaveDetails(); // Fetch updated leave details
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave declined successfully!',
          style: TextStyle(
            color: Colors.red,
          ),)),
        );
      } else {
        throw Exception('Failed to decline leave');
      }
    } else {
      throw Exception('Failed to decline leave');
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error: Unable to decline leave')),
    );
  }
}


  void updateStatus(String id, String newStatus) {
    setState(() {
      leaveDetails = leaveDetails.map((leave) {
        if (leave['_id'] == id) {
          leave['status'] = newStatus;
        }
        return leave;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Date format
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Leave Applications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : leaveDetails.isEmpty
              ? const Center(child: Text('No leave applications found.'))
              : ListView.builder(
                  itemCount: leaveDetails.length,
                  itemBuilder: (context, index) {
                    final leave = leaveDetails[index];
                    final String id = leave['_id'];
                    final String name = leave['studentDetails']['name'];
                    final int erpid = leave['studentDetails']['erpid'];
                    final String roomNumber =
                        leave['roomDetails']['roomNumber'] ?? 'N/A';
                    final String leaveDate = leave['leaveDate'] ?? 'N/A';
                    final String returnDate = leave['returnDate'] ?? 'N/A';
                    final String leaveTime = leave['leaveTime'] ?? 'N/A';
                    final String reason = leave['reason'] ?? 'N/A';
                    final String status = leave['status'] ?? 'Unknown';

                    String formattedLeaveDate = leaveDate != 'N/A'
                        ? dateFormat.format(DateTime.parse(leaveDate))
                        : 'N/A';
                    String formattedReturnDate = returnDate != 'N/A'
                        ? dateFormat.format(DateTime.parse(returnDate))
                        : 'N/A';

                    Color cardColor;
                    if (status == 'Approved') {
                      cardColor = Colors.green.shade100;
                    } else if (status == 'Decline') {
                      cardColor = Colors.red.shade100;
                    
                    } else if (status == 'OutingRequest') {
                      cardColor = Colors.blue.shade100;
                    } else {
                      cardColor = Colors.white;
                    }

                    return Card(
                      color: cardColor,
                      elevation: 5,
                      shadowColor: Colors.blue,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextRow('Name', name, screenWidth),
                            const SizedBox(height: 5),
                            _buildTextRow('ERPID', '$erpid', screenWidth),
                            const SizedBox(height: 5),
                            _buildTextRow(
                                'Leave Date', formattedLeaveDate, screenWidth),
                            const SizedBox(height: 5),
                            if (status != 'OutingRequest')
                              _buildTextRow('Return Date', formattedReturnDate,
                                  screenWidth),
                            const SizedBox(height: 5),
                            _buildTextRow('Time', leaveTime, screenWidth),
                            const SizedBox(height: 5),
                            _buildTextRow('Reason', reason, screenWidth),
                            const SizedBox(height: 5),
                            _buildTextRow('Room', roomNumber, screenWidth),
                            const SizedBox(height: 5),
                            _buildStatusRow(status, screenWidth),
                            const SizedBox(height: 10),
                            if (status == 'Pending' ||
                                status == 'OutingRequest')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        approveLeave(id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text(
                                        'Approve',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),


                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        declineLeave(id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text(
                                        'Decline',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildTextRow(String label, String value, double screenWidth) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.041,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: screenWidth * 0.04,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String status, double screenWidth) {
    return RichText(
      text: TextSpan(
        text: 'Status: ',
        style: TextStyle(
          fontSize: screenWidth * 0.040,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: status,
            style: TextStyle(
              fontSize: screenWidth * 0.036,
              fontWeight: FontWeight.w500,
              color: status == 'Approved'
                  ? Colors.green
                  : status == 'Declined'
                      ? Colors.red
                      : status == 'Pending'
                          ? Colors.orange
                          : status == 'OutingRequest'
                              ? Colors.blue
                              : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
