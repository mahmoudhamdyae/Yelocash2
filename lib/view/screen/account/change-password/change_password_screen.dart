import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/screen/account/change-password/widget/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/account/change_password_controller.dart';
import 'package:changa_lab/data/repo/account/change_password_repo.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiClient: Get.find()));
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ChangePasswordController>().clearData();
    });
  }

  @override
  void dispose() {
    Get.find<ChangePasswordController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: MyColor.appBarColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(isShowBackBtn: true, title: MyStrings.changePassword.tr, bgColor: MyColor.getAppBarColor(),titleStyle: bodyText.copyWith(color: MyColor.white),),
          body: GetBuilder<ChangePasswordController>(
            builder: (controller) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyStrings.createNewPassword.tr,
                      style: regularExtraLarge.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text(
                        MyStrings.createPasswordSubText.tr,
                        style: regularDefault.copyWith(color: MyColor.getTextColor().withOpacity(0.8)),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const ChangePasswordForm()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
