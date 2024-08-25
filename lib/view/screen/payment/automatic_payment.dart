import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/screen/payment/widget/my_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoMaticPayemntScreen extends StatefulWidget {
  const AutoMaticPayemntScreen({super.key});

  @override
  State<AutoMaticPayemntScreen> createState() => _AutoMaticPayemntScreenState();
}

class _AutoMaticPayemntScreenState extends State<AutoMaticPayemntScreen> {
  String url = '';
  @override
  void initState() {
    url = Get.arguments[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment',
        titleStyle: heading.copyWith(color: MyColor.white),
        isShowBackBtn: true,
      ),
      body: MyWebViewScreen(redirectUrl: url),
    );
  }
}
