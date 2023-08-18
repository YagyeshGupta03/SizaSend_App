// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Let’s Get Started 👋🏾`
  String get letsGetStarted {
    return Intl.message(
      'Let’s Get Started 👋🏾',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Sign up or login into to have a full digital experience in our Business.`
  String get signUpOrLoginIntoToHaveAFullDigital {
    return Intl.message(
      'Sign up or login into to have a full digital experience in our Business.',
      name: 'signUpOrLoginIntoToHaveAFullDigital',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor`
  String get loremIpsumDolorSitAmetConsecteturAdipiscingElitSedDo {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
      name: 'loremIpsumDolorSitAmetConsecteturAdipiscingElitSedDo',
      desc: '',
      args: [],
    );
  }

  /// `Phone No.`
  String get phoneNo {
    return Intl.message(
      'Phone No.',
      name: 'phoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get createAnAccount {
    return Intl.message(
      'Create an Account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account yet?`
  String get alreadyHaveAnAccountYet {
    return Intl.message(
      'Already have an account yet?',
      name: 'alreadyHaveAnAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `To reset your password, you need your email or mobile number that can be authenticated`
  String get toResetYourPasswordYouNeedYourEmailOrMobile {
    return Intl.message(
      'To reset your password, you need your email or mobile number that can be authenticated',
      name: 'toResetYourPasswordYouNeedYourEmailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `SEND OTP`
  String get sendOtp {
    return Intl.message(
      'SEND OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OTP`
  String get enterYourOtp {
    return Intl.message(
      'Enter your OTP',
      name: 'enterYourOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code we sent you`
  String get enterTheOtpCodeWeSentYou {
    return Intl.message(
      'Enter the OTP code we sent you',
      name: 'enterTheOtpCodeWeSentYou',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get successfully {
    return Intl.message(
      'Successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been updated, please change your password regularly to avoid this happening`
  String get yourPasswordHasBeenUpdatedPleaseChangeYourPasswordRegularly {
    return Intl.message(
      'Your password has been updated, please change your password regularly to avoid this happening',
      name: 'yourPasswordHasBeenUpdatedPleaseChangeYourPasswordRegularly',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Quotation`
  String get quotation {
    return Intl.message(
      'Quotation',
      name: 'quotation',
      desc: '',
      args: [],
    );
  }

  /// `Account Info`
  String get accountInfo {
    return Intl.message(
      'Account Info',
      name: 'accountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get bankAccount {
    return Intl.message(
      'Bank Account',
      name: 'bankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `General Setting`
  String get generalSetting {
    return Intl.message(
      'General Setting',
      name: 'generalSetting',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Contact Info`
  String get contactInfo {
    return Intl.message(
      'Contact Info',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get yourName {
    return Intl.message(
      'Your name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Occupation`
  String get occupation {
    return Intl.message(
      'Occupation',
      name: 'occupation',
      desc: '',
      args: [],
    );
  }

  /// `Employer`
  String get employer {
    return Intl.message(
      'Employer',
      name: 'employer',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Top Buyers`
  String get topBuyers {
    return Intl.message(
      'Top Buyers',
      name: 'topBuyers',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Recent Transactions`
  String get recentTransactions {
    return Intl.message(
      'Recent Transactions',
      name: 'recentTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password does not match`
  String get confirmPasswordDoesNotMatch {
    return Intl.message(
      'Confirm password does not match',
      name: 'confirmPasswordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Fill the mandatory fields`
  String get fillTheMandatoryFields {
    return Intl.message(
      'Fill the mandatory fields',
      name: 'fillTheMandatoryFields',
      desc: '',
      args: [],
    );
  }

  /// `Add Account`
  String get addAccount {
    return Intl.message(
      'Add Account',
      name: 'addAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enterName {
    return Intl.message(
      'Enter name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bankName {
    return Intl.message(
      'Bank Name',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `Enter bank name`
  String get enterBankName {
    return Intl.message(
      'Enter bank name',
      name: 'enterBankName',
      desc: '',
      args: [],
    );
  }

  /// `IFSC code`
  String get ifscCode {
    return Intl.message(
      'IFSC code',
      name: 'ifscCode',
      desc: '',
      args: [],
    );
  }

  /// `Account number`
  String get accountNumber {
    return Intl.message(
      'Account number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter account number`
  String get enterAccountNumber {
    return Intl.message(
      'Enter account number',
      name: 'enterAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Confirm account number`
  String get confirmAccountNumber {
    return Intl.message(
      'Confirm account number',
      name: 'confirmAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Account confirmation does not match`
  String get accountConfirmationDoesNotMatch {
    return Intl.message(
      'Account confirmation does not match',
      name: 'accountConfirmationDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Add new bank account`
  String get addNewBankAccount {
    return Intl.message(
      'Add new bank account',
      name: 'addNewBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `No account currently`
  String get noAccountCurrently {
    return Intl.message(
      'No account currently',
      name: 'noAccountCurrently',
      desc: '',
      args: [],
    );
  }

  /// `Your bank account`
  String get yourBankAccount {
    return Intl.message(
      'Your bank account',
      name: 'yourBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password confirmation does not match`
  String get passwordConfirmationDoesNotMatch {
    return Intl.message(
      'Password confirmation does not match',
      name: 'passwordConfirmationDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Kindly fill all the fields`
  String get kindlyFillAllTheFields {
    return Intl.message(
      'Kindly fill all the fields',
      name: 'kindlyFillAllTheFields',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
