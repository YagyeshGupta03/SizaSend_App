import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/screen/dashboard_screen.dart';
import 'package:savo/screen/quotation/quotationDetail_for_notification.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import '../../Controllers/global_controllers.dart';
import '../../Controllers/notifications_controller.dart';
import '../../Controllers/quotation_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    _quotationController.receiveNotification();
    FCM().setNotifications(context);
  }

  String getTimeAgo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      // You can add more detailed logic for longer durations if needed.
      return 'Long time ago';
    }
  }

  final QuotationController _quotationController =
      Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: themeController.currentTheme.value.textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Today',
                  style: themeController.currentTheme.value.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => _quotationController.getNotificationList.length.isEqual(0)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'No Notifications',
                          style: themeController
                              .currentTheme.value.textTheme.bodyLarge,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount:
                            _quotationController.getNotificationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (_quotationController
                                          .getNotificationList[index].orderId !=
                                      '') {
                                    _quotationController
                                        .getQuotationByOrderId(
                                            _quotationController
                                                .getNotificationList[index]
                                                .orderId)
                                        .whenComplete(() => Get.to(
                                              () =>
                                                  const QuotationDetailScreen(),
                                            ));
                                  }
                                  // if (_quotationController
                                  //         .getNotificationList[index].status ==
                                  //     '') {
                                  //   _showPopupDialog(
                                  //       context,
                                  //       _quotationController
                                  //           .getNotificationList[index].message,
                                  //       _quotationController
                                  //           .getNotificationList[index].orderId,
                                  //       _quotationController
                                  //           .getNotificationList[index]
                                  //           .notificationId,
                                  //       _quotationController
                                  //           .getNotificationList[index]
                                  //           .senderId,
                                  //     _quotationController
                                  //         .getNotificationList[index]
                                  //         .receiverId,
                                  //   );
                                  // }
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: .5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        height: 60,
                                        margin: const EdgeInsets.all(5),
                                        child: Image.asset(
                                          'assets/icons/ic_notification.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: screenWidth(context) / 1.5,
                                            child: Text(
                                              _quotationController
                                                  .getNotificationList[index]
                                                  .message,
                                              style: themeController
                                                  .currentTheme
                                                  .value
                                                  .textTheme
                                                  .titleSmall,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                    getTimeAgo(_quotationController
                                        .getNotificationList[index].date),
                                    style: themeController.currentTheme.value
                                        .textTheme.bodySmall),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopupDialog(BuildContext context, message, orderId, notificationId,
      senderId, receiverId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeController.currentTheme.value.cardColor,
          title: Text("Notification",
              style: themeController.currentTheme.value.textTheme.bodyLarge),
          content: Text(message,
              style: themeController.currentTheme.value.textTheme.titleSmall),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _quotationController.sendNotificationStatus(context,
                    notificationId, '1', senderId, receiverId, orderId);
                _quotationController.sendQuotationStatus(
                    orderId, senderId, 'accept');
              },
              child: const Text(
                "Accept",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                _quotationController.sendNotificationStatus(context,
                    notificationId, '0', senderId, receiverId, orderId);
                _quotationController.sendQuotationStatus(
                    orderId, senderId, 'reject');
                Navigator.of(context).pop();
              },
              child: const Text(
                "Reject",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
