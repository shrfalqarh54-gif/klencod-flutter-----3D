import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'model_viewer_screen.dart'; // سنقوم بإنشائه في الخطوة القادمة

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isScanned = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('وجّه الكاميرا لباركود التجربة'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Color(0xFFD4AF37));
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          if (_isScanned) return; 

          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              _isScanned = true;
              final String code = barcode.rawValue!;
              
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ModelViewerScreen(modelName: code),
                ),
              );
              break;
            }
          }
        },
      ),
    );
  }
}