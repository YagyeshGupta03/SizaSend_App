import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../generated/l10n.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool rememberMe = false;
  String currentText = "";
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: s.height * .05,
              ),
              Center(
                child: Text(
                  S.of(context).enterYourOtp,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Text(
                S.of(context).enterTheOtpCodeWeSentYou,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: s.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 61,
                    fieldWidth: 48,
                    activeFillColor: const Color(0xffF7F8FB),
                    selectedColor: const Color(0xffF7F8FB),
                    inactiveFillColor: const Color(0xffF7F8FB),
                    selectedFillColor: const Color(0xffF7F8FB),
                    inactiveColor: const Color(0xffF7F8FB),
                    activeColor: const Color(0xffF7F8FB),
                    disabledColor: const Color(0xffF7F8FB),
                    errorBorderColor: const Color(0xffF7F8FB),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              SizedBox(
                height: s.height * .1,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/successScreen");
                  },
                  child: Text(
                    S.of(context).submit,
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
