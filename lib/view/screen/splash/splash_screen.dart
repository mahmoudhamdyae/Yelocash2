import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/localization/localization_controller.dart';
import 'package:changa_lab/data/controller/splash/splashController.dart';
import 'package:changa_lab/data/repo/auth/general_setting_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    MyUtils.splashScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(MyImages.appLogoCircle, height: 100, width: 100),
          ),
        ],
      ),
    );
  }
}
