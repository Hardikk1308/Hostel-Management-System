import 'package:flutter/material.dart';
import 'package:hostel_apk/pages/Homepage_element/Leave_types/trave_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Leave_types/outing.dart';

class LeaveApply extends StatefulWidget {
  const LeaveApply({Key? key}) : super(key: key);

  @override
  State<LeaveApply> createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply> {
  String studentName = 'Loading...';
  String erpId = 'Loading...';
  String roomNumber = 'Loading...';
  String hostelName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load data from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      studentName = prefs.getString('studentName') ?? 'N/A';
      erpId = prefs.getString('erpId') ?? 'N/A';
      roomNumber = prefs.getString('roomNumber') ?? 'N/A';
      hostelName = prefs.getString('hostelName') ?? 'N/A';
    });
  }

  // Navigate to the corresponding page
  void _navigateToLeavePage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
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
        title: const Text('Apply For Leave'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.030,
        ),
        child: Column(
          children: [
            _buildLeaveOption(
              context,
              icon: Icons.bungalow_outlined,
              iconColor: Colors.green,
              title: 'Leave for Home Application',
              onTap: () => _navigateToLeavePage(
                TravelHome(
                  studentName: studentName,
                  roomNumber: roomNumber,
                  erpId: erpId,
                  hostelName: hostelName,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildLeaveOption(
              context,
              icon: Icons.mode_of_travel_rounded,
              iconColor: Colors.red,
              title: 'Outing Application',
              onTap: () => _navigateToLeavePage(
                Outing(
                  roomNumber: roomNumber,
                  erpId: erpId,
                  hostelName: hostelName,
                  studentName: studentName,
                ),
              ),
            ),
            // SizedBox(height: screenHeight * 0.03),
            // _buildLeaveOption(
            //   context,
            //   icon: Icons.home_work_outlined,
            //   iconColor: Colors.blue,
            //   title: 'Stay in Hostel Application',
            //   onTap: () => _navigateToLeavePage(
            //     hostel_stay(
            //       roomNumber: roomNumber,
            //       erpId: erpId,
            //       hostelName: hostelName,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveOption(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      elevation: 10,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: screenHeight * 0.070,
            width: screenWidth * 0.9,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.01,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 35,
                  color: iconColor,
                ),
                SizedBox(width: screenWidth * 0.05),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
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
