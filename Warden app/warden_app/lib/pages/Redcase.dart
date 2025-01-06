// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../Modules/Room.dart';

// class RoomPage extends StatefulWidget {
//   final Room room;

//   RoomPage({required this.room});

//   @override
//   _RoomPageState createState() => _RoomPageState();
// }

// class _RoomPageState extends State<RoomPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 60,
//         iconTheme: const IconThemeData(color: Colors.white, size: 30),
//         title: Text('Room ${widget.room.roomNumber}'),
//         titleTextStyle: const TextStyle(
//             color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
//         actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
//         backgroundColor: const Color(0xff407BFF),
//       ),
//       body: Column(  
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 15),
//             child: Material(
//               elevation: 4,
//               color: const Color(0xffF5F5F5),
//               child: Container(
//                 height: 80,
//                 width: 330,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Room Number: ${widget.room.roomNumber}',
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Hostel Name: ${widget.room.hostel.name}',
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 190),
//             child: Text('Students Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.room.students.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                   title: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                     ),
//                     child: Text(
//                       widget.room.students[index].name,
//                       style:
//                           const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   value: widget.room.students[index].isPresent,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       widget.room.students[index].isPresent = value!;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 250),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(200, 45),
//                 backgroundColor: const Color(0xff407BFF),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               onPressed: () {
//                 // Navigator.of(context).push(
//                 //     MaterialPageRoute(builder: (context) => Homeepage()));
//               },
//               child: const Text(
//                 'Send',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
