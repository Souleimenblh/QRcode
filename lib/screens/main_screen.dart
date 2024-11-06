import 'package:flutter/material.dart';
import 'qr_code_generator_screen.dart';
import 'qr_code_scanner_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QrCodeGeneratorScreen()),
                );
              },
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QrCodeScannerScreen()),
                );
              },
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
