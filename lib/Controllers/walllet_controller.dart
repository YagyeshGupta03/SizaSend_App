import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Models/Models.dart';
import 'package:savo/WebPage/add_money_web_page.dart';
import 'package:savo/screen/WalletScreens/add_money_screen.dart';
import 'package:savo/screen/WalletScreens/withdraw_money_screen.dart';
import 'package:savo/screen/dashboard_screen.dart';
import '../Constants/all_urls.dart';
import '../Constants/theme_data.dart';
import '../Helper/http_helper.dart';
import '../screen/WalletScreens/Payment_success_screen.dart';

class WalletController extends GetxController {
  //
  //
  //
  void addMoney(context, amount) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: addMoneyUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'add_amount': amount,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        Dialogs.materialDialog(
            msg: 'Money added to your wallet',
            msgAlign: TextAlign.center,
            title: "Success",
            color: Colors.white,
            titleAlign: TextAlign.center,
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(() => const DashBoardScreen());
                },
                text: 'Go back',
                color: primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
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
  void quotationAddMoney(context, amount) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: addMoneyUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'add_amount': amount,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        Dialogs.materialDialog(
            msg: 'Money added to your wallet',
            msgAlign: TextAlign.center,
            title: "Success",
            color: Colors.white,
            titleAlign: TextAlign.center,
            context: context,
            actions: [
              IconsButton(
                onPressed: () async {
                  Get.back();
                  Navigator.pop(context);
                },
                text: 'Go back',
                color: primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
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
  void withdrawMoney(context, bankId) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: withdrawMoneyUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'minus_amount': credentialController.amount.toString(),
      'bank_id': bankId,
    });

    if (reply['status'] == 1) {
      credentialController.deleteWithdraw();
      userInfoController.getUserInfo().then((value) {
        Dialogs.materialDialog(
            msg: 'Withdrawal request submitted',
            msgAlign: TextAlign.center,
            title: "Success",
            color: Colors.white,
            titleAlign: TextAlign.center,
            context: context,
            actions: [
              IconsButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Get.to(() => const WithdrawMoneyScreen());
                },
                text: 'Go back',
                color: primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
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
  Future<bool> quotationPay(amount, senderId, orderId, orderName, courierCharge, costOfItem) async {
    await loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: quotationPayUrl);
    var reply = await networkHelper.postData({
      'receiver_id': senderId,
      'sender_id': credentialController.id.toString(),
      'amount': amount,
      'order_id': orderId,
      'courier_charge': courierCharge,
      'cost_of_item': costOfItem,
    });

    if (reply['status'] == 1) {
      userInfoController.getUserInfo().then((value) {
        updatePaidStatus(orderId, 'paid');
        Get.to(() => PaymentSuccessfulScreen(
            orderId: orderId, orderName: orderName, amount: amount));
        Fluttertoast.showToast(
          msg: 'Transaction completed',
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
        );
        loadingController.updateLoading(false);
      });
      return true;
    } else if (reply['status'] == 2) {
      Fluttertoast.showToast(
        msg: reply['message'],
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      Get.to(() => QuotationMoneyAdd(price: amount, orderID: orderId));
      loadingController.updateLoading(false);
      return false;
    } else {
      Fluttertoast.showToast(
        msg: reply['message'],
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      loadingController.updateLoading(false);
      return false;
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
      return true;
    } else {
      return false;
    }
  }

  //
  //
  //
  //
  Future<bool> completeOrderPayment(context, orderId, status, senderId, reason) async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: completeOrderPaymentUrl);
    var reply = await networkHelper.postData({
      'receiver_id': senderId,
      'order_id': orderId,
      'status': status,
      'sender_id': credentialController.id.toString(),
    });

    if (reply['status'] == 1) {
      updatePaidStatus(orderId, status).then((value) async {
        await userInfoController.getUserInfo();
       if(status == 'complete'){
         Dialogs.materialDialog(
             msg: 'Parcel accepted successfully',
             msgAlign: TextAlign.center,
             title: 'Accepted',
             context: context,
             actions: [
               IconsButton(
                 onPressed: () {
                   Get.to(()=> const DashBoardScreen());
                 },
                 text: 'Back to home',
                 color: primaryColor,
                 textStyle: const TextStyle(color: Colors.white),
               ),
             ]);
       } else{
         updateRefundReason(context, orderId, reason);
         Dialogs.materialDialog(
             msg: 'Amount will be credited to your wallet in a short time',
             title: 'Refund successful',
             msgAlign: TextAlign.center,
             context: context,
             actions: [
               IconsButton(
                 onPressed: () {
                   Get.to(()=> const DashBoardScreen());
                 },
                 text: 'Back to home',
                 color: primaryColor,
                 textStyle: const TextStyle(color: Colors.white),
               ),
             ]);
       }
      });
      return true;
    } else {
      return false;
    }
  }

  //
  //
  //
  //
  Future<bool> updateRefundReason(context, orderId, reason) async {
    final NetworkHelper networkHelper =
    NetworkHelper(url: updateRefundReasonUrl);
    var reply = await networkHelper.postData({
      'order_id': orderId,
      'reason': reason,
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
  void webOpen(amount, status, type, wallet) async {
    loadingController.updateLoading(true);
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      loadingController.updateLoading(false);
    }
    final NetworkHelper networkHelper = NetworkHelper(url: redirectWebUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'amount': amount,
      'type': type,
      'wallet': wallet,
    });

    if (reply['status'] == 1) {
      Get.to(() => WebPage(link: reply['link'], status: status));
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
  //
  RxList<WalletTransactionModel> walletTransactionsList =
      <WalletTransactionModel>[].obs;
  void getWalletHistory() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: walletTransactionsUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
    });

    walletTransactionsList.clear();

    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        DateTime createdAt = DateTime.parse(reply['data'][i]['created_at']);
        String formattedDate = DateFormat.yMMMMd().format(createdAt);
        String formattedTime = DateFormat.jm().format(createdAt);

        walletTransactionsList.add(WalletTransactionModel(
          transactionId: reply['data'][i]['id'],
          balance: reply['data'][i]['balance']??"",
          status: reply['data'][i]['status'] ?? '',
          paidUser: reply['data'][i]['paid_user_name'] ?? '',
          date: formattedDate,
          time: formattedTime,
        ));
      }
      update();
    } else {
      print('Error in getting wallet history list');
    }
  }

  //
  //
  //
  //
  RxList<WithdrawalRequestModel> withdrawRequestList =
      <WithdrawalRequestModel>[].obs;
  void getWithdrawalHistory() async {
    final NetworkHelper networkHelper =
        NetworkHelper(url: withdrawRequestUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
    });

    withdrawRequestList.clear();
    if (reply['status'] == 1) {
      for (int i = 0; i < reply['data'].length; i++) {
        DateTime createdAt = DateTime.parse(reply['data'][i]['created_at']);
        String formattedDate = DateFormat.yMMMMd().format(createdAt);
        String formattedTime = DateFormat.jm().format(createdAt);
        withdrawRequestList.add(WithdrawalRequestModel(
          requestId: reply['data'][i]['id'],
          amount: reply['data'][i]['amount'],
          status: reply['data'][i]['status'],
          bankName: reply['data'][i]['bank_name'],
          date: formattedDate,
          time: formattedTime,
          acNumber: reply['data'][i]['account_no'],
          ifsc: reply['data'][i]['ifsc_code'],
          charges: reply['data'][i]['processing_fees'],
        ));
      }
      update();
    } else {
      print('Error in getting wallet history list');
    }
  }
}
