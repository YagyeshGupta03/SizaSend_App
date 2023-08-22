import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import '../../Constants/sizes.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';
import '../../util/widgets/text_field.dart';

class AddQuotationScreen extends StatefulWidget {
  const AddQuotationScreen({Key? key, required this.edit}) : super(key: key);

  final bool edit;

  @override
  State<AddQuotationScreen> createState() => _AddQuotationScreenState();
}

class _AddQuotationScreenState extends State<AddQuotationScreen> {
  final _productName = TextEditingController(text: 'Furniture');
  final _price = TextEditingController(text: '100');
  final _storeLocation = TextEditingController(text: 'VijayNagar indore');
  final _quantity = TextEditingController(text: '2');
  final _weight = TextEditingController(text: '50');
  final _width = TextEditingController(text: '100');
  final _height = TextEditingController(text: '200');
  final _productDescription = TextEditingController(text: 'Item made of glass');
  final QuotationController _quotationController =
      Get.put(QuotationController());
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
                      cont: _price,
                      title: 'Price',
                      icon: const SuffixText(
                        text: 'in USD',
                      ),
                      fieldLabel: '',
                      keyboard: TextInputType.number,
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
                    onPressed: () {
                      if (_productName.text.isNotEmpty &&
                          _storeLocation.text.isNotEmpty &&
                          _price.text.isNotEmpty &&
                          _quantity.text.isNotEmpty &&
                          _weight.text.isNotEmpty &&
                          _width.text.isNotEmpty &&
                          _height.text.isNotEmpty &&
                          _productDescription.text.isNotEmpty) {
                        loadingController.updateLoading(true);
                        _quotationController.addQuotation(
                            context,
                            _productName.text,
                            _storeLocation.text,
                            _price.text,
                            _quantity.text,
                            _weight.text,
                            _width.text,
                            _height.text,
                            _productDescription.text,
                            _video);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).kindlyFillAllTheFields,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Text(
                      S.of(context).addProduct,
                      style: const TextStyle(color: Colors.white),
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
