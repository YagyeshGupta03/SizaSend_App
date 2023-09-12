import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Models/Models.dart';
import '../Helper/http_helper.dart';
import '../screen/dashboard_screen.dart';

class QuotationController extends GetxController {
  //
  //
  // Function to add quotation
  void addQuotation(context, productName, storeLocation, quantity, weight,
      width, height, description, video, receiverId) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: addQuotationUrl);
    var reply = await networkHelper.postMultiPartData({
      'user_id': credentialController.id.toString(),
      'name': productName,
      'store_name': storeLocation,
      'quantity': quantity,
      'weight': weight,
      'width': width,
      'height': height,
      'description': description,
    }, [
      video
    ], "video");

    if (reply['status'] == 1) {
      sendNotification(reply['data']['id'], receiverId);
      receiveQuotation();
      Get.to(()=> const DashBoardScreen());
      loadingController.updateLoading(false);
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
        msg: "${reply['message']}",
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
      loadingController.updateLoading(false);
    } else {
      loadingController.updateLoading(false);
    }
  }

  //
  //
  //
  //Function to show quotation
  RxList<QuotationModel> getQuotationList = <QuotationModel>[].obs;
  void receiveQuotation() async {
    final NetworkHelper networkHelper = NetworkHelper(url: receiveQuotationUrl);
    var reply = await networkHelper.postData({
      // 'user_id': credentialController.id,
    });

    print(reply);
    print(credentialController.id);
    if (reply['status'] == 1) {
      getQuotationList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        String receiverId = reply['data'][i]['receiver_id'];
        String senderUser = reply['data'][i]['user_id'];
        String status = reply['data'][i]['order_status'];
        if (senderUser == credentialController.id.toString() ||
            receiverId == credentialController.id.toString() &&
                reply['data'][i]['status'] == 'accept') {
          if (status == 'complete' || status == 'refund') {
          } else {
            getQuotationList.add(
              QuotationModel(
                id: reply['data'][i]['id'],
                orderId: reply['data'][i]['order_id'],
                productName: reply['data'][i]['name'],
                price: reply['data'][i]['price'],
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
    } else {
      print('Error in getting quotation list');
    }
  }

  //
  //
  //
  //
  void sendNotification(orderId, receiverId) async {
    final NetworkHelper networkHelper = NetworkHelper(url: sendNotificationUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id,
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

    if (reply['status'] == 1) {
      getNotificationList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        final createdAtString = reply['data'][i]['created_at'];
        final createdAt = DateTime.parse(createdAtString);
        getNotificationList.add(
          NotificationModel(
              orderId: reply['data'][i]['order_id'],
              notificationId: reply['data'][i]['id'],
              status: reply['data'][i]['status'] ?? '',
              senderId: reply['data'][i]['sender_id'],
              receiverId: reply['data'][i]['receiver_id'],
              date: createdAt,
              message: reply['data'][i]['message']),
        );
      }
    } else {
      print('Error in getting notification list');
    }
  }

  //
  //
  //
  // To send status on notification so accordingly, a popup of accept/reject should appear or not
  void sendNotificationStatus(notificationId, status) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: notificationStatusUrl);
    var reply = await networkHelper.postData({
      'notification_id': notificationId,
      'status': status,
    });

    if (reply['status'] == 1) {
      if (status == '0') {
        Fluttertoast.showToast(
          msg: 'Quotation rejected',
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
        );
      }
      receiveNotification();
      print('Notification status updated');
    } else {
      print('Error in updating notification status');
    }
  }

  //
  //
  //
  //To send status in order history table so that it should add in quotation list
  void sendQuotationStatus(orderId, senderId, status) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: sendQuotationStatusUrl);
    var reply = await networkHelper.postData({
      'order_id': orderId,
      'receiver_id': credentialController.id,
      'user_id': senderId,
      'status': status
    });

    if (reply['status'] == 1) {
      print('Order status updated');
    } else {
      print('Error in updating order status');
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

    if (reply['status'] == 1) {
      getQuotationHistory.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        String receiverId = reply['data'][i]['receiver_id'] ?? '';
        String senderUser = reply['data'][i]['user_id'];
        String status = reply['data'][i]['order_status'];
        if (senderUser == credentialController.id.toString() ||
            receiverId == credentialController.id.toString()) {
          if (status == 'complete') {
            getQuotationHistory.add(
              QuotationModel(
                id: reply['data'][i]['id'],
                orderId: reply['data'][i]['order_id'],
                productName: reply['data'][i]['name'],
                price: reply['data'][i]['price'],
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
    } else {
      print('Error in getting quotation history list');
    }
  }
}
