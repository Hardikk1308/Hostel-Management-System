import 'package:flutter/material.dart';

class QRResultPage extends StatelessWidget {
  final String result;
  final VoidCallback onScanAgain;

  QRResultPage({required this.result, required this.onScanAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Result'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'QR Code Result:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                result,
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  onScanAgain();  // Call the callback to reset scanner
                  Navigator.pop(context);  // Go back to the scanner page
                },
                child: Text('Scan Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}