import 'package:flutter/material.dart';
import 'package:warden_app/Homepage_element.dart/Leave_types/travel_home.dart';
import '../Homepage_element.dart/Attendencetab.dart';
import 'complain_new.dart';


class Dashboards extends StatefulWidget {
  final String studentName;
  final String course;
  final String user; // Add this line

  const Dashboards(
      {super.key,
      required this.studentName,
      required this.course,
      required this.user}); 

  @override
  State<Dashboards> createState() => DashboardsState();
}

class DashboardsState extends State<Dashboards> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var padding = screenWidth > 600 ? 40.0 : 35.0;
    var avatarRadius = screenWidth > 600 ? 40.0 : 30.0;

    return Column(
      children: [
        Material(
          elevation: 4,
          child: Container(
            color: Colors.white,
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    child: Text(widget.studentName[
                        0]), // Display the initial instead of the full name
                  ),
                  SizedBox(width: padding),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.studentName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.course,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            // Attendance and Room Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDashboardCard(
                  title: 'Attendance',
                  icon: Icons.fact_check_outlined,
                  color: const Color.fromARGB(255, 108, 202, 135),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>Attendence(user: widget.user,)),
                  ),
                ),
                _buildDashboardCard(
                  title: 'Red Cases',
                  icon: Icons.pending_actions_sharp,
                  color: const Color(0xffE6667A),
                  onTap: () {
                  //     Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => Redcases(
                  //             user: widget.user,
                  //           )),
                  // ),
                  }
                 
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDashboardCard(
                  title: 'Complains',
                  icon: Icons.error_outline,
                  color: const Color(0xffFF9900),
                  onTap: () {
                        Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => GetComplaints()),
                  );
                  }
               
                ),
                _buildDashboardCard(
                  title: 'Leave Requests',
                  icon: Icons.cases_outlined,
                  color: const Color(0xffC8C465),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TravelHome()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    var screenWidth = MediaQuery.of(context).size.width;
    var cardHeight = screenWidth > 600 ? 200.0 : 145.0;
    var cardWidth = screenWidth > 600 ? 200.0 : 143.0;
    var iconSize = screenWidth > 600 ? 40.0 : 30.0;

    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: cardHeight,
                  width: cardWidth,
                  color: color,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, bottom: cardHeight - 55),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 5,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
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
