import 'package:flutter/material.dart';
import 'package:savo/util/images.dart';
import 'package:savo/util/widgets/text_field.dart';
import '../../generated/l10n.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool rememberMe = false;
  final _phone = TextEditingController();

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
                  S.of(context).forgotPassword,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Text(
                S.of(context).toResetYourPasswordYouNeedYourEmailOrMobile,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                Images.forgotImage,
                scale: 3,
              ),
              CustomTextFormField(
                topTitle: S.of(context).phoneNo,
                cont: _phone,
                suffixWidget: const SizedBox(),
                prefixWidget: const SizedBox(),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: s.height * .02,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/otpScreen");
                  },
                  child: Text(
                    S.of(context).sendOtp,
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
