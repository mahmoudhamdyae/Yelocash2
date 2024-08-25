import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/screen/two_factor/two_factor_setup_screen/sections/two_factor_disable_section.dart';
import 'package:changa_lab/view/screen/two_factor/two_factor_setup_screen/sections/two_factor_enable_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../data/controller/account/profile_controller.dart';
import '../../../../../data/controller/auth/two_factor_controller.dart';
import '../../../../../data/repo/account/profile_repo.dart';
import '../../../../../data/repo/auth/two_factor_repo.dart';

class TwoFactorSetupScreen extends StatefulWidget {
  const TwoFactorSetupScreen({super.key});

  @override
  State<TwoFactorSetupScreen> createState() => _TwoFactorSetupScreenState();
}

class _TwoFactorSetupScreenState extends State<TwoFactorSetupScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final pcontroller = Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pcontroller.loadProfileInfo();
      controller.get2FaCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TwoFactorController>(builder: (controller) {
      return GetBuilder<ProfileController>(builder: (profileController) {
        return Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
            isShowBackBtn: true,
            title: MyStrings.twoFactorAuth.tr,
          ),
          body: controller.isLoading || profileController.isLoading
              ? const CustomLoader()
              : profileController.user2faIsOne == false
                  ? const TwoFactorEnableSection()
                  : const TwoFactorDisableSection(),
        );
      });
    });
  }
}
