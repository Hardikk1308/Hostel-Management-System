import 'package:flutter/material.dart';
// import 'package:super_admin_app/utils/Elevatedbutton.dart';

import '../utils/Notification.dart';

class Add_warden extends StatefulWidget {
  const Add_warden({super.key});

  @override
  State<Add_warden> createState() => _Add_wardenState();
}

class _Add_wardenState extends State<Add_warden> {
  final TextEditingController numberController = TextEditingController();
  // final EmailController emailController = EmailController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Style2 = const TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

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
        title: Text('Add Warden'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Enter Name', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ERP ID is required';
                  }
                  return null;
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "Name",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Enter ERP Id', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ERP ID is required';
                  }
                  return null;
                },
                controller: numberController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "ERP ID",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Enter Email Id', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ERP ID is required';
                  }
                  return null;
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "Email id",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Enter Contact No.', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ERP ID is required';
                  }
                  return null;
                },
                controller: numberController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "ERP ID",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Enter Address', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "Address",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Password', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "Password",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Enter Hostel', style: Style2),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hostel is required';
                  }
                  return null;
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  focusedErrorBorder: border,
                  errorBorder: border,
                  labelText: "Hostel",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black38,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                  backgroundColor: const Color(0xff407BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
