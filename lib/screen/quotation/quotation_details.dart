// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import 'package:savo/screen/quotation/full_video_screen.dart';
import 'package:savo/screen/quotation/quotation_detail_screen_for_pay.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';

class QuotationDetailScreen extends StatefulWidget {
  const QuotationDetailScreen({super.key});

  @override
  State<QuotationDetailScreen> createState() => _QuotationDetailScreenState();
}

class _QuotationDetailScreenState extends State<QuotationDetailScreen> {
  final WalletController _walletController = Get.put(WalletController());
  final QuotationController _quotationController =
      Get.put(QuotationController());

  XFile? _senderImage;
  XFile? _receiverImage;
  late VideoPlayerController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network('$videoUrl${_quotationController.video}')
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Quotation Details',
            style: themeController.currentTheme.value.textTheme.bodyLarge,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          _controller.value.isInitialized
                              ? Container(
                                  height: 200,
                                  width: screenWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  width: screenWidth(context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: themeController
                                        .currentTheme.value.cardColor,
                                  ),
                                  child: Center(
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                      color: primaryColor,
                                      size: 50,
                                    ),
                                  ),
                                ),
                          _controller.value.isBuffering
                              ? const SizedBox()
                              : _controller.value.isPlaying
                                  ? const SizedBox()
                                  : Container(
                                      height: 200,
                                      width: screenWidth(context),
                                      color: Colors.black38,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            Get.to(() => VideoApp(
                                                video: _quotationController
                                                    .video));
                                          },
                                          icon: Icon(
                                            Icons.play_circle,
                                            color: themeController
                                                .currentTheme.value.cardColor,
                                            size: 54,
                                          ),
                                        ),
                                      ),
                                    ),
                          _controller.value.isBuffering
                              ? Container(
                                  height: 200,
                                  width: screenWidth(context),
                                  color: Colors.transparent,
                                  child: Center(
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                      color: primaryColor,
                                      size: 50,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _quotationController.productName,
                          style: themeController
                              .currentTheme.value.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          '${_quotationController.price} USD',
                          style: const TextStyle(
                              fontSize: 15, color: primaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _quotationController.description,
                      style: themeController
                          .currentTheme.value.textTheme.displayMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: themeController
                              .currentTheme.value.textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _quotationController.store,
                      style: themeController
                          .currentTheme.value.textTheme.displayMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 150,
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/images/map.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Text(
                      'Information',
                      style: themeController
                          .currentTheme.value.textTheme.bodyLarge,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoColumn(
                              title: 'Quantity',
                              value: _quotationController.quantity),
                          InfoColumn(
                              title: 'Price',
                              value: _quotationController.price),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoColumn(
                              title: 'Weight',
                              value: _quotationController.weight),
                          InfoColumn(
                              title: 'Size',
                              value:
                                  '${_quotationController.height} cm x ${_quotationController.width} cm'),
                        ],
                      ),
                    ),
                    _quotationController.image != ''
                        ? Column(
                            children: [
                              const SizedBox(height: 35),
                              Text('Order Dispatched',
                                  style: themeController
                                      .currentTheme.value.textTheme.bodyLarge),
                              const SizedBox(height: 15),
                              Container(
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 150,
                                child: Image.network(
                                    '$orderImageUrl${_quotationController.image}',
                                    fit: BoxFit.fill),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 40),
                    // to check if sender
                    _quotationController.senderId == credentialController.id
                        //to check by sender if paid
                        ? _quotationController.orderStatus == 'unpaid'
                            ? const SizedBox()
                            : _quotationController.orderStatus == 'dispatch'
                                ? const SizedBox()
                                : LoginButton(
                                    onTap: () async {
                                      Dialogs.materialDialog(
                                          msg: 'Take a picture of parcel',
                                          title: "Dispatch",
                                          titleAlign: TextAlign.center,
                                          color: Colors.white,
                                          context: context,
                                          actions: [
                                            IconsButton(
                                              onPressed: () async {
                                                final picker = ImagePicker();
                                                final pickedFile =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {
                                                  _senderImage = pickedFile;
                                                });
                                                _quotationController
                                                    .sendDispatchImage(
                                                        context,
                                                        _senderImage,
                                                        _quotationController
                                                            .orderId);
                                                Navigator.pop(context);
                                              },
                                              text: 'Camera',
                                              iconData:
                                                  Icons.camera_alt_outlined,
                                              color: primaryColor,
                                              textStyle: const TextStyle(
                                                  color: Colors.white),
                                              iconColor: Colors.white,
                                            ),
                                          ]);
                                    },
                                    title: 'Dispatch',
                                    txtColor: Colors.white,
                                    btnColor: primaryColor)
                        // to check by receiver to pay or track
                        : _quotationController.status == ''
                            ? CompleteOrderButtons(
                                orderId: _quotationController.orderId,
                                senderId: _quotationController.senderId)
                            : _quotationController.status == 'reject'
                                ? const SizedBox()
                                : _quotationController.orderStatus == 'unpaid'
                                    ? LoginButton(
                                        onTap: () {
                                          _walletController.quotationPay(
                                              _quotationController.price,
                                              _quotationController.senderId,
                                              _quotationController.orderId,
                                              _quotationController.productName);
                                        },
                                        title: 'Pay',
                                        txtColor: Colors.white,
                                        btnColor: primaryColor)
                                    // to check by receiver to accept or reject
                                    : _quotationController.orderStatus ==
                                            'dispatch'
                                        ? LoginButton(
                                            onTap: () async {
                                              Dialogs.materialDialog(
                                                  msg:
                                                      'Take a picture of parcel',
                                                  title: "Delivered",
                                                  color: Colors.white,
                                                  titleAlign: TextAlign.center,
                                                  context: context,
                                                  actions: [
                                                    IconsButton(
                                                      onPressed: () async {
                                                        final picker =
                                                            ImagePicker();
                                                        final pickedFile =
                                                            await picker.pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                        setState(() {
                                                          _receiverImage =
                                                              pickedFile;
                                                          _quotationController
                                                              .sendDeliveredImage(
                                                                  context,
                                                                  _receiverImage,
                                                                  _quotationController
                                                                      .orderId,
                                                                  _quotationController
                                                                      .senderId);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      text: 'Camera',
                                                      iconData: Icons
                                                          .camera_alt_outlined,
                                                      color: primaryColor,
                                                      textStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      iconColor: Colors.white,
                                                    ),
                                                  ]);
                                            },
                                            title: 'Delivered',
                                            txtColor: Colors.white,
                                            btnColor: primaryColor)
                                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            _quotationController.orderStatus == 'unpaid'
                ? Obx(
                    () => loadingController.loading.value
                        ? Center(
                            child: Container(
                              height: screenHeight(context),
                              width: screenWidth(context),
                              color: Colors.black12,
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: primaryColor,
                                size: 50,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  )
                : Obx(
                    () => loadingController.dispatchLoad.value
                        ? Center(
                            child: Container(
                              height: screenHeight(context),
                              width: screenWidth(context),
                              color: Colors.black12,
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: primaryColor,
                                size: 50,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
          ],
        ));
  }

  void _showAlertBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('This is a simple dialog box.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class CompleteOrderButtons extends StatelessWidget {
  const CompleteOrderButtons({
    super.key,
    required this.orderId,
    required this.senderId,
  });

  final String orderId;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    final QuotationController _quotationController =
        Get.put(QuotationController());

    return Column(
      children: [
        LoginButton(
            onTap: () async {
              await _quotationController.sendQuotationStatus(
                  orderId, senderId, 'accept');
              _quotationController.getQuotationByOrderId(orderId).whenComplete(
                  () => Get.to(() => const QuotationDetailScreenForPay()));
            },
            title: 'Accept',
            txtColor: Colors.white,
            btnColor: primaryColor),
        const SizedBox(height: 5),
        LoginButton(
            onTap: () async {
              await _quotationController.sendQuotationStatus(
                  orderId, senderId, 'reject');
              _quotationController.getQuotationByOrderId(orderId).whenComplete(
                  () => Get.to(() => const QuotationDetailScreenForPay()));
            },
            title: 'Reject',
            txtColor: primaryColor,
            btnColor: themeController.currentTheme.value.cardColor),
      ],
    );
  }
}

//
//
//
//
class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context) / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: themeController.currentTheme.value.textTheme.displayMedium,
              textAlign: TextAlign.justify),
          const SizedBox(height: 5),
          Text(
            value,
            style: themeController.currentTheme.value.textTheme.titleSmall,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
