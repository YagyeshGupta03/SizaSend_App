import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:savo/screen/NotificationScreen/notification_screen.dart';

class FCM {
  RemoteMessage? _messages;
  BuildContext? _context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _showLocalNotification(String? title, String? body) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true);

    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
            android: android, iOS: initializationSettingsDarwin),
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    var androidPlatformChannelSpecifics =
        const AndroidNotificationDetails("Magic Trainer", "Magic Trainer",
            importance: Importance.max,
            playSound: true,
            showProgress: true,
            priority: Priority.high,
            ticker: 'test ticker',
            // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            icon: "");

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(
            categoryIdentifier: "plainCategory"));

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  setNotifications(context) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions();
    }

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    //background click handle call back
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // handleClick(context, message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // when app is open and read the notification and its handled
        handleClick(context, message);
      }
    });

    // foreground message
    FirebaseMessaging.onMessage.listen((message) async {
      _messages = message;
      _context = context;
      _showLocalNotification(
          message.notification!.title, message.notification!.body);
    });
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    debugPrint('notification Local>>>>>: $payload');
    handleClick(_context!, _messages!);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint(
          'When screen is on this work notification payload>>>>>: $payload');
      handleClick(_context!, _messages!);
    }
  }

  handleClick(BuildContext context, RemoteMessage message) {
    ///Chat Handle
    Get.to(() => const NotificationScreen());
    print(message);

    // if (message.data.containsValue("chat")) {
    //
    // }

    //Navigate To Notification Screen
    if (message.data["type"] == "notification") {
      Get.to(() => const NotificationScreen());
    }
  }

  void clearNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}

// background message
Future<void> onBackgroundMessage(RemoteMessage message) async {}


