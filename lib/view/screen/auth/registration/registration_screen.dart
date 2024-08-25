import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/auth/auth/registration_controller.dart';
import 'package:changa_lab/data/repo/auth/general_setting_repo.dart';
import 'package:changa_lab/data/repo/auth/signup_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import 'package:changa_lab/view/screen/auth/registration/widget/registerForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String mobilecode = '880';
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(
        registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Container(
        color: MyColor.appBarColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.screenBgColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: Dimensions.screenPaddingHV,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        // height: Dimensions.space30,
                        ),
                    Text(
                      MyStrings.createAccount.tr,
                      style: regularExtraLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColor.titleColor,
                        fontSize: Dimensions.titleText,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    Text(
                      MyStrings.signupSubtitle.tr,
                      style: regularMediumLarge.copyWith(
                          fontSize: Dimensions.fontLarge,
                          color: MyColor.contentTextColor,
                          fontFamily: 'poppins'),
                    ),
                    const SizedBox(
                      height: Dimensions.space20,
                    ),
                    const RegisterForm(),
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
