import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/home/home_screen.dart';
import 'package:savo/screen/quotation/full_video_screen.dart';
import 'package:savo/screen/quotation/track_screen.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';

class QuotationDetailScreen extends StatefulWidget {
  const QuotationDetailScreen(
      {super.key,
      required this.productName,
      required this.orderId,
      required this.description,
      required this.store,
      required this.weight,
      required this.height,
      required this.width,
      required this.status,
      required this.price,
      required this.senderId,
      required this.quantity,
      required this.video});

  final String productName;
  final String orderId;
  final String description;
  final String store;
  final String weight;
  final String status;
  final String height;
  final String width;
  final String price;
  final String quantity;
  final String senderId;
  final String video;

  @override
  State<QuotationDetailScreen> createState() => _QuotationDetailScreenState();
}

class _QuotationDetailScreenState extends State<QuotationDetailScreen> {
  final WalletController _walletController = Get.put(WalletController());
  late VideoPlayerController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('$videoUrl${widget.video}')
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                              color:
                                  themeController.currentTheme.value.cardColor,
                            ),
                            child: Center(
                              child: LoadingAnimationWidget.threeArchedCircle(
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
                                      Get.to(
                                          () => VideoApp(video: widget.video));
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
                              child: LoadingAnimationWidget.threeArchedCircle(
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
                    widget.productName,
                    style:
                        themeController.currentTheme.value.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '${widget.price} USD',
                    style: const TextStyle(fontSize: 15, color: primaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style:
                    themeController.currentTheme.value.textTheme.displayMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Store Location',
                    style:
                        themeController.currentTheme.value.textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(width: 10),
                  widget.status == 'reached'
                      ? const Text(
                          '[Delivered]',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.store,
                style:
                    themeController.currentTheme.value.textTheme.displayMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8),
              Container(
                height: 150,
                width: screenWidth(context),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 35),
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
                    InfoColumn(title: 'Quantity', value: widget.quantity),
                    InfoColumn(title: 'Price', value: widget.price),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoColumn(title: 'Weight', value: widget.weight),
                    InfoColumn(
                        title: 'Size',
                        value: '${widget.height} cm x ${widget.width} cm'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // to check if sender
              widget.senderId == credentialController.id
                  //to check by sender if paid
                  ? widget.status == 'unpaid'
                      ? const SizedBox()
                      // to check by sender to deliver
                      : widget.status == 'dispatch'
                          ? LoginButton(
                              onTap: () {
                                _walletController
                                    .updatePaidStatus(widget.orderId, 'reached')
                                    .then((value) =>
                                        Get.to(() => const DashBoardScreen()));
                              },
                              title: 'Delivered',
                              txtColor: Colors.white,
                              btnColor: primaryColor)
                          // to check by sender to deliver
                          : widget.status == 'reached'
                              ? const SizedBox()
                              : LoginButton(
                                  onTap: () {
                                    _walletController
                                        .updatePaidStatus(
                                            widget.orderId, 'dispatch')
                                        .then((value) => Get.to(
                                            () => const DashBoardScreen()));
                                  },
                                  title: 'Dispatch',
                                  txtColor: Colors.white,
                                  btnColor: primaryColor)
                  // to check by receiver to pay or track
                  : widget.status == 'unpaid'
                      ? LoginButton(
                          onTap: () {
                            _walletController.quotationPay(
                                widget.price, widget.senderId, widget.orderId);
                          },
                          title: 'Pay',
                          txtColor: Colors.white,
                          btnColor: primaryColor)
                      // to check by receiver to accept or reject
                      : widget.status == 'reached'
                          ? CompleteOrderButtons(
                              orderId: widget.orderId,
                              senderId: widget.senderId)
                          : LoginButton(
                              onTap: () {
                                Get.to(
                                    () => TrackScreen(status: widget.status));
                              },
                              title: 'Track',
                              txtColor: Colors.white,
                              btnColor: primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  //
  //
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
    final WalletController _walletController = Get.put(WalletController());
    return Column(
      children: [
        LoginButton(
            onTap: () {
              _walletController.completeOrderPayment(
                  orderId, 'complete', senderId);
            },
            title: 'Accept',
            txtColor: Colors.white,
            btnColor: primaryColor),
        const SizedBox(height: 5),
        LoginButton(
            onTap: () {
              _walletController.completeOrderPayment(
                  orderId, 'refund', senderId);
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
