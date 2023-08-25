import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'Controllers/common_controllers.dart';
import 'generated/l10n.dart';
import 'screen/splash_screen.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // // Request permission
  // NotificationSettings settings = await messaging.requestPermission(
  // alert: true,
  // badge: true,
  // sound: true,
  // );
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
