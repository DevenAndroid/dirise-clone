import 'dart:developer';

import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/vendor/authentication/thank_you_screen.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../dashboard/dashboard_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentUrl, this.onSuccess, this.onFailed});
  final String paymentUrl;
  final Function()? onSuccess;
  final Function()? onFailed;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController? controller;
  bool webLoaded = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      log("Received Url......     ${widget.paymentUrl}");
      controller = WebViewController()
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              log("Navigation Request....      ${request.url}");
              if (request.url.contains(navigationBackUrl)) {
                showToast("Payment Successfully".tr);
                if(widget.onSuccess == null) {
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.to(() => const VendorDashBoardScreen());
                } else {
                  widget.onSuccess!();
                }
                return NavigationDecision.prevent;
              }
              if (request.url.contains(failureUrl)) {
                showToast("Payment Failed".tr);
                Get.back();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..setJavaScriptMode(JavaScriptMode.unrestricted);
      controller!.loadRequest(Uri.parse(widget.paymentUrl)).then((value) {
        webLoaded = true;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.clearCache();
    controller!.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller!.canGoBack()) {
          controller!.goBack();
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar:  CommonAppBar(
          titleText: "Payment".tr,
          backGroundColor: Colors.transparent,
        ),
        body: webLoaded
            ? WebViewWidget(
                controller: controller!,
              )
            : const LoadingAnimation(),
      ),
    );
  }
}
