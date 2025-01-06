import 'package:flutter/material.dart';
import '../../utils/Notification.dart';

class Complain extends StatefulWidget {
  const Complain({super.key});

  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  final TextEditingController _textEditingController = TextEditingController();
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

  int? selectedItem;
  static const style = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text('Complain'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Notify();
                  }));
                },
                icon: const Icon(Icons.notification_add),
              ),
            ),
          )
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: const Color(0xff407BFF),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Select an issue',
                  style: style,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 45,
                width: 310,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  value: selectedItem,
                  hint: const Padding(
                    padding:  EdgeInsets.symmetric(horizontal:10 ),
                    child:  Text('Select Issue'),
                  ),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Technical issue'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Electricity Issue'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Mess Issue'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('Other Issue'),
                    ),
                  ],
                  onChanged: (item) {
                    setState(() {
                      selectedItem = item as int;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter room no.',
                  style: style,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Room no.',
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                controller: _textEditingController,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Describe your issue',
                  style: style,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -4, horizontal: 10),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Describe your issue',
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: _textEditingController,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter date',
                  style: style,
                ),
              ),
            ),
           Column(
              children: [
                Container(
                  height: 45,
                  width: 300,
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
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 45),
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

            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 45),
                backgroundColor: const Color(0xff407BFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) {
                //   return const Homeepage();
                // }));
                // // if (_formKey.currentState!.validate()) {
                // //  print('Validation');
                // // }
              },
              child: const Text(
                'Apply',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
