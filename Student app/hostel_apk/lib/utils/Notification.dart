import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  List<dynamic> complaints = [];
  bool isLoading = true;
  final Dio _dio = Dio();
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchComplaints();
  }

  Future<void> _loadUserIdAndFetchComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('_id');
    if (userId != null) {
      await fetchComplaints(userId!);
    } else {
      _showMessage("User ID not found. Please log in again.", isError: true);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchComplaints(String userId) async {
    try {
      final response = await _dio.get(
        'https://hm-system-l1p1.onrender.com/api/complaint/getstudentbyid/$userId',
      );

      if (response.statusCode == 200) {
        final complaintList = response.data["complaints"] as List<dynamic>;

        complaintList.sort((a, b) =>
            DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));

        setState(() {
          complaints = complaintList;
        });
      } else {
        _showMessage("Failed to load complaints.", isError: true);
      }
    } catch (e) {
      _showMessage("Error: $e", isError: true);
    }
  }

  Future<void> updateComplaint(String id, bool satisfied,
      {String? reason}) async {
    try {
      final response = await _dio.patch(
        'https://hm-system-l1p1.onrender.com/api/complaint/complaintBy/$id/status',
        data: {
          "action": satisfied ? "satisfied" : "notSatisfied",
          "reason": reason ??
              (satisfied ? "Marked as satisfied" : "Marked as unsatisfied"),
        },
      );
      print(response.data);

      if (response.statusCode == 200 && response.data["success"] == true) {
        setState(() {
          complaints = complaints.map((complaint) {
            if (complaint["_id"] == id) {
              complaint["status"] = satisfied ? "Solved" : "Pending";
              complaint["currentStatus"] =
                  satisfied ? "satisfied" : "Unsatisfied";
            }
            return complaint;
          }).toList();
        });
        _showMessage(
          satisfied
              ? "Complaint marked as satisfied."
              : "Complaint marked as unsatisfied.",
        );
      } else {
        _showMessage("Failed to update complaint status.", isError: true);
      }
    } catch (e) {
      _showMessage("Error: $e", isError: true);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
  

  void _showReasonDialog(String id) {
    final TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Provide a Reason",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter reason for unsatisfied",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final reason = reasonController.text.trim();
                        if (reason.isNotEmpty) {
                          Navigator.of(context).pop();
                          updateComplaint(id, false, reason: reason);
                        } else {
                          _showMessage("Reason cannot be empty.",
                              isError: true);
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFEDFF),
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff407BFF),
        iconTheme: const IconThemeData(
            color: Colors.white), // Set back button color to white
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : complaints.isEmpty
              ? const Center(child: Text("No notifications available."))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints[index];
                    final formattedDate = DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(complaint["date"]));
                    final status = complaint["status"];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              complaint["type"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(complaint["description"]),
                            const SizedBox(height: 5),
                            Text("Date: $formattedDate"),
                            const SizedBox(height: 5),
                            Text(
                              "Status: $status",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: status == "Solved"
                                    ? Colors.green
                                    : status == "Pending"
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      updateComplaint(complaint["_id"], true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    elevation: 5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Satisfied",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      _showReasonDialog(complaint["_id"]),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    elevation: 5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Unsatisfied",
                                    style: TextStyle(color: Colors.white),
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
}
