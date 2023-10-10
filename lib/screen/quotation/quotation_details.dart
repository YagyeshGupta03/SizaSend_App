// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/quotation/full_video_screen.dart';
import 'package:savo/screen/quotation/quotatiion_invoice_screen.dart';
import 'package:savo/screen/quotation/quotation_detail_screen_for_pay.dart';
import 'package:savo/util/widgets/dispatch_button.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/walllet_controller.dart';
import '../../util/widgets/widget.dart';
import '../WalletScreens/add_total_money_screen.dart';
import '../WalletScreens/refund_screen.dart';
import '../dashboard_screen.dart';
import '../pdf_view.dart';

class QuotationDetailScreen extends StatefulWidget {
  const QuotationDetailScreen({super.key});

  @override
  State<QuotationDetailScreen> createState() => _QuotationDetailScreenState();
}

class _QuotationDetailScreenState extends State<QuotationDetailScreen> {
  final QuotationController _quotationController =
      Get.put(QuotationController());
  final WalletController _walletController = Get.put(WalletController());

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
                                : _quotationController.orderStatus ==
                                            'complete' ||
                                        _quotationController.orderStatus ==
                                            'refund'
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
                                                          .itemCost,
                                                    );
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
                    _quotationController.orderStatus == 'refund'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reason to refund',
                                style: themeController
                                    .currentTheme.value.textTheme.bodyLarge,
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                _quotationController.reason,
                                style: themeController
                                    .currentTheme.value.textTheme.displayMedium,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 30),
                    _quotationController.orderStatus == 'complete'
                        ? LoginButton(
                            onTap: () {
                              _quotationController
                                  .getQuotationInvoice(
                                      _quotationController.orderId)
                                  .whenComplete(() => Get.to(
                                      () => const InvoiceScreen()));
                            },
                            title: 'View Invoice',
                            txtColor: Colors.white,
                            btnColor: primaryColor)
                        : const SizedBox(),
                    const SizedBox(height: 30),
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
}

//
//
//
//
//
//
//
//
class StoreLocation extends StatelessWidget {
  const StoreLocation({
    super.key,
    required QuotationController quotationController,
  }) : _quotationController = quotationController;

  final QuotationController _quotationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Collection',
              style: themeController.currentTheme.value.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _quotationController.store,
          style: themeController.currentTheme.value.textTheme.displayMedium,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          width: screenWidth(context),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

class OtherInformation extends StatelessWidget {
  const OtherInformation({
    super.key,
    required QuotationController quotationController,
  }) : _quotationController = quotationController;

  final QuotationController _quotationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information',
          style: themeController.currentTheme.value.textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoColumn(
                  title: 'Quantity', value: _quotationController.quantity),
              InfoColumn(title: 'Length', value: '${_quotationController.length} cm'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoColumn(title: 'Weight', value: _quotationController.weight),
              InfoColumn(
                  title: 'Height x width',
                  value:
                      '${_quotationController.height} cm x ${_quotationController.width} cm'),
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    super.key,
    required QuotationController quotationController,
  }) : _quotationController = quotationController;

  final QuotationController _quotationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Total payment',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        TotalAmountTile(
            value: convertToCurrency(_quotationController.itemCost),
            title: 'Cost of item'),
        TotalAmountTile(
            value: convertToCurrency(_quotationController.courierCharges),
            title: 'Courier charges'),
        TotalAmountTile(
            value: convertToCurrency(_quotationController.adminCharges),
            title: 'Sizasend charges'),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 10),
        TotalAmountTile(
            value: convertToCurrency(_quotationController.price),
            title: 'Total payment'),
      ],
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
    final QuotationController quotationController =
        Get.put(QuotationController());

    return Column(
      children: [
        LoginButton(
            onTap: () {
              Dialogs.materialDialog(
                  msg: 'Do you want to accept this quotation?',
                  msgAlign: TextAlign.center,
                  title: "Accept",
                  color: Colors.white,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle: const TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () async {
                        await quotationController.sendQuotationStatus(
                            orderId, senderId, 'accept');
                        quotationController
                            .getQuotationByOrderId(orderId)
                            .whenComplete(() => Get.to(
                                () => const QuotationDetailScreenForPay()));
                        Navigator.pop(context);
                      },
                      text: 'Accept',
                      color: primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]);
            },
            title: 'Accept',
            txtColor: Colors.white,
            btnColor: primaryColor),
        const SizedBox(height: 5),
        LoginButton(
            onTap: () {
              Dialogs.materialDialog(
                  msg: 'Do you want to reject this quotation?',
                  msgAlign: TextAlign.center,
                  title: "Reject",
                  color: Colors.white,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle: const TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () async {
                        await quotationController.sendQuotationStatus(
                            orderId, senderId, 'reject');
                        quotationController
                            .getQuotationByOrderId(orderId)
                            .whenComplete(() => Get.to(
                                () => const QuotationDetailScreenForPay()));
                        Navigator.pop(context);
                      },
                      text: 'Reject',
                      color: primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]);
            },
            title: 'Reject',
            txtColor: primaryColor,
            btnColor: themeController.currentTheme.value.cardColor),
      ],
    );
  }
}

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

class RefundButton extends StatelessWidget {
  const RefundButton({
    super.key,
    required this.orderId,
    required this.senderId,
  });

  final String orderId;
  final String senderId;

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());

    return Column(
      children: [
        LoginButton(
            onTap: () {
              Dialogs.materialDialog(
                  msg: 'Do you want to accept this parcel?',
                  msgAlign: TextAlign.center,
                  title: "Accept Parcel",
                  color: Colors.white,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle: const TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () async {
                        walletController.completeOrderPayment(
                            context, orderId, 'complete', senderId, '');
                        Navigator.pop(context);
                      },
                      text: 'Accept',
                      color: primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]);
            },
            title: 'Accept parcel',
            txtColor: Colors.white,
            btnColor: primaryColor),
        const SizedBox(height: 5),
        LoginButton(
            onTap: () {
              Dialogs.materialDialog(
                  msg: 'Do you want to reject this parcel?',
                  msgAlign: TextAlign.center,
                  title: "Reject parcel",
                  color: Colors.white,
                  context: context,
                  actions: [
                    IconsOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      textStyle: const TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        Get.to(() => const RefundScreen());
                      },
                      text: 'Reject',
                      color: primaryColor,
                      textStyle: const TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]);
            },
            title: 'Reject parcel',
            txtColor: primaryColor,
            btnColor: themeController.currentTheme.value.cardColor),
      ],
    );
  }
}
