import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Models/Models.dart';
import '../Helper/http_helper.dart';

class QuotationController extends GetxController {
  //
  //
  // Function to add quotation
  void addQuotation(context, productName, storeLocation, price, quantity,
      weight, width, height, description, video) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: addQuotationUrl);
    var reply = await networkHelper.postMultiPartData({
      'user_id': credentialController.id.toString(),
      'name': productName,
      'price': price,
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
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: reply['message'],
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
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
  RxList<QuotationModel> quotationList = <QuotationModel>[].obs;
  void showQuotation() async {
    final NetworkHelper networkHelper = NetworkHelper(url: showQuotationUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id,
    });

    if (reply['status'] == 1) {
      quotationList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        quotationList.add(
          QuotationModel(
              productID: reply['data'][i]['id'],
              productName: reply['data'][i]['name'],
              price: reply['data'][i]['price'],
              store: reply['data'][i]['store_name'],
              quantity: reply['data'][i]['quantity'],
              weight: reply['data'][i]['weight'],
              width: reply['data'][i]['width'],
              height: reply['data'][i]['height'],
              description: reply['data'][i]['description'],
              video: reply['data'][i]['video'] ?? ''),
        );
        update();
      }
    } else {
      print('Error in getting quotation list');
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
      showQuotation();
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
  void editQuotationWithVideo(context, productName, storeLocation, price,
      quantity, weight, width, height, description, video, index, productId) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: editQuotationUrl);
    var reply = await networkHelper.postMultiPartData({
      'user_id': credentialController.id.toString(),
      'order_id': productId,
      'name': productName == ''? quotationList[index].productName : productName,
      'price': price == '' ? quotationList[index].price : price,
      'store_name': storeLocation == ''? quotationList[index].store : storeLocation,
      'quantity': quantity == '' ? quotationList[index].quantity : quantity,
      'weight': weight ==''? quotationList[index].weight : weight,
      'width': width ==''? quotationList[index].width : width,
      'height': height == ''? quotationList[index].height : height,
      'description': description == ''? quotationList[index].description : description,
    }, [
      video
    ], "video");

    if (reply['status'] == 1) {
      showQuotation();
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: reply['message'],
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
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
  // Function to edit quotation without video
  void editQuotation(context, productName, storeLocation, price, quantity,
      weight, width, height, description, index, productId) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: editQuotationUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id.toString(),
      'order_id': productId,
      'name': productName == ''? quotationList[index].productName : productName,
      'price': price == '' ? quotationList[index].price : price,
      'store_name': storeLocation == ''? quotationList[index].store : storeLocation,
      'quantity': quantity == '' ? quotationList[index].quantity : quantity,
      'weight': weight ==''? quotationList[index].weight : weight,
      'width': width ==''? quotationList[index].width : width,
      'height': height == ''? quotationList[index].height : height,
      'description': description == ''? quotationList[index].description : description,
    });

    if (reply['status'] == 1) {
      showQuotation();
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Quotation updated',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
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
              countryCode: reply['data'][i]['country_code']?? '',
              image: reply['data'][i]['profile_image'] ??'',
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
  // Function to add quotation
  void sendQuotation(context, orderId, receiver) async {
    loadingController.updateLoading(true);
    final NetworkHelper networkHelper = NetworkHelper(url: sendQuotationUrl);
    var reply = await networkHelper.postData({
      'sender_id': credentialController.id,
      'receiver_id': receiver,
      'order_id': orderId
    });

    if (reply['status'] == 1) {
      Get.back();
      Fluttertoast.showToast(
        msg: 'Quotation sent successfully',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );
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
  RxList<QuotationModel> getQuotationList = <QuotationModel>[].obs;
  void receiveQuotation() async {
    final NetworkHelper networkHelper = NetworkHelper(url: receiveQuotationUrl);
    var reply = await networkHelper.postData({
      'user_id': credentialController.id,
    });

    if (reply['status'] == 1) {
      getQuotationList.clear();
      for (int i = 0; i < reply['data'].length; i++) {
        getQuotationList.add(
            QuotationModel(
              productID: reply['data'][i]['order_id'],
              productName: reply['data'][i]['name'],
              price: reply['data'][i]['price'],
              store: reply['data'][i]['store_name'],
              quantity: reply['data'][i]['quantity'],
              weight: reply['data'][i]['weight'],
              width: reply['data'][i]['width'],
              height: reply['data'][i]['height'],
              description: reply['data'][i]['description'],
              senderId: reply['data'][i]['sender_id'],
              receiverId: reply['data'][i]['receiver_id'],
              video: reply['data'][i]['video'] ?? ''),
        );
        update();
      }
    } else {
      print('Error in getting quotation list');
    }
  }
}
