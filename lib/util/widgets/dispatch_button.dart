import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/quotation_controller.dart';
import 'login_button.dart';


class DispatchButton extends StatefulWidget {
  const DispatchButton({super.key, required this.orderId});

  final String orderId;
  @override
  State<DispatchButton> createState() => _DispatchButtonState();
}

class _DispatchButtonState extends State<DispatchButton> {
  final QuotationController _quotationController =
  Get.put(QuotationController());
  @override
  Widget build(BuildContext context) {
    return LoginButton(
        onTap: () async {
          Dialogs.materialDialog(
              msg: 'Scan the barcode',
              title: "Dispatch",
              titleAlign: TextAlign.center,
              color: Colors.white,
              context: context,
              actions: [
                IconsButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    FlutterBarcodeScanner
                        .scanBarcode(
                        "#ff6666",
                        "Cancel",
                        true,
                        ScanMode.DEFAULT)
                        ?.then((barcode) {
                      Dialogs.materialDialog(
                          msg: barcode.toString(),
                          title: 'Scanned code',
                          titleAlign:
                          TextAlign.center,
                          color: Colors.white,
                          context: context,
                          actions: [
                            IconsButton(
                              onPressed: () async {
                                Navigator.pop(
                                    context);
                              },
                              text: 'Cancel',
                              color: themeController
                                  .currentTheme
                                  .value
                                  .cardColor,
                              textStyle:
                              const TextStyle(
                                  color:
                                  primaryColor),
                              iconColor:
                              primaryColor,
                            ),
                            IconsButton(
                              onPressed: () async {
                                Navigator.pop(
                                    context);
                                _quotationController
                                    .sendDispatchCode(
                                    context,
                                    barcode
                                        .toString(),
                                   widget.orderId);
                              },
                              text: 'Submit',
                              iconData: Icons
                                  .document_scanner,
                              color: primaryColor,
                              textStyle:
                              const TextStyle(
                                  color: Colors
                                      .white),
                              iconColor:
                              Colors.white,
                            ),
                          ]);
                      // Get.to(() => DispatchScanner(
                      //     orderId:
                      //         _quotationController
                      //             .orderId,
                      //     barcode: barcode));
                    });
                  },
                  text: 'Scan',
                  iconData: Icons.document_scanner,
                  color: primaryColor,
                  textStyle: const TextStyle(
                      color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        },
        title: 'Dispatch',
        txtColor: Colors.white,
        btnColor: primaryColor);
  }
}




class DeliveryButton extends StatefulWidget {
  const DeliveryButton({super.key, required this.orderId, required this.senderId});

  final String orderId;
  final String senderId;
  @override
  State<DeliveryButton> createState() => _DeliveryButtonState();
}

class _DeliveryButtonState extends State<DeliveryButton> {
  final QuotationController _quotationController =
  Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return LoginButton(
        onTap: () async {
          Dialogs.materialDialog(
              msg: 'Scan the barcode',
              title: "Scan",
              titleAlign: TextAlign.center,
              color: Colors.white,
              context: context,
              actions: [
                IconsButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    FlutterBarcodeScanner
                        .scanBarcode(
                        "#ff6666",
                        "Cancel",
                        true,
                        ScanMode.DEFAULT)
                        ?.then((barcode) {
                      Dialogs.materialDialog(
                          msg: barcode.toString(),
                          title: 'Scanned code',
                          titleAlign:
                          TextAlign.center,
                          color: Colors.white,
                          context: context,
                          actions: [
                            IconsButton(
                              onPressed: () async {
                                Navigator.pop(
                                    context);
                              },
                              text: 'Cancel',
                              color: themeController
                                  .currentTheme
                                  .value
                                  .cardColor,
                              textStyle:
                              const TextStyle(
                                  color:
                                  primaryColor),
                              iconColor:
                              primaryColor,
                            ),
                            IconsButton(
                              onPressed: () async {
                                Navigator.pop(
                                    context);
                                _quotationController
                                    .sendDeliveredCode(
                                    context,
                                    barcode.toString(),
                                    widget.orderId,
                                    widget.senderId);
                              },
                              text: 'Submit',
                              iconData: Icons
                                  .document_scanner,
                              color: primaryColor,
                              textStyle:
                              const TextStyle(
                                  color: Colors
                                      .white),
                              iconColor:
                              Colors.white,
                            ),
                          ]);
                      // Get.to(() => DispatchScanner(
                      //     orderId:
                      //         _quotationController
                      //             .orderId,
                      //     barcode: barcode));
                    });
                  },
                  text: 'Scan',
                  iconData: Icons.document_scanner,
                  color: primaryColor,
                  textStyle: const TextStyle(
                      color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
        },
        title: 'Scan the parcel',
        txtColor: Colors.white,
        btnColor: primaryColor);
  }
}
