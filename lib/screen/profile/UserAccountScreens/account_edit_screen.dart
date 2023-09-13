import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../generated/l10n.dart';

class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({Key? key}) : super(key: key);

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  final _fullName = TextEditingController(text: userInfoController.fullName);
  final _phone = TextEditingController(text: userInfoController.phone);
  final _email = TextEditingController();
  final _employer = TextEditingController(text: userInfoController.employer);
  String occupation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
        title: Text(
          S.of(context).editAccount,
          style: themeController.currentTheme.value.textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTextField(
                  cont: _fullName,
                  title: S.of(context).fullName,
                  icon: const SizedBox(),
                  fieldLabel: S.of(context).name,
                  keyboard: TextInputType.name,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: ''),
              SizedBox(height: screenHeight(context) * .015),
              Text(
                S.of(context).occupation,
                style:
                    themeController.currentTheme.value.textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                hint: Text(S.of(context).occupation,
                    style: themeController
                        .currentTheme.value.textTheme.displaySmall),
                dropdownColor: themeController.currentTheme.value.cardColor,
                style:
                    themeController.currentTheme.value.textTheme.displaySmall,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    filled: true,
                    fillColor: themeController.currentTheme.value.cardColor),
                onChanged: (val) {
                  setState(() {
                    occupation = val.toString();
                  });
                },
                items: [
                  const DropdownMenuItem(
                    value: '0',
                    child: Text('Select Occupation'),
                  ),
                  for (int index = 0;
                      index < _profileController.occupationList.length;
                      index++)
                    DropdownMenuItem<String>(
                      value: _profileController.occupationList[index].id,
                      child:
                          Text(_profileController.occupationList[index].title),
                    ),
                ],
              ),
              SizedBox(height: screenHeight(context) * .015),
              CustomTextField(
                  cont: _employer,
                  title: S.of(context).employer,
                  icon: const SizedBox(),
                  fieldLabel: '',
                  keyboard: TextInputType.text,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: ''),
              SizedBox(height: screenHeight(context) * .015),
              CustomTextField(
                  cont: _phone,
                  title: S.of(context).phoneNo,
                  icon: const SizedBox(),
                  fieldLabel: 'Phone number',
                  keyboard: TextInputType.phone,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: ''),
              SizedBox(height: screenHeight(context) * .015),
              CustomTextField(
                  cont: _email,
                  title: 'E-mail',
                  icon: const SizedBox(),
                  fieldLabel: '',
                  keyboard: TextInputType.emailAddress,
                  fillColor: themeController.currentTheme.value.cardColor,
                  hintText: S.of(context).enterYourMail),
              SizedBox(height: screenHeight(context) * .033),
              ElevatedButton(
                onPressed: () {
                  if (_fullName.text.isNotEmpty && _phone.text.isNotEmpty) {
                    if (occupation == '0') {
                      _profileController.updateProfile(context, _fullName.text,
                          _employer.text, '', _phone.text, _email.text);
                    } else {
                      _profileController.updateProfile(context, _fullName.text,
                          _employer.text, occupation, _phone.text, _email.text);
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: S.of(context).fillTheMandatoryFields,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.red,
                    );
                  }
                },
                child: Text(
                  S.of(context).update,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
