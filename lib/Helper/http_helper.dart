import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:savo/screen/timeout_screen.dart';

class NetworkHelper {
  NetworkHelper({
    required this.url,
  });

  final String url;

  Future postData(Map<String, String> bodyData) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(bodyData);
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final res = await response.stream.bytesToString();
        print(res);
        var responseData = json.decode(res);
        return responseData;
      } else {
        final res = await response.stream.bytesToString();
        print(res);
        var responseData = jsonDecode(res);
        return responseData;
      }
    } on SocketException {
      Fluttertoast.showToast(
        msg: 'No internet connection',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      return null;
    } on HttpException {
      return null;
    } on FormatException {
      Fluttertoast.showToast(
        msg: 'Internal server error',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      return null;
    } on TimeoutException {
      Get.to(() => const TimeoutScreen());
      return null;
    } on Exception {
      Fluttertoast.showToast(
        msg: 'Internal server error',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      return null;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Exception',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future postMultiPartData(
      Map<String, String> data, List<XFile> image, String imageKey) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(data);
    image.forEach((element) async {
      request.files
          .add(await http.MultipartFile.fromPath(imageKey, element.path));
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      return jsonData;
    } else {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      return jsonData;
    }
  }

//
// Future postMultiPartDataDifferentKey(
//     Map<String, String> data, Map<String, XFile> images) async {
//   var request = http.MultipartRequest('POST', Uri.parse(url));
//   request.fields.addAll(data);
//   images.forEach((key, value) async {
//     request.files
//         .add(await http.MultipartFile.fromPath(key, value.path));
//   });
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//     return response.statusCode;
//   } else {
//     print(response.reasonPhrase);
//   }
// }
}
