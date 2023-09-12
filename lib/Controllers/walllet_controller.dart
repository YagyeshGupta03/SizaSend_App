import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/dashboard_screen.dart';
import '../Constants/all_urls.dart';
import '../Helper/http_helper.dart';

class WalletController extends GetxController {
  //
  //
  void addMoney(amount) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: addMoneyUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id,
      'add_amount': amount,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        Get.to(() => const DashBoardScreen());
        Fluttertoast.showToast(
          msg: 'Transaction completed',
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
        );
        loadingController.updateLoading(false);
      });
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
  void withdrawMoney(amount) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: withdrawMoneyUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id,
      'minus_amount': amount,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        Get.to(() => const DashBoardScreen());
        Fluttertoast.showToast(
          msg: 'Transaction completed',
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
        );
        loadingController.updateLoading(false);
      });
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
  void quotationPay(amount, senderId, orderId) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: quotationPayUrl);
    var reply = await networkHelper.postData({
      'receiver_id': senderId,
      'sender_id': credentialController.id,
      'amount': amount,
      'order_id': orderId,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        updatePaidStatus(orderId, 'paid');
        Get.to(() => const DashBoardScreen());
        Fluttertoast.showToast(
          msg: 'Transaction completed',
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
        );
        loadingController.updateLoading(false);
      });
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
  //
  Future<bool> updatePaidStatus(orderId, status) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: quotationPaidStatusUrl);
    var reply = await networkHelper.postData({
      // 'receiver_id': credentialController.id.toString(),
      'order_id': orderId,
      'status': status,
    });

    if (reply['status'] == 1) {
      print('Updated paid status');
      return true;
    } else {
      print('Could not update paid status');
      return false;
    }
  }

  //
  //
  //
  //
  void completeOrderPayment(orderId, status, senderId) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: completeOrderPaymentUrl);
    var reply = await networkHelper.postData({
      'receiver_id': senderId,
      'order_id': orderId,
      'status': status,
      'sender_id': credentialController.id.toString(),
    });

    if (reply['status'] == 1) {
      updatePaidStatus(orderId, status)
          .then((value) => Get.to(() => const DashBoardScreen()));
    } else {
      print('Could not update order payment');
    }
  }
}
