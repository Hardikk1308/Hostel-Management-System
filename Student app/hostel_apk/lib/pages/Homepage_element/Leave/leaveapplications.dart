// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../../utils/Notification.dart';


// class Leave extends StatefulWidget {
//   const Leave({Key? key}) : super(key: key);

//   @override
//   State<Leave> createState() => _LeaveState();
// }

// class _LeaveState extends State<Leave> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final TextEditingController textEditingController = TextEditingController();
//   final TextEditingController textEditingController1 = TextEditingController();
//   final TextEditingController numberController = TextEditingController();

//   int? selectedItem;
 
//   late DateTime selectedDate = DateTime.now();
//   late TimeOfDay selectedTime = TimeOfDay.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2015, 8),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }




//  //Backend integration
//   Future<void> sendLeaveRequest() async {
//     const url = 'https://hm-system-l1p1.onrender.com/api/leave/leave-request'; 
//     final Map<String, dynamic> requestData = {
//       'name': _textEditingController.text,
//       'room_no': textEditingController.text,
//       'phone_no': numberController.text,
//       'date': selectedDate.toLocal().toString().split(' ')[0],
//       'time': '${selectedTime.hour}:${selectedTime.minute}',
//       'reason': textEditingController1.text,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(requestData),
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Container(
//             height: 60,
//             width: MediaQuery.of(context).size.width * 0.4,
//             decoration: const BoxDecoration(
//               color: Colors.greenAccent,
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//             ),
//             child: const Center(
//               child: Text(
//                 'Request submitted',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Container(
//             height: 60,
//             width: MediaQuery.of(context).size.width * 0.4,
//             decoration: const BoxDecoration(
//               color: Colors.redAccent,
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//             ),
//             child: const Center(
//               child: Text(
//                 'Failed to submit',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ));
//       }
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Container(
//           height: 60,
//           width: MediaQuery.of(context).size.width * 0.4,
//           decoration: const BoxDecoration(
//             color: Colors.redAccent,
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//           ),
//           child: const Center(
//             child: Text(
//               'Error occurred',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ));
//     }
//   }








//   final border = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10),
//     borderSide: const BorderSide(color: Colors.black),
//   );

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 60,
//         iconTheme: const IconThemeData(color: Colors.white, size: 30),
//         title: const Text('Apply for leave'),
//         titleTextStyle: const TextStyle(
//             color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) {
//                 return const Notify();
//               }));
//             },
//             icon: const Icon(Icons.notification_add),
//           )
//         ],
//         actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
//         backgroundColor: const Color(0xff407BFF),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Enter Name',
//                   style: style,
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
                  
//                   labelText: 'Name',
//                   labelStyle: const TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 ),
//                 keyboardType: TextInputType.text,
//                 controller: _textEditingController,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//                const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Enter ERPID',
//                   style: style,
//                 ),
//               ),
//                  TextFormField(
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
//                   focusedBorder: border,
//                   enabledBorder: border,
//                   labelText: 'Erp',
//                   labelStyle: const TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 ),
//                 keyboardType: TextInputType.text,
//                 controller: _textEditingController,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Enter room no.',
//                   style: style,
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
//                   focusedBorder: border,
//                   enabledBorder: border,
//                   labelText: 'Room no.',
//                   labelStyle: const TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 ),
//                 keyboardType: TextInputType.text,
//                 controller: textEditingController,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Enter phone no.',
//                   style: style,
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
//                   focusedBorder: border,
//                   enabledBorder: border,
//                   labelText: 'Phone no.',
//                   labelStyle: const TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 ),
//                 controller: numberController,
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Enter Date',
//                   style: style,
//                 ),
//               ),
//               Container(
//                 height: screenHeight * 0.07,
//                 width: screenWidth * 0.8,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black, width: 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "${selectedDate.toLocal()}".split(' ')[0],
//                     style: const TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(screenWidth * 0.8, screenHeight * 0.07),
//                   backgroundColor: const Color(0xff407BFF),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () => _selectDate(context),
//                 child: const Text(
//                   'Select Date',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Enter Time',
//                   style: style,
//                 ),
//               ),
//               Container(
//                 height: screenHeight * 0.07,
//                 width: screenWidth * 0.8,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black, width: 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "${selectedTime.hour}:${selectedTime.minute}",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(screenWidth * 0.8, screenHeight * 0.07),
//                   backgroundColor: const Color(0xff407BFF),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () => _selectTime(context),
//                 child: const Text(
//                   'Select Time',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Describe your Reason',
//                   style: style,
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.03),
//                   focusedBorder: border,
//                   enabledBorder: border,
//                   labelText: 'Reason',
//                   labelStyle: const TextStyle(
//                     color: Colors.black38,
//                     fontSize: 20,
//                   ),
//                 ),
//                 maxLines: 15,
//                 controller: textEditingController1,
//                 keyboardType: TextInputType.text,
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(screenWidth * 0.8, screenHeight * 0.07),
//                   backgroundColor: const Color(0xff407BFF),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   sendLeaveRequest();
//                 },
//                 child: const Text(
//                   'Verify',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
