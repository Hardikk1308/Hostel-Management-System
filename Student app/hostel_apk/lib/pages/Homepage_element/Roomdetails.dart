import 'package:flutter/material.dart';
import '../../utils/Notification.dart';
import 'package:dio/dio.dart' as dioCall;

class Roomdetails extends StatefulWidget {
  final String user;

  const Roomdetails({super.key, required this.user});

  @override
  State<Roomdetails> createState() => _RoomdetailsState();
}

class _RoomdetailsState extends State<Roomdetails> {
  String room = 'Loading...';
  String hostelName = 'A Block';
  String availableBeds = 'Loading...';
  List<dynamic> studentList = [];
  Future<void> fetchUserData(String userId) async {
    try {
      final dio = dioCall.Dio();

      final res = await dio.get(
        'https://hm-system-l1p1.onrender.com/api/register/get-room-details',
        data: {"userId": userId},
      );

      final response = res.data;

      if (res.statusCode == 200) {
        setState(() {
          room = response['roomDetails']['roomNumber'];
          hostelName = response['roomDetails']['hostel']['hostelname'];
          availableBeds = response['roomDetails']['__v'].toString();
          studentList = response['roomDetails']['students'] ?? [];
        });
      } else {
        throw Exception(
            'Failed to load user data, status code: ${res.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Room details'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Notify();
                  },
                ),
              );
            },
            icon: const Icon(Icons.notification_add),
          ),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Room no.: $room',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Text(
                  'Hostel name: $hostelName',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 300,
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Available beds: $availableBeds',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.bed,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, right: 140),
                  child: Text(
                    'Student details',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20),
                studentList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          final student = studentList[index]['student'];

                          // Check if 'student' is a Map and contains 'name'
                          if (student is Map<String, dynamic> &&
                              student.containsKey('name')) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 30,
                                    child: Icon(Icons.person),
                                  ),
                                  const SizedBox(width: 20,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: ${student['name']}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight. w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Text(
                              'Invalid student data',
                              style: TextStyle(fontSize: 16),
                            );
                          }
                        },
                      )
                    : const Text(
                        'No students found',
                        style: TextStyle(fontSize: 16),
                      ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
