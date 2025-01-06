import 'package:flutter/material.dart';
import '../utils/Notification.dart';

class MIS extends StatefulWidget {
  const MIS({super.key});

  @override
  State<MIS> createState() => _MISState();
}

class _MISState extends State<MIS> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  final TextEditingController textEditingController3 = TextEditingController();
  final TextEditingController textEditingController4 = TextEditingController();
  final TextEditingController textEditingController5 = TextEditingController();



  

   final Style2 = const TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  late DateTime selectedDate = DateTime.now();
   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 245, 245),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: Text('MIS Report'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Padding(
                padding: EdgeInsets.only(right: 5),
                child: IconButton(
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
                    icon: Icon(Icons.notification_add))),
          )
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Date',style: Style2),
                           Column(
                children: [
                  Container(
                    height: 45,
                    width: 350,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 200,top: 10),
                          child: Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 40),
                      backgroundColor: const Color(0xff407BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _selectDate(context),
                    child: const Text(
                      'Select Date',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
          
                     Text('Total Student',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Total Student';
                      //   }
                      //   return null;
                      // },
                      controller: numberController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: 'Total Student',
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black38,
                    ),
          

           const SizedBox(
                    height: 15.0,
                  ),
                     Text('Total Student Present',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Total Student Present';
                      //   }
                      //   return null;
                      // },
                      controller: textEditingController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: "Total Student Present",
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black38,
                    ),
           const SizedBox(
                    height: 15.0,
                  ),
                     Text('Total Student Absent',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Total Student Absent';
                      //   }
                      //   return null;
                      // },
                      controller: textEditingController1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: "Total Student Absent",
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black38,
                    ),
           const SizedBox(
                    height: 15.0,
                  ),
                     Text('Total Student not present',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Total Student not present';
                      //   }
                      //   return null;
                      // },
                      controller: textEditingController2,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: "Total Student not present(Red cases)",
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black38,
                    ),
           const SizedBox(
                    height: 15.0,
                  ),
                     Text('Student on leave',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Student on leave';
                      //   }
                      //   return null;
                      // },
                      controller: textEditingController3,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: "Student on leave",
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black38,
                    ),
           const SizedBox(
                    height: 15.0,
                  ),
                     Text('Enter Hostel name',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Hostel is required';
                      //   }
                      //   return null;
                      // },
                      controller:textEditingController4 ,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: "Enter Hostel name",
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black38,
                    ),
         const SizedBox(
                    height: 15.0,
                  ),
                      Text('Student not attending classes',style: Style2),
               TextFormField(
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Hostel is required';
                      //   }
                      //   return null;
                      // },
                      controller: textEditingController5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: -4, horizontal: 10),
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: border,
                        errorBorder: border,
                        labelText: "Student not attending classes",
                        labelStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black38,
                    ),
                   SizedBox(height: 20,),
                     Center(
                       child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               minimumSize: const Size(230, 45),
                               backgroundColor: const Color(0xff407BFF),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(15),
                               ),
                             ),
                             onPressed: () {
                               // Navigator.of(context).push(MaterialPageRoute(builder: (context) => onPressed()));
                             },
                             child: Text(
                               'Add',
                               style: TextStyle(fontSize: 18, color: Colors.white),
                             ),
                           ),
                     )
            ],
          ),
          
        ),
      ),

    );
    
  }
}
