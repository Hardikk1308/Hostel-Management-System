import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:super_admin_app/pages/Add_warden.dart';
import 'package:super_admin_app/pages/Attendance.dart';
import 'package:super_admin_app/pages/MIS_report.dart';
import '../Homepage_element/issue.dart';
import '../utils/Iconbutton.dart';

class Dashboards extends StatefulWidget {
  const Dashboards({super.key, required jwt_token});

  @override
  State<Dashboards> createState() => DashboardsState();
}

class DashboardsState extends State<Dashboards> {
  final Style2 = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Material(
        elevation: 4,
        child: Container(
            color: Colors.white,
            height: 100,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Super Admin Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Designation',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),

      //Attendence
      Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Material(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 145,
                        width: 143,
                        color: const Color.fromARGB(255, 108, 202, 135),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 90),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fact_check_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 5,
                        child: Text(' Attendence', style: Style2),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -10,
                          child: IconButtonCustom(
                            onPressed: () => const Attandance(),
                          ))
                    ],
                  ),
                ),
              ),

              // ROOM DETAILS
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 12,
                ),
                child: Material(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 145,
                        width: 143,
                        color: const Color(0xff66A2E8),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 90),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bedroom_parent_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 8,
                        child: Text('MIS Report', style: Style2),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  Mis_report()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),

          //COMPLAIN
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Material(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 145,
                        width: 143,
                        color: const Color(0xffE6667A),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 90),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 5,
                        child: Text(' Complain', style: Style2),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -10,
                          child: IconButtonCustom(
                            onPressed: () => const Complain(),
                          ))
                    ],
                  ),
                ),
              ),

              // LEAVE
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 12,
                ),
                child: Material(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 145,
                        width: 143,
                        color: const Color(0xffC8C465),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 90),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 5,
                        child: Text(' Add Warden', style: Style2),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -10,
                          child: IconButtonCustom(
                            onPressed: () => const Add_warden(),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
