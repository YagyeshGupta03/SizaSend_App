import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Constants/sizes.dart';
import '../Constants/theme_data.dart';
import '../Controllers/global_controllers.dart';
import '../Controllers/login_controller.dart';
import '../util/widgets/login_button.dart';
import '../util/widgets/text_field.dart';

class AdminEnquiryScreen extends StatefulWidget {
  const AdminEnquiryScreen({super.key});

  @override
  State<AdminEnquiryScreen> createState() => _AdminEnquiryScreenState();
}

class _AdminEnquiryScreenState extends State<AdminEnquiryScreen> {
  final _subject = TextEditingController();
  final _description = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              loadingController.updateLoading(false);
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Enquiry form',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      cont: _subject,
                      title: 'Subject',
                      icon: const SizedBox(),
                      fieldLabel: 'Subject',
                      keyboard: TextInputType.text,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  const SizedBox(height: 20),
                  CustomTextField(
                      cont: _description,
                      title: 'Description',
                      icon: const SizedBox(),
                      fieldLabel: 'Description',
                      keyboard: TextInputType.text,
                      fillColor: themeController.currentTheme.value.cardColor,
                      hintText: ''),
                  const SizedBox(height: 35),
                  LoginButton(
                      onTap: () {
                        if (_subject.text.isNotEmpty &&
                            _description.text.isNotEmpty) {
                          _loginController.adminEnquiry(
                              context, _subject.text, _description.text);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Enter all the fields",
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      title: 'Submit',
                      txtColor: Colors.white,
                      btnColor: primaryColor),
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
    ;
  }
}
