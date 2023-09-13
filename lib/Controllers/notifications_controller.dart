import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCM {
  // RemoteMessage? _messages;
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
          AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
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
        // handleClick(context, message);
      }
    });

    // foreground message
    FirebaseMessaging.onMessage.listen((message) async {
      // _messages = message;
      _context = context;
      _showLocalNotification(
          message.notification!.title, message.notification!.body);
    });
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    debugPrint('notification Local>>>>>: $payload');
    // handleClick(_context!, _messages!);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload>>>>>: $payload');
      // handleClick(_context!, _messages!);
    }
  }

  // handleClick(BuildContext context, RemoteMessage message) {
  //   ///Chat Handle
  //
  //   if (message.data.containsValue("chat")) {
  //     var user = Provider.of<UserProvider>(context, listen: false);
  //     FirebaseChatCore.instance
  //         .room(message.data["room_id"])
  //         .first
  //         .then((value) {
  //       clearNotification();
  //       if (user.role == 4) {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => StudentsDashboardScreen(
  //                   selected: 4,
  //                 )),
  //                 (route) => false);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ChatDetailScreen(
  //                   room: value,
  //                   otherUserId: message.data["user_id"],
  //                   userId: message.data["otherUserId"],
  //                 )));
  //       } else if (user.role == 2) {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => CoordinatorDashboard(
  //                   selected: 1,
  //                 )),
  //                 (route) => false);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ChatDetailScreen(
  //                   room: value,
  //                   otherUserId: message.data["user_id"],
  //                   userId: message.data["otherUserId"],
  //                 )));
  //       } else if (user.role == 3) {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => InstructorDashboard(
  //                   selected: 3,
  //                 )),
  //                 (route) => false);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ChatDetailScreen(
  //                   room: value,
  //                   otherUserId: message.data["user_id"],
  //                   userId: message.data["otherUserId"],
  //                 )));
  //       } else if (user.role == 1) {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
  //                 (route) => false);
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => AdminChatScreen()));
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ChatDetailScreen(
  //                   room: value,
  //                   otherUserId: message.data["user_id"],
  //                   userId: message.data["otherUserId"],
  //                 )));
  //       }
  //     });
  //   }
  //
  //   if (message.data.containsValue("new_user")) {
  //     // Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //         builder: (context) => MessageScreen(
  //     //           chatId: message.data["chat_id"],
  //     //         )));
  //   }
  //
  //   ///Student Notification
  //   if (message.data.containsValue("notification")) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => const StudentNotificationScreen()));
  //   }
  //
  //   ///Package Notification
  //   if (message.data.containsValue("Package")) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => SinglePackageDetailScreen(
  //               packageId: message.data["id"],
  //             )));
  //   }
  //
  //   ///student assign notification
  //   if (message.data["type"] == "assign" && message.data["role"] == "4") {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => AssignTypeDetails(
  //               id: message.data["id"],
  //             )));
  //   }
  //
  //   ///student book notification
  //   if (message.data["type"] == "book" && message.data["role"] == "4") {
  //     var user = Provider.of<UserProvider>(context, listen: false);
  //
  //     if (user.role == 4) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => TypeBookDetails(
  //                 id: message.data["id"],
  //               )));
  //     }
  //   }
  //
  //   ///Instructor assign notification
  //   if (message.data["type"] == "book" && message.data["role"] == "3") {
  //     var user = Provider.of<UserProvider>(context, listen: false);
  //     if (user.role == 3) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => NotificationBookingDetails(
  //                 id: message.data["id"],
  //               )));
  //     }
  //   }
  //
  //   ///Lesson Start and end Notification to student
  //
  //   if (message.data["type"] == "lesson" && message.data["role"] == "4") {
  //     var user = Provider.of<UserProvider>(context, listen: false);
  //
  //     if (user.role == 4) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => TookLessonDetailsScreen(
  //                 id: message.data["id"],
  //               )));
  //     }
  //   }
  // }

  void clearNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}

// background message
Future<void> onBackgroundMessage(RemoteMessage message) async {}
