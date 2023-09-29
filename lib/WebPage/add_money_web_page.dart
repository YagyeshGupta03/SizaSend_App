import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/WalletScreens/payment_status_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

/////// Add money screen is also while paying for quotation. Edit it as well.

class WebPage extends StatefulWidget {
  const WebPage({super.key, required this.link, required this.status});

  final String link;
  final bool status;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains('success')) {
              userInfoController.getUserInfo().whenComplete(() => Get.to(() =>
                  PaymentStatusScreen(success: true, status: widget.status)));
            } else if (url.contains('cancel')) {
              userInfoController.getUserInfo().whenComplete(() => Get.to(() =>
                  PaymentStatusScreen(success: false, status: widget.status)));
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
