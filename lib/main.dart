import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/authentication/forgot_screen.dart';
import 'package:savo/screen/authentication/otp_screen.dart';
import 'package:savo/screen/authentication/sign_up_screen.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/profile/BankAccount_screens/add_bankAc_screen.dart';
import 'package:savo/screen/profile/BankAccount_screens/bankAc_listing.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_info_screen.dart';
import 'package:savo/screen/profile/change_password_screen.dart';
import 'package:savo/screen/profile/profile_home_screen.dart';
import 'Controllers/common_controllers.dart';
import 'generated/l10n.dart';
import 'landing.dart';
import 'screen/authentication/login_screen.dart';
import 'screen/authentication/success_screen.dart';
import 'screen/onboard/onboarding_screen.dart';
import 'screen/splash_screen.dart';

void main() {
  final ThemeController themeController = ThemeController();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "SizaSend",
        // initialRoute: "/",
        // routes: {
        //   "/": (context) => const LandingScreen(),
        //   "/splash": (context) => const SplashScreen(),
        //   "/onBoard": (context) => const OnBoardingScreen(),
        //   "/loginScreen": (context) => const LoginScreen(),
        //   "/signUpScreen": (context) => const SignUpScreen(),
        //   "/forgotScreen": (context) => const ForgotScreen(),
        //   "/otpScreen": (context) => const OtpScreen(),
        //   "/successScreen": (context) => const SuccessScreen(),
        //   "/dashBoardScreen": (context) => const DashBoardScreen(),
        //   "/profileHomeScreen": (context) => const ProfileHomeScreen(),
        //   "/accountInfoScreen": (context) => const AccountInfoScreen(),
        //   "/bankListingScreen": (context) => const BankListingScreen(),
        //   "/addBankScreen": (context) => const AddBankScreen(),
        //   "/changePasswordScreen": (context) => const ChangePasswordScreen(),
        // },
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        // builder: (context, child) {
        //   return MediaQuery(
        //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //     child: child!,
        //   );
        // },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale("en", "EN"),
        theme: themeController.currentTheme.value);
  }
}
