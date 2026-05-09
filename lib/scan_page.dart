import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  final Function(String) onScan;

  const ScanPage({required this.onScan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Barcode")),
      body: MobileScanner(
        onDetect: (barcodeCapture) {
          final List<Barcode> barcodes = barcodeCapture.barcodes;

          final String? code = barcodes.first.rawValue;

          if (code != null) {
            onScan(code);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
