import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:video_compress/video_compress.dart';
import '../../Constants/all_urls.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/contact_controllers.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';
import '../../util/widgets/text_field.dart';

class AddQuotationScreen extends StatefulWidget {
  const AddQuotationScreen({Key? key}) : super(key: key);

  @override
  State<AddQuotationScreen> createState() => _AddQuotationScreenState();
}

class _AddQuotationScreenState extends State<AddQuotationScreen> {
  final QuotationController _quotationController =
      Get.put(QuotationController());
  final ContactController _contactController = Get.put(ContactController());

  final _productName = TextEditingController();
  final _storeLocation = TextEditingController();
  final _quantity = TextEditingController();
  final _weight = TextEditingController();
  final _width = TextEditingController();
  final _height = TextEditingController();
  final _productDescription = TextEditingController();
  final _searchBar = TextEditingController();
  XFile? _video;

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            loadingController.updateLoading(false);
            loadingController.updateVideoCompressionLoading(false);
            loadingController.updateDispatchLoading(false);
            Get.to(()=>const DashBoardScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Create order',
                    style:
                        themeController.currentTheme.value.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fill all the details to complete order',
                    style: themeController
                        .currentTheme.value.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickVideo(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        final videoFile = File(pickedFile.path);
                        final videoSizeInBytes = await videoFile.length();
                        final videoSizeInMB = videoSizeInBytes /
                            (1024 * 1024); // Convert bytes to MB

                        if (videoSizeInMB <= 10) {
                          loadingController.updateVideoCompressionLoading(true);
                          setState(() {
                            _video = pickedFile;
                          });
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Video is greater than 10 MB',
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.red,
                          );
                          return; // Do not proceed with compression if the video is too large
                        }

                        // Compress the video if needed
                        if (videoSizeInMB > 2) {
                          final info = await VideoCompress.compressVideo(
                            pickedFile.path,
                            quality: VideoQuality
                                .Res640x480Quality, // You can adjust the quality
                          );

                          if (info != null) {
                            final compressedFilePath = info.path;
                            if (compressedFilePath != null) {
                              final compressedFile = File(compressedFilePath);
                              final compressedFileSizeInBytes =
                                  await compressedFile.length();

                              if (compressedFileSizeInBytes <
                                  videoSizeInBytes) {
                                loadingController
                                    .updateVideoCompressionLoading(false);
                                // Compression was successful
                                setState(() {
                                  _video = XFile(compressedFilePath);
                                });
                              }
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                      height: 120,
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library,
                            size: 32,
                            color: themeController
                                .currentTheme.value.iconTheme.color,
                          ),
                          Text(
                            'Upload video [Less than 10 MB]',
                            style: themeController
                                .currentTheme.value.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                      cont: _productName,
                      title: 'Product Name',
                      icon: const SizedBox(),
                      fieldLabel: 'name',
                      keyboard: TextInputType.name,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _storeLocation,
                      title: 'Store Location',
                      icon: const SizedBox(),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.streetAddress,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _quantity,
                      title: 'Quantity',
                      icon: const SizedBox(),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _weight,
                      title: 'Weight',
                      icon: const SuffixText(
                        text: 'in kg',
                      ),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _width,
                      title: 'Width',
                      icon: const SuffixText(
                        text: 'in cms',
                      ),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _height,
                      title: 'Height',
                      icon: const SuffixText(
                        text: 'in cms',
                      ),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _productDescription,
                      title: 'Product Description',
                      icon: const SizedBox(),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.text,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  SizedBox(height: screenHeight(context) * .015),
                  ElevatedButton(
                    onPressed: () async {
                      if (_productName.text.isNotEmpty &&
                          _storeLocation.text.isNotEmpty &&
                          _quantity.text.isNotEmpty &&
                          _weight.text.isNotEmpty &&
                          _width.text.isNotEmpty &&
                          _height.text.isNotEmpty &&
                          _productDescription.text.isNotEmpty &&
                          _video != null) {
                        _showBottomSheet(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).kindlyFillAllTheFields,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
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
          ),
          Obx(
            () => loadingController.videoCompressionLoad.value
                ? Center(
                    child: Container(
                      height: screenHeight(context),
                      width: screenWidth(context),
                      color: Colors.black12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.threeArchedCircle(
                            color: primaryColor,
                            size: 50,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Compressing video',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          expand: false,
          builder: (context, scrollController) {
            return Stack(
              children: [
                Container(
                  color: themeController
                      .currentTheme.value.scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _searchBar,
                          style: themeController
                              .currentTheme.value.textTheme.displaySmall,
                          onFieldSubmitted: (val) {
                            _quotationController.getSearchData(val);
                          },
                          decoration: InputDecoration(
                            hintText: 'Name or phone number',
                            border: InputBorder.none,
                            hoverColor: Colors.transparent,
                            hintStyle: themeController
                                .currentTheme.value.textTheme.displaySmall,
                            filled: true,
                            fillColor:
                                themeController.currentTheme.value.cardColor,
                            focusColor: Colors.transparent,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 15, right: 10, bottom: 0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Obx(
                            () => _quotationController.searchList.length
                                    .isEqual(0)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      Text('No user',
                                          style: themeController.currentTheme
                                              .value.textTheme.titleSmall),
                                    ],
                                  )
                                : ListView.builder(
                                    controller: scrollController,
                                    itemCount:
                                        _quotationController.searchList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          _quotationController.addQuotation(
                                              context,
                                              _productName.text,
                                              _storeLocation.text,
                                              _quantity.text,
                                              _weight.text,
                                              _width.text,
                                              _height.text,
                                              _productDescription.text,
                                              _video,
                                              _quotationController
                                                  .searchList[index].userId);
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                              child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: _quotationController
                                                            .searchList[index]
                                                            .image ==
                                                        ''
                                                    ? Image.asset(
                                                        'assets/images/profilePic.jpg',
                                                        fit: BoxFit.cover)
                                                    : Image.network(
                                                        '$imageUrl${_quotationController.searchList[index].image}',
                                                        fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                              _quotationController
                                                  .searchList[index].fullName,
                                              style: themeController
                                                  .currentTheme
                                                  .value
                                                  .textTheme
                                                  .bodyLarge),
                                          subtitle: Text(
                                              '${_quotationController.searchList[index].countryCode}${_quotationController.searchList[index].phone}',
                                              style: themeController
                                                  .currentTheme
                                                  .value
                                                  .textTheme
                                                  .displayMedium),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Text('Your contacts',
                            style: themeController
                                .currentTheme.value.textTheme.bodyLarge),
                        const SizedBox(height: 20),
                        _contactController.connectedContactListing.length
                                .isEqual(0)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('No contacts available',
                                      style: themeController.currentTheme.value
                                          .textTheme.titleSmall)
                                ],
                              )
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: _contactController
                                    .connectedContactListing.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      _quotationController.addQuotation(
                                          context,
                                          _productName.text,
                                          _storeLocation.text,
                                          _quantity.text,
                                          _weight.text,
                                          _width.text,
                                          _height.text,
                                          _productDescription.text,
                                          _video,
                                          _contactController
                                              .connectedContactListing[index]
                                              .userId);
                                    },
                                    child: ListTile(
                                      title: Text(
                                          _contactController
                                              .connectedContactListing[index]
                                              .fullName,
                                          style: themeController.currentTheme
                                              .value.textTheme.titleSmall),
                                      // subtitle: Text(_contactController
                                      //     .connectedContactListing[index].phone),
                                      leading: CircleAvatar(
                                        radius: 20,
                                        child: ClipOval(
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: _contactController
                                                        .connectedContactListing[
                                                            index]
                                                        .image ==
                                                    ''
                                                ? Image.asset(
                                                    'assets/images/profilePic.jpg',
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    '$imageUrl${_contactController.connectedContactListing[index].image}',
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                      ],
                    ),
                  ),
                ),
                Obx(() => loadingController.loading.value
                    ? Container(
                        height: screenHeight(context),
                        width: screenWidth(context),
                        color: Colors.black26,
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: LoadingAnimationWidget.stretchedDots(
                            color: primaryColor,
                            size: 60,
                          ),
                        ),
                      )
                    : const SizedBox()),
              ],
            );
          },
        );
      },
    );
  }
}

//
//
//
//
//
class SuffixText extends StatelessWidget {
  const SuffixText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: themeController.currentTheme.value.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
