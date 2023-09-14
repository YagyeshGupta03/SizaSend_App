import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/walllet_controller.dart';
import '../../util/widgets/login_button.dart';
import 'full_video_screen.dart';

class QuotationDetailForNotification extends StatefulWidget {
  const QuotationDetailForNotification({super.key});

  @override
  State<QuotationDetailForNotification> createState() =>
      _QuotationDetailForNotificationState();
}

class _QuotationDetailForNotificationState
    extends State<QuotationDetailForNotification> {
  final WalletController _walletController = Get.put(WalletController());
  final QuotationController _quotationController =
      Get.put(QuotationController());
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            color: themeController.currentTheme.value.cardColor,
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
                                    Get.to(() => VideoApp(
                                        video: _quotationController.video));
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
                  _quotationController.productName,
                  style:
                      themeController.currentTheme.value.textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '${_quotationController.price} USD',
                  style: const TextStyle(fontSize: 15, color: primaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _quotationController.description,
              style: themeController.currentTheme.value.textTheme.displayMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Store Location',
                  style: themeController.currentTheme.value.textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(width: 10),
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
                      InfoColumn(
                          title: 'Quantity',
                          value: _quotationController.quantity),
                      InfoColumn(
                          title: 'Price', value: _quotationController.price),
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
                          title: 'Weight', value: _quotationController.weight),
                      InfoColumn(
                          title: 'Size',
                          value:
                              '${_quotationController.height} cm x ${_quotationController.width} cm'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                LoginButton(
                    onTap: () {
                      _walletController.quotationPay(
                          _quotationController.price,
                          _quotationController.senderId,
                          _quotationController.orderId);
                    },
                    title: 'Pay',
                    txtColor: Colors.white,
                    btnColor: primaryColor)
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
