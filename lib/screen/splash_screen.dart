// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/images.dart';

import 'no_connection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Set the duration of the animation
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.elasticInOut, // Apply the desired animation curve
    );

    _controller!.forward();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      connectivityController.connectionChecking(context);
       _navigateToHome();
    });
  }

  _navigateToHome() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      credentialController.getData(context);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      credentialController.getData(context);
    } else if (connectivityResult == ConnectivityResult.none) {
      Get.to(() => const NoConnectionScreen());
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Images.bgSplash,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: -800, end: 0),
              // Start logo -200 pixels above the screen
              duration: const Duration(seconds: 2),
              // Same duration as animation controller
              curve: Curves.elasticInOut,
              // Same animation curve as the animation controller
              builder: (context, double offset, child) {
                return Transform.translate(
                  offset: Offset(0, offset),
                  child: child,
                );
              },
              child: Image.asset(
                Images.icLogo,
                fit: BoxFit.contain,
                scale: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
