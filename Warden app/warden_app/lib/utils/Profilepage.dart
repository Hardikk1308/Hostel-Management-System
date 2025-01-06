import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dioCall;

class ProfilePage extends StatefulWidget {
  final String user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String wardenName = 'Loading...';
  String role = 'Loading...';
  String erpId = 'Loading...';
  String email = 'Loading...';
  String phone = 'Loading...';
  String hostel = 'Loading...';


  Future<void> fetchUserData(String userId) async {
    try {
      final dio = dioCall.Dio();
      
      final res = await dio.get(
        'https://hm-system-l1p1.onrender.com/api/warden/get-warden/$userId',
        queryParameters: {"userId": userId},
      );
    
      

      if (res.statusCode == 200) {
        if(mounted){
        
        final response = res.data;
        setState(() {
          wardenName = response['warden']['name'];
          role = response['warden']['role'];
          erpId = response['warden']['erpid'].toString();
          email = response['warden']['email'];
          phone = response['warden']['contact'].toString();
          hostel = response['warden']['hostel']['hostelname'].toString();
        });
        }
      } else {
        throw Exception(
            'Failed to load user data, status code: ${res.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    print('User ID: ${widget.user}');
    fetchUserData(widget.user);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  wardenName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ProfileDetailRow(label: 'ERP ID:', value: erpId),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Role:', value: role),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Contact:', value: phone),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Hostel Name:', value: hostel),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
                ProfileDetailRow(label: 'Email:', value: email),
                const Divider(
                  thickness: 1.5,
                  height: 1.5,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetailRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
