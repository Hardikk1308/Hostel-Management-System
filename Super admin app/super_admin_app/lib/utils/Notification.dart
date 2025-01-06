import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  final TextEditingController textEditingController = TextEditingController();

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFEDFF),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Send Notification'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.only(right: 15),
            ),
          )
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
              ),
              TextFormField(  
                 maxLength: 50,
                 maxLines: 15,
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,                
                  hintTextDirection: TextDirection.ltr,                
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.text,
                cursorColor: Colors.black38,
              ),
              const Row(
                children: [
                  Icon(Icons.notification_add),
                  SizedBox(width: 10,),
                  Text('Send notification',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:  FontWeight.w400
                  ),),
                ],
              ),

                    SizedBox(height: 20,),

                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        backgroundColor: const Color(0xff407BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const Homeepage()));
                      },
                      child: Text(
                        "Student",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),

                    SizedBox(width: 10,),
                     ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: const Color(0xff407BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const Homeepage()));
                  },
                  child: Text(
                    "Warden",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                    SizedBox(width: 10,),

                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: const Color(0xff407BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                 
                  },
                  child: Text(
                    "Guard",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
                  ],
                )

            ],
          ),
        ),
      ),
    );
  }
}
