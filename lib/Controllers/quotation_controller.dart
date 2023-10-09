import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/walllet_controller.dart';
import 'package:savo/Models/Models.dart';
import 'package:savo/screen/WalletScreens/refund_screen.dart';
import 'package:savo/screen/quotation/quotatiion_invoice_screen.dart';
import '../Helper/http_helper.dart';
import '../screen/dashboard_screen.dart';

class QuotationController extends GetxController {
  //
  //
  // Function to add quotation
  void addQuotation(context, productName, storeLocation, quantity, weight,
      width, height, description, video, receiverId, price, length, courier) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: addQuotationUrl);
    var reply = await networkHelper.postMultiPartData({
      'user_id': credentialController.id.toString(),
      'name': productName,
      'store_name': storeLocation,
      'receiver_id': receiverId,
      'quantity': quantity,
      'weight': weight,
      'length': length,
      'sender_price': price,
      'courier_charge': courier,
      'width': width,
      'height': height,
      'description': description,
    }, [
      video
    ], "video");

    if (reply['status'] == 1) {
      sendNotification(reply['data']['id'], receiverId);
      receiveQuotation();
      loadingController.updateLoading(false);
      Get.to(() => const DashBoardScreen());
    } else {
      Fluttertoast.showToast(
        msg: reply['message'],
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      loadingController.updateLoading(false);
    }
  }

  //
  //
  //
  //Function to show quotation
  void deleteQuotation(context, orderId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: deleteQuotationUrl);
    var reply = await networkHelper.postData({
      'order_id': orderId,
    });

    if (reply['status'] == 1) {
      receiveQuotation();
    } else {
      Fluttertoast.showToast(
        msg: "Quotation is already paid",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
    }
  }

  //
  //
  //
  // Function to edit quotation with video
  // void editQuotationWithVideo(
  //     context,
  //     productName,
  //     storeLocation,
  //     price,
  //     quantity,
  //     weight,
  //     width,
  //     height,
  //     description,
  //     video,
  //     index,
  //     productId) async {
  //   loadingController.updateLoading(true);
  //   final NetworkHelper networkHelper = NetworkHelper(url: editQuotationUrl);
  //   var reply = await networkHelper.postMultiPartData({
  //     'user_id': credentialController.id.toString(),
  //     'order_id': productId,
  //     'name':
  //         productName == '' ? quotationList[index].productName : productName,
  //     'price': price == '' ? quotationList[index].price : price,
  //     'store_name':
  //         storeLocation == '' ? quotationList[index].store : storeLocation,
  //     'quantity': quantity == '' ? quotationList[index].quantity : quantity,
  //     'weight': weight == '' ? quotationList[index].weight : weight,
  //     'width': width == '' ? quotationList[index].width : width,
  //     'height': height == '' ? quotationList[index].height : height,
  //     'description':
  //         description == '' ? quotationList[index].description : description,
  //   }, [
  //     video
  //   ], "video");
  //
  //   if (reply['status'] == 1) {
  //     showQuotation();
  //     Navigator.pop(context);
  //     Fluttertoast.showToast(
  //       msg: reply['message'],
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.green,
  //     );
  //     loadingController.updateLoading(false);
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: reply['message'],
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.red,
  //     );
  //     loadingController.updateLoading(false);
  //   }
  // }

  //
  //
  //
  // Function to edit quotation without video
  // void editQuotation(context, productName, storeLocation, price, quantity,
  //     weight, width, height, description, index, productId) async {
  //   loadingController.updateLoading(true);
  //   final NetworkHelper networkHelper = NetworkHelper(url: editQuotationUrl);
  //   var reply = await networkHelper.postData({
  //     'user_id': credentialController.id.toString(),
  //     'order_id': productId,
  //     'name':
  //         productName == '' ? quotationList[index].productName : productName,
  //     'price': price == '' ? quotationList[index].price : price,
  //     'store_name':
  //         storeLocation == '' ? quotationList[index].store : storeLocation,
  //     'quantity': quantity == '' ? quotationList[index].quantity : quantity,
  //     'weight': weight == '' ? quotationList[index].weight : weight,
  //     'width': width == '' ? quotationList[index].width : width,
  //     'height': height == '' ? quotationList[index].height : height,
  //     'description':
  //         description == '' ? quotationList[index].description : description,
  //   });
  //
  //   if (reply['status'] == 1) {
  //     showQuotation();
  //     Navigator.pop(context);
  //     Fluttertoast.showToast(
  //       msg: 'Quotation updated',
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.green,
  //     );
  //     loadingController.updateLoading(false);
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: reply['message'],
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: Colors.red,
  //     );
  //     loadingController.updateLoading(false);
  //   }
  // }

  //
  //
  //
  //Function to search user
  RxList<UserModel> searchList = <UserModel>[].obs;
  void getSearchData(search) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: searchUserUrl);
    var reply = await networkHelper.postData({
      'search': search,
    });

    searchList.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        searchList.add(
          UserModel(
            userId: reply['data'][i]['id'],
            fullName: reply['data'][i]['full_name'],
            phone: reply['data'][i]['phone'],
            countryCode: reply['data'][i]['country_code'] ?? '',
            image: reply['data'][i]['profile_image'] ?? '',
          ),
        );
        update();
      }
      Future.delayed(const Duration(seconds: 4)).then((value) {
        loadingController.updateLoading(false);
      });
    } else {
      loadingController.updateLoading(false);
    }
  }

  //
  //
  //
  //Function to show quotation
  RxList<QuotationModel> getReceivedQuotationList = <QuotationModel>[].obs;
  RxList<QuotationModel> getQuotationList = <QuotationModel>[].obs;
  void receiveQuotation() async {
    final NetworkHelper networkHelper = NetworkHelper(url: receiveQuotationUrl);
    var reply = await networkHelper.postData({
      // 'user_id': credentialController.id,
    });

    getQuotationList.clear();
    getReceivedQuotationList.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        String receiverId = reply['data'][i]['receiver_id'];
        String senderUser = reply['data'][i]['user_id'];
        String status = reply['data'][i]['order_status'];
        if (senderUser == credentialController.id.toString() ||
            receiverId == credentialController.id.toString()) {
          if (status == 'complete' || status == 'refund') {
          } else {
            getQuotationList.add(
              QuotationModel(
                id: reply['data'][i]['id'],
                orderId: reply['data'][i]['order_id'],
                productName: reply['data'][i]['name'],
                price: reply['data'][i]['total_price'],
                store: reply['data'][i]['store_name'],
                quantity: reply['data'][i]['quantity'],
                weight: reply['data'][i]['weight'],
                width: reply['data'][i]['width'],
                height: reply['data'][i]['height'],
                paid: reply['data'][i]['order_status'],
                description: reply['data'][i]['description'],
                senderId: reply['data'][i]['user_id'],
                status: reply['data'][i]['status'] ?? '',
                video: reply['data'][i]['video'] ?? '',
              ),
            );
          }
        }
        if (receiverId == credentialController.id.toString()) {
          if (status == 'complete' || status == 'refund') {
          } else {
            getReceivedQuotationList.add(
              QuotationModel(
                id: reply['data'][i]['id'],
                orderId: reply['data'][i]['order_id'],
                productName: reply['data'][i]['name'],
                price: reply['data'][i]['total_price'],
                store: reply['data'][i]['store_name'],
                quantity: reply['data'][i]['quantity'],
                weight: reply['data'][i]['weight'],
                width: reply['data'][i]['width'],
                height: reply['data'][i]['height'],
                paid: reply['data'][i]['order_status'],
                description: reply['data'][i]['description'],
                senderId: reply['data'][i]['user_id'],
                status: reply['data'][i]['status'] ?? '',
                video: reply['data'][i]['video'] ?? '',
              ),
            );
          }
        }
        update();
      }
    } else {}
  }

  //
  //
  //
  //
  void sendNotification(orderId, receiverId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: sendNotificationUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'order_id': orderId,
      'receiver_id': receiverId,
    });

    if (reply['status'] == 1) {
      Fluttertoast.showToast(
        msg: 'Sent successfully',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
    } else {
      print('Error in getting quotation list');
    }
  }

  //
  //
  //
  // To receive notifications
  RxList<NotificationModel> getNotificationList = <NotificationModel>[].obs;
  void receiveNotification() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: receiveNotificationUrl);
    var reply = await networkHelper.postData({
      'receiver_id': credentialController.id.toString(),
    });

    getNotificationList.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        final createdAtString = reply['data'][i]['created_at'] ?? '';
        final createdAt = DateTime.parse(createdAtString);
        getNotificationList.add(
          NotificationModel(
              orderId: reply['data'][i]['order_id'] ?? '',
              notificationId: reply['data'][i]['id'],
              status: reply['data'][i]['status'] ?? '',
              senderId: reply['data'][i]['sender_id'] ?? '',
              receiverId: reply['data'][i]['receiver_id'] ?? '',
              date: createdAt,
              message: reply['data'][i]['message']),
        );
      }
    } else {}
  }

  //
  //
  //
  // To send status on notification so accordingly, a popup of accept/reject should appear or not

  // void sendNotificationStatus(
  //     context, notificationId, status, senderId, receiverId, orderId) async {
  //   final NetworkHelper networkHelper =
  //       NetworkHelper(url: notificationStatusUrl);
  //   var reply = await networkHelper.postData({
  //     'notification_id': notificationId,
  //     'status': status,
  //     'sender_id': senderId,
  //     'receiver_id': receiverId,
  //     'order_id': orderId,
  //   });
  //
  //   if (reply['status'] == 1) {
  //     Navigator.pop(context);
  //     if (status == '0') {
  //       Fluttertoast.showToast(
  //         msg: 'Quotation rejected',
  //         gravity: ToastGravity.SNACKBAR,
  //         backgroundColor: Colors.red,
  //       );
  //     } else if (status == '1') {
  //       getQuotationByOrderId(orderId).whenComplete(() {
  //         Future.delayed(const Duration(seconds: 1)).then((value) {
  //           Get.to(() => const QuotationDetailForNotification());
  //         });
  //       });
  //     }
  //     receiveNotification();
  //     print('Notification status updated');
  //   } else {
  //     print('Error in updating notification status');
  //   }
  // }

  //
  //
  //
  //To send status in order history table so that it should add in quotation list
  Future<bool> sendQuotationStatus(orderId, senderId, status) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: sendQuotationStatusUrl);
    var reply = await networkHelper.postData({
      'order_id': orderId,
      'receiver_id': credentialController.id.toString(),
      'user_id': senderId,
      'status': status
    });

    if (reply['status'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  //
  //
  //
  //Function to show quotation
  RxList<QuotationModel> getQuotationHistory = <QuotationModel>[].obs;
  void receiveQuotationHistory() async {
    final NetworkHelper networkHelper = NetworkHelper(url: receiveQuotationUrl);
    var reply = await networkHelper.postData({});

    getQuotationHistory.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        String receiverId = reply['data'][i]['receiver_id'] ?? '';
        String senderUser = reply['data'][i]['user_id'];
        String status = reply['data'][i]['order_status'];
        if (senderUser == credentialController.id.toString() ||
            receiverId == credentialController.id.toString()) {
          if (status == 'complete' || status == 'refund') {
            getQuotationHistory.add(
              QuotationModel(
                id: reply['data'][i]['id'],
                orderId: reply['data'][i]['order_id'],
                productName: reply['data'][i]['name'],
                price: reply['data'][i]['total_price'],
                store: reply['data'][i]['store_name'],
                quantity: reply['data'][i]['quantity'],
                weight: reply['data'][i]['weight'],
                width: reply['data'][i]['width'],
                height: reply['data'][i]['height'],
                paid: reply['data'][i]['order_status'],
                description: reply['data'][i]['description'],
                senderId: reply['data'][i]['user_id'],
                video: reply['data'][i]['video'] ?? '',
              ),
            );
          }
        }
        update();
      }
    } else {}
  }

  //
  //
  //
  //Function to get quotation details by order id
  String orderId = '';
  String productName = '';
  String price = '';
  String itemCost = '';
  String courierCharges = '';
  String adminCharges = '';
  String length = '';
  String store = '';
  String quantity = '';
  String weight = '';
  String width = '';
  String height = '';
  String description = '';
  String senderId = '';
  String senderName = '';
  String receiverName = '';
  String video = '';
  String sendImage = '';
  String reason = '';
  String receiveImage = '';
  String orderStatus = '';
  String status = '';

  Future<bool> getQuotationByOrderId(ordrId) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: getQuotationDetailsByIdUrl);
    var reply = await networkHelper.postData({'order_id': ordrId});

    status = '';
    if (reply['status'] == 1) {
      orderId = reply['data']['id'];
      productName = reply['data']['name'];
      price = reply['data']['total_price'];
      itemCost = reply['data']['sender_price'];
      adminCharges = reply['data']['charge'];
      courierCharges = reply['data']['price'];
      length = reply['data']['length'];
      store = reply['data']['store_name'];
      quantity = reply['data']['quantity'];
      weight = reply['data']['weight'];
      width = reply['data']['width'];
      height = reply['data']['height'];
      description = reply['data']['description'];
      orderStatus = reply['data']['order_status'];
      status = reply['data']['status'] ?? '';
      senderId = reply['data']['user_id'];
      senderName = reply['data']['sender_name'];
      reason = reply['data']['reason']??'';
      receiverName = reply['data']['receiver_name'];
      video = reply['data']['video'] ?? '';
      sendImage = reply['data']['send_image'] ?? '';
      receiveImage = reply['data']['receive_image'] ?? '';
      print(senderName);
      print(receiverName);
      return true;
    } else {
      print('Error in getting quotation history list');
      return false;
    }
  }

  //
  //
  //
  final WalletController _walletController = Get.put(WalletController());
  void sendDispatchCode(context, code, orderId) async {
    await loadingController.updateDispatchLoading(true);
    final NetworkHelper networkHelper =
        NetworkHelper(url: sendDispatchImageUrl);
    var reply = await networkHelper.postData({
      "sender_id": credentialController.id.toString(),
      "order_id": orderId,
      "dispatch": code,
    });

    if (reply['status'] == 1) {
      _walletController.updatePaidStatus(orderId, 'dispatch').then((value) {
        Dialogs.materialDialog(
            msg: 'Your order is dispatched',
            title: 'Dispatched',
            msgAlign: TextAlign.center,
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Get.to(() => const DashBoardScreen());
                },
                text: 'Close',
                color: primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
        loadingController.updateDispatchLoading(false);
      });
    } else {
      loadingController.updateDispatchLoading(false);
    }
    loadingController.updateDispatchLoading(false);
  }

  //
  //
  //
  void sendDeliveredCode(context, code, orderId, senderID) async {
    await loadingController.updateDispatchLoading(true);
    final NetworkHelper networkHelper =
        NetworkHelper(url: sendDeliveredImageUrl);
    var reply = await networkHelper.postData({
      "user_id": senderId,
      "order_id": orderId,
      "deliver": code.toString(),
    });
    if (reply['status'] == 1) {
      Dialogs.materialDialog(
          msg: 'Do you accept this order?',
          title: 'Delivery success',
          context: context,
          actions: [
            IconsButton(
              onPressed: () {
                Navigator.pop(context);
                Get.to(() => const RefundScreen());
              },
              text: 'Reject',
              color: Colors.white,
              textStyle: const TextStyle(color: primaryColor),
            ),
            IconsButton(
              onPressed: () {
                _walletController.completeOrderPayment(
                    context, orderId, 'complete', senderID, '');
                Navigator.pop(context);
              },
              text: 'Accept',
              color: primaryColor,
              textStyle: const TextStyle(color: Colors.white),
            ),
          ]);
      loadingController.updateDispatchLoading(false);
    } else {
      Dialogs.materialDialog(
          msg: 'Order does not exist',
          title: 'Failed',
          context: context,
          actions: [
            IconsButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'Scan again',
              color: primaryColor,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]);
      await loadingController.updateDispatchLoading(false);
    }
    loadingController.updateDispatchLoading(false);
  }

  //
  //
  //
  void notificationsDelete(context, notificationId) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: notificationsDeleteUrl);
    var reply = await networkHelper.postData({
      "notification_id": notificationId,
    });

    if (reply['status'] == 1) {
      receiveNotification();
      Get.back();
      Fluttertoast.showToast(
        msg: 'Notification deleted',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
    } else {
      print('Error in deleting notification');
    }
  }

  //
  //
  //
  void notificationsDeleteAll(context) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: notificationsDeleteUrl);
    var reply = await networkHelper.postData({
      "receiver_id": credentialController.id.toString(),
    });

    if (reply['status'] == 1) {
      receiveNotification();
      Get.back();
      Fluttertoast.showToast(
        msg: 'Notifications deleted',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
    } else {}
  }
  //
  //
  //
  //
  //
  //Function to get quotation invoice
  String orderIdI = '';
  String product = '';
  String totalPrice = '';
  String costOFItem = '';
  String courierPrice = '';
  String charge = '';
  String lengthI = '';
  String storeI = '';
  String quantityI = '';
  String weightI = '';
  String widthI = '';
  String heightI = '';
  String descriptionI = '';
  String sender = '';
  String receiver = '';
  String reasonI = '';
  String orderStatusI = '';
  String business = '';
  String vat = '';

  Future<bool> getQuotationInvoice(orderID) async {
    final NetworkHelper networkHelper =
    NetworkHelper(url: getQuotationInvoiceUrl);
    var reply = await networkHelper.postData({'order_id': orderID});

    if (reply['status'] == 1) {
      orderIdI = reply['data'][0]['id'];
      product = reply['data'][0]['name'];
      totalPrice = reply['data'][0]['total_price'];
      costOFItem = reply['data'][0]['sender_price'];
      print('working');
      charge = reply['data'][0]['charge'];
      courierPrice = reply['data'][0]['price'];
      lengthI = reply['data'][0]['length'];
      storeI = reply['data'][0]['store_name'];
      quantityI = reply['data'][0]['quantity'];
      weightI = reply['data'][0]['weight'];
      widthI = reply['data'][0]['width'];
      heightI = reply['data'][0]['height'];
      lengthI = reply['data'][0]['length'];
      descriptionI = reply['data'][0]['description'];
      orderStatusI = reply['data'][0]['order_status'];
      sender = reply['data'][0]['sender_name'];
      reasonI = reply['data'][0]['reason']??'';
      receiver = reply['data'][0]['receiver_name'];
      business = reply['data'][0]['occupation_name']??'';
      vat = reply['data'][0]['employer']??'';
      Get.to(()=> const QuotationInvoiceScreen());
      return true;
    } else {
      print('Error in getting quotation history list');
      return false;
    }
  }
}
