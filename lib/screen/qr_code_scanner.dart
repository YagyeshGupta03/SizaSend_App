import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Constants/theme_data.dart';
import '../Controllers/quotation_controller.dart';

class DispatchScanner extends StatefulWidget {
  const DispatchScanner({super.key, required this.orderId});

  final String orderId;

  @override
  State<DispatchScanner> createState() => _DispatchScannerState();
}

class _DispatchScannerState extends State<DispatchScanner> {
  final QuotationController _quotationController =
      Get.put(QuotationController());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: primaryColor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: screenHeight(context)/5,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                            child: Text(
                              '${result!.code}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            _quotationController.sendDispatchCode(context,
                                result!.code.toString(), widget.orderId);
                            // Navigator.pop(context);
                          },
                          child: Container(
                            color: primaryColor,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 25),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      // color: primaryColor,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Center(
                        child: Text(
                          'Scanning...',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}







class DeliverScanner extends StatefulWidget {
  const DeliverScanner({super.key, required this.orderId, required this.senderId});

  final String orderId;
  final String senderId;

  @override
  State<DeliverScanner> createState() => _DeliverScannerState();
}

class _DeliverScannerState extends State<DeliverScanner> {

  final QuotationController _quotationController =
  Get.put(QuotationController());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? deliverResult;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: primaryColor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (deliverResult != null)
                  ? Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: screenHeight(context)/5,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Text(
                        '${deliverResult!.code}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      _quotationController
                          .sendDeliveredCode(
                          context,
                          deliverResult!.code.toString(),
                          widget.orderId,
                          widget.senderId);
                      // Navigator.pop(context);
                    },
                    child: Container(
                      color: primaryColor,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Container(
                // color: primaryColor,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: Text(
                    'Scanning...',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        deliverResult = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}



