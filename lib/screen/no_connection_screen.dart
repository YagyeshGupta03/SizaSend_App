import 'package:flutter/material.dart';
import 'package:savo/Controllers/global_controllers.dart';
import '../Constants/sizes.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'No Internet',
                style: themeController.currentTheme.value.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'Check your internet connection',
                style: themeController.currentTheme.value.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  credentialController.getData(context);
                  userInfoController.getUserInfo();
                  connectivityController.refreshConnection(context);
                },
                child: const Text('Refresh', style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
