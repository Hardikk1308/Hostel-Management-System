import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../utils/Notification.dart';

class GetComplaints extends StatefulWidget {
  @override
  _GetComplaintsState createState() => _GetComplaintsState();
}

class _GetComplaintsState extends State<GetComplaints> {
  List<dynamic> _pendingComplaints = [];
  dynamic _selectedComplaint;
  bool _isLoading = false;
  String _message = '';

  // GET COMPLAINTS BACKEND
  Future<void> _fetchPendingComplaints() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://hm-system-l1p1.onrender.com/api/complaint/getcomplaint'),
      );

      if (response.statusCode == 200) {
        final complaints = jsonDecode(response.body)['complaints'];
        setState(() {
          // Filter only pending complaints
          _pendingComplaints = complaints
              .where((complaint) =>
                  complaint['status']?.toLowerCase() == 'pending')
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _message = 'Error fetching pending complaints';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: Unable to fetch complaints';
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPendingComplaints();
  }

  // Method to mark complaint as solved
  Future<void> _markComplaintAsSolved(String complaintId) async {
    setState(() {
      _isLoading = true;
    });

    print('Complaint ID: $complaintId');
    final response = await http.put(
      Uri.parse(
          'https://hm-system-l1p1.onrender.com/api/complaint/resolved/$complaintId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}'); // Log the full response body

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        _message = responseBody['msg']; // Display success message
        // Remove the solved complaint from the list
        _pendingComplaints
            .removeWhere((complaint) => complaint['_id'] == complaintId);
        if (_pendingComplaints.isNotEmpty) {
          // Automatically select the next complaint if available
          _selectedComplaint = _pendingComplaints[0];
        } else {
          _selectedComplaint =
              null; // No more complaints, reset selected complaint
        }
      });
    } else {
      final responseBody = jsonDecode(response.body);
      setState(() {
        _message = 'Error: ${responseBody['msg'] ?? 'Unknown Error'}';
      });
      print('Error Response: ${response.body}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Method to ignore complaint
  Future<void> _ignoreComplaint(
      String complaintId, String status, String notSolvedReason) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Log data being sent
      print(
          'Sending Data: { status: $status, notSolvedReason: $notSolvedReason }');

      final response = await http.post(
        Uri.parse(
            'https://hm-system-l1p1.onrender.com/api/complaint/unresolved/$complaintId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': status,
          'notSolvedReason': notSolvedReason,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        setState(() {
          _message = responseBody['msg'] ??
              'Complaint marked as unresolved successfully';

          // Refresh the pending complaints list
          _pendingComplaints
              .removeWhere((complaint) => complaint['_id'] == complaintId);
          _selectedComplaint = null;

          if (_pendingComplaints.isEmpty) {
            _fetchPendingComplaints(); // Fetch updated complaints list
          }
        });
      } else {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _message =
              'Error: ${responseBody['msg'] ?? 'Unknown error occurred'}';
        });
        print('Error Response: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _message = 'Error: Unable to send data to server';
      });
      print('Exception: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Show dialog to get reason for ignoring
  void _showIgnoreReasonDialog(String complaintId) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ignore Complaint'),
          content: TextField(
            controller: reasonController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter reason for ignoring',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                final notSolvedReason = reasonController.text.trim();
                if (notSolvedReason.isNotEmpty) {
                  Navigator.of(context).pop(); // Close the dialog
                  _ignoreComplaint(
                      complaintId, 'Unsolved', notSolvedReason); // Send reason
                } else {
                  // Show error if reason is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reason cannot be empty!')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Pending Complaints'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _pendingComplaints.isEmpty
              ? const Center(child: Text('No pending complaints'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (_selectedComplaint == null)
                        Expanded(
                          child: ListView.builder(
                            itemCount: _pendingComplaints.length,
                            itemBuilder: (context, index) {
                              final complaint = _pendingComplaints[index];
                              return Card(
                                shadowColor: Colors.blue,
                                elevation: 8,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Issue: ${complaint['type']},',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //     'Room: ${complaint['student']['room']['roomNumber']}',
                                      //     style: const TextStyle(
                                      //         fontSize: 17,
                                      //         fontWeight: FontWeight.w400)),
                                      Text(
                                        'Date: ${DateFormat.yMMMd().format(DateTime.parse(complaint['date']))}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedComplaint = complaint;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Card(
                          shadowColor: Colors.blue,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Issue Type: ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _selectedComplaint['type'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Row(
                                  children: [
                                    Text(
                                      'Room No: ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text(
                                    //   _selectedComplaint['student']['room']
                                    //       ['roomNumber'],
                                    //   style: const TextStyle(
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.w400),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        _selectedComplaint['description'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        softWrap: true, // Allow text to wrap
                                        overflow: TextOverflow
                                            .visible, // Ensure all text is visible
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SOLVED BUTTON
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {
                                        _markComplaintAsSolved(
                                            _selectedComplaint['_id']);
                                      },
                                      child: const Text('Solved'),
                                    ),
                                    // IGNORE BUTTON
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        _showIgnoreReasonDialog(
                                            _selectedComplaint['_id']);
                                      },
                                      child: const Text('Ignore'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}
