import 'dart:convert';
import 'package:http/http.dart'as http;


class NetworkHelper {
  NetworkHelper({
    required this.url,
  });

  final String url;

  Future postData(Object bodyData) async {
    http.Response response = await http.post(Uri.parse(url), body: bodyData);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData;
    } else {
      var responseData = jsonDecode(response.body);
      return responseData;
    }
  }

  // Future postMultiPartData(
  //     Map<String, String> data, List<XFile> image, String imageKey) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.fields.addAll(data);
  //   image.forEach((element) async {
  //     request.files
  //         .add(await http.MultipartFile.fromPath('$imageKey', element.path));
  //   });
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var responseData = await response.stream.bytesToString();
  //     var jsonData = jsonDecode(responseData);
  //     return jsonData;
  //   } else {
  //     var responseData = await response.stream.bytesToString();
  //     var jsonData = jsonDecode(responseData);
  //     return jsonData;
  //   }
  // }
  //
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