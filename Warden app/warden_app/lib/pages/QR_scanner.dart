import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../Modules/Qrdetailspage.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _scanned = false; // Flag to check if already scanned

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Column(
        children: <Widget>[
          // Reduced back flex size to 3
          Expanded(
            flex: 3,         
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          // Reduced flex size to 1
          const Expanded(
            flex: 1,
            child: Center(
              child: Text('Scanning...', style: TextStyle(fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!_scanned) {
        setState(() {
          _scanned = true; // Set scanned flag to prevent multiple triggers
        });
        controller.pauseCamera(); // Pause the camera after scanning
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRResultPage(
              result: scanData.code ?? '',
              onScanAgain: () {
                // Reset the scanner and resume camera when coming back
                setState(() {
                  _scanned = false; // Reset scanned flag
                });
                controller
                    .resumeCamera(); // Resume the camera for scanning again
              },
            ),
          ),
        ).then((_) {
          // Reset the scanner when returning to the scanning page
          setState(() {
            _scanned = false; // Clear the scanned flag
          });
          controller.resumeCamera(); // Resume scanning when back
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
