import 'package:flutter/material.dart';
import 'package:savo/Constants/theme_data.dart';
import '../Constants/sizes.dart';
import '../Controllers/global_controllers.dart';


class TimeoutScreen extends StatefulWidget {
  const TimeoutScreen({super.key});

  @override
  State<TimeoutScreen> createState() => _TimeoutScreenState();
}

class _TimeoutScreenState extends State<TimeoutScreen> {
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
            const Icon(Icons.watch_later_outlined, size: 60, color: primaryColor),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Oops! Time out',
                style: themeController.currentTheme.value.textTheme.bodyMedium,
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
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Try again', style: TextStyle(color: Colors.white),),
                )),
          ],
        ),
      ),
    );
  }
}
