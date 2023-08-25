import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/screen/quotation/full_video_screen.dart';
import 'package:savo/util/widgets/login_button.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';

class QuotationDetailScreen extends StatefulWidget {
  const QuotationDetailScreen(
      {super.key,
      required this.productId,
      required this.productName,
      required this.description,
      required this.store,
      required this.weight,
      required this.height,
      required this.width,
      required this.price,
      required this.quantity,
      required this.video});

  final String productId;
  final String productName;
  final String description;
  final String store;
  final String weight;
  final String height;
  final String width;
  final String price;
  final String quantity;
  final String video;

  @override
  State<QuotationDetailScreen> createState() => _QuotationDetailScreenState();
}

class _QuotationDetailScreenState extends State<QuotationDetailScreen> {
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
        // width: screenWidth(context),
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
              Text(
                'Store Location',
                style: themeController.currentTheme.value.textTheme.bodyLarge,
                textAlign: TextAlign.justify,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
              LoginButton(
                  onTap: () {},
                  title: 'Send',
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
