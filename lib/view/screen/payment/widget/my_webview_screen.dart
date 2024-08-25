import 'dart:async';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/view/screen/deposits/deposit_webview/webview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MyWebViewScreen extends StatefulWidget {
  final String redirectUrl;

  const MyWebViewScreen({Key? key, required this.redirectUrl})
      : super(key: key);

  @override
  State<MyWebViewScreen> createState() => _MyWebViewScreenState();
}

class _MyWebViewScreenState extends State<MyWebViewScreen> {
  @override
  void initState() {
    super.initState();
    permissionServices();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MyWebViewWidget(url: widget.redirectUrl),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.colorRed,
      onPressed: () async {
        Get.back();
      },
      child: const Icon(
        Icons.cancel,
        color: MyColor.colorWhite,
        size: 30,
      ),
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }
}
