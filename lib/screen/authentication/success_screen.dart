import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';
import 'login_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              loadingController.updateLoading(false);
              Get.to(() => const LoginScreen());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: s.height * .05,
              ),
              const Center(
                child: Text(
                  'Successful',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                height: s.height * .01,
              ),
              const Icon(Icons.check_box_rounded,
                  size: 45, color: Colors.green),
              SizedBox(
                height: s.height * .05,
              ),
              Text(
                S
                    .of(context)
                    .yourPasswordHasBeenUpdatedPleaseChangeYourPasswordRegularly,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: s.height * .05,
              ),
              SizedBox(
                height: s.height * .1,
              ),
              ElevatedButton(
                onPressed: () {
                  loadingController.updateLoading(false);
                  Get.to(() => const LoginScreen());
                },
                child: Text(
                  S.of(context).home,
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
