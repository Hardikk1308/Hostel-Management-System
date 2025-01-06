import 'Hostel.dart';
import 'Student.dart';

class Room {
  final String roomName;
  final List<Student> students;
  final String roomNumber;
  final Hostel hostel; 

  Room({required this.roomName, required this.students, required this.roomNumber, required this.hostel});
}
