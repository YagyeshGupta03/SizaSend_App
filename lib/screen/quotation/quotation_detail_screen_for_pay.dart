// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/quotation/full_video_screen.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../util/widgets/dispatch_button.dart';
import '../../util/widgets/widget.dart';
import 'quotation_details.dart';

class QuotationDetailScreenForPay extends StatefulWidget {
  const QuotationDetailScreenForPay({super.key});

  @override
  State<QuotationDetailScreenForPay> createState() =>
      _QuotationDetailScreenForPayState();
}

class _QuotationDetailScreenForPayState
    extends State<QuotationDetailScreenForPay> {
  final WalletController _walletController = Get.put(WalletController());
  final QuotationController _quotationController =
      Get.put(QuotationController());

  String dispatchCode = '';
  String deliverCode = '';
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    Uri videoUri = Uri.parse('$videoUrl${_quotationController.video}');
    _controller = VideoPlayerController.networkUrl(videoUri)
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
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              loadingController.updateDispatchLoading(false);
              loadingController.updateVideoCompressionLoading(false);
              loadingController.updateLoading(false);
              loadingController.updateProfileLoading(false);
              Get.to(() => const DashBoardScreen());
            },
            icon: Icon(
              Icons.arrow_back,
              color: themeController.currentTheme.value.iconTheme.color,
            ),
          ),
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
                              ? Stack(children: [
                                  Container(
                                    height: 200,
                                    width: screenWidth(context),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
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
                                  )
                                ])
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _quotationController.senderId == credentialController.id
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sent to',
                                style: themeController
                                    .currentTheme.value.textTheme.displayMedium,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _quotationController.receiverName,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sent by',
                                style: themeController
                                    .currentTheme.value.textTheme.displayMedium,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _quotationController.senderName,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor),
                                textAlign: TextAlign.justify,
                              ),
                            ],
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
                          convertToCurrency(_quotationController.price),
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
                    StoreLocation(quotationController: _quotationController),
                    const SizedBox(height: 35),
                    OtherInformation(quotationController: _quotationController),
                    const SizedBox(height: 40),
                    PaymentDetails(quotationController: _quotationController),
                    const SizedBox(height: 40),
                    // to check if sender
                    _quotationController.senderId == credentialController.id
                        //to check by sender if paid
                        ? _quotationController.orderStatus == 'unpaid'
                            ? const SizedBox()
                            : _quotationController.orderStatus == 'dispatch'
                                ? const SizedBox()
                                : DispatchButton(
                                    orderId: _quotationController.orderId)
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
                                          Dialogs.materialDialog(
                                              msg:
                                                  'Do you want to pay for this quotation?',
                                              msgAlign: TextAlign.center,
                                              title: "Pay",
                                              color: Colors.white,
                                              titleAlign: TextAlign.center,
                                              context: context,
                                              actions: [
                                                IconsOutlineButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: 'Cancel',
                                                  iconData:
                                                      Icons.cancel_outlined,
                                                  textStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  iconColor: Colors.grey,
                                                ),
                                                IconsButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    _walletController
                                                        .quotationPay(
                                                            _quotationController
                                                                .price,
                                                            _quotationController
                                                                .senderId,
                                                            _quotationController
                                                                .orderId,
                                                            _quotationController
                                                                .productName,
                                                            _quotationController
                                                                .courierCharges,
                                                            _quotationController
                                                                .itemCost);
                                                  },
                                                  text: 'Pay',
                                                  color: primaryColor,
                                                  textStyle: const TextStyle(
                                                      color: Colors.white),
                                                  iconColor: Colors.white,
                                                ),
                                              ]);
                                        },
                                        title: 'Pay',
                                        txtColor: Colors.white,
                                        btnColor: primaryColor)
                                    // to check by receiver to accept or reject
                                    : _quotationController.orderStatus ==
                                            'dispatch'
                                        ? _quotationController.deliveredCode ==
                                                ''
                                            ? DeliveryButton(
                                                orderId: _quotationController
                                                    .orderId,
                                                senderId: _quotationController
                                                    .senderId)
                                            : RefundButton(
                                                orderId: _quotationController
                                                    .orderId,
                                                senderId: _quotationController
                                                    .senderId)
                                        : const SizedBox(),
                    const SizedBox(height: 30),
                    _quotationController.orderStatus == 'unpaid' ||
                        _quotationController.orderStatus == 'paid'
                        ? LoginButton(
                        onTap: () {
                          Dialogs.materialDialog(
                              msg:
                              'Do you want to cancel this quotation?',
                              title: "Cancel",
                              msgAlign: TextAlign.center,
                              color: Colors.white,
                              context: context,
                              actions: [
                                IconsOutlineButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'No',
                                  iconData: Icons.cancel_outlined,
                                  textStyle: const TextStyle(
                                      color: primaryColor),
                                  iconColor: primaryColor,
                                ),
                                IconsButton(
                                  onPressed: () {
                                    _quotationController
                                        .deleteQuotation(
                                        context,
                                        _quotationController
                                            .orderId);
                                  },
                                  text: 'Yes',
                                  iconData: Icons.check_circle_outline_outlined,
                                  color: primaryColor,
                                  textStyle: const TextStyle(
                                      color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              ]);
                        },
                        title: 'Cancel the quotation',
                        btnColor: Colors.white,
                        txtColor: primaryColor)
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            Obx(
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
}
