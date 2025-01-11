import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Model/issuesnotification.dart';

class DetailIssue extends StatefulWidget {
  final issue selectedIssue;

  const DetailIssue({super.key, required this.selectedIssue});

  @override
  State<DetailIssue> createState() => _DetailIssueState();
}

class _DetailIssueState extends State<DetailIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Issues Detail'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text: TextSpan(
              children: [
                   TextSpan(
                    text: 'Type:',
              
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
            ),
          
            TextSpan(
              text: '${widget.selectedIssue.issues}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.black),

            )
              ]
            )),
            const SizedBox(height: 20),

             RichText(text: TextSpan(
              children: [
                   TextSpan(
                    text: 'Room Number:',
              
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
            ),
          
            TextSpan(
              text: '${widget.selectedIssue.roomNumber}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.black),

            )
              ]
            )),
           
            // const SizedBox(height: 10),
           
            const SizedBox(height: 20),
             const Text(
              'Lorem ipsum dolor sit amet consectetur. Urna vitae dictum porttitor facilisis ut odio pharetra sagittis et. Vitae lectus egestas cursus interdum donec et mattis ipsum. Auctor diam eu sed facilisis egestas elementum. Magnis vitae elit mauris diam aliquet dignissim. Dui vulputate pellentesque pellentesque metus at felis. Metus duis porttitor congue congue auctor.',
              style:  TextStyle(fontSize: 16),
            ),
            const SizedBox(height:100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                   onTap: () {
                    
                  },
                  child: Material(
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text('Approve',style: TextStyle(
                            color: Colors.white,fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
            const SizedBox(width:15),
                
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Material(
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.red
                        ),
                         child: const Center(
                           child: Text('Igonre',style: TextStyle(
                            color: Colors.white,fontSize: 20,
                            fontWeight: FontWeight.w400
                                             ),),
                         ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
