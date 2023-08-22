import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/quotation_controller.dart';
import '../../util/widgets/text_field.dart';
import 'add_quotation_screen.dart';

class EditQuotationScreen extends StatefulWidget {
  const EditQuotationScreen(
      {Key? key,
      required this.productName,
      required this.price,
      required this.store,
      required this.quantity,
      required this.weight,
      required this.width,
      required this.height,
      required this.description, required this.index, required this.productID})
      : super(key: key);

  final String productName;
  final String productID;
  final String price;
  final String store;
  final String quantity;
  final String weight;
  final String width;
  final String height;
  final String description;
  final int index;

  @override
  State<EditQuotationScreen> createState() => _EditQuotationScreenState();
}

class _EditQuotationScreenState extends State<EditQuotationScreen> {
  final QuotationController _quotationController =
  Get.put(QuotationController());
  final _productName = TextEditingController();
  final _price = TextEditingController();
  final _storeLocation = TextEditingController();
  final _quantity = TextEditingController();
  final _weight = TextEditingController();
  final _width = TextEditingController();
  final _height = TextEditingController();
  final _productDescription = TextEditingController();
  XFile? _video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    'Edit order',
                    style:
                        themeController.currentTheme.value.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickVideo(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        final videoBytes = await pickedFile.readAsBytes();
                        final videoSizeInBytes = videoBytes.length;
                        final videoSizeInMB = videoSizeInBytes /
                            (1024 * 1024); // Convert bytes to MB

                        if (videoSizeInMB <= 10) {
                          setState(() {
                            _video = pickedFile;
                          });
                        } else {
                          setState(() {
                            _video.isBlank;
                          });
                          Fluttertoast.showToast(
                            msg: 'Video is greater than 10 MB',
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.red,
                          );
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
                            'Edit video [Less than 10 MB]',
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
                      hintText: widget.productName),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _price,
                      title: 'Price',
                      icon: const SuffixText(
                        text: 'in USD',
                      ),
                      fieldLabel: '',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: widget.price),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _storeLocation,
                      title: 'Store Location',
                      icon: const SizedBox(),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.streetAddress,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: widget.store),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _quantity,
                      title: 'Quantity',
                      icon: const SizedBox(),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.number,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: widget.quantity),
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
                      hintText: widget.weight),
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
                      hintText: widget.width),
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
                      hintText: widget.height),
                  SizedBox(height: screenHeight(context) * .015),
                  CustomTextField(
                      cont: _productDescription,
                      title: 'Product Description',
                      icon: const SizedBox(),
                      fieldLabel: 'This field',
                      keyboard: TextInputType.text,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: widget.description),
                  SizedBox(height: screenHeight(context) * .015),
                  ElevatedButton(
                    onPressed: () {
                        loadingController.updateLoading(true);
                        if(_video.isNull){
                          _quotationController.editQuotation(
                              context,
                              _productName.text,
                              _storeLocation.text,
                              _price.text,
                              _quantity.text,
                              _weight.text,
                              _width.text,
                              _height.text,
                              _productDescription.text, widget.index, widget.productID);
                        } else {_quotationController.editQuotationWithVideo(
                            context,
                            _productName.text,
                            _storeLocation.text,
                            _price.text,
                            _quantity.text,
                            _weight.text,
                            _width.text,
                            _height.text,
                            _productDescription.text,
                            _video, widget.index,widget.productID);
                        }
                    },
                    child: const Text(
                      'Edit',
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
        ],
      ),
    );
  }
}
