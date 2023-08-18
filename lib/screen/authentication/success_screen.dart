import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

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
                  S.of(context).successfully,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Text(
                S
                    .of(context)
                    .yourPasswordHasBeenUpdatedPleaseChangeYourPasswordRegularly,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/onBoard", (route) => false);
                    Navigator.pushNamed(context, "/loginScreen");
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
