import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/auth/two_factor_controller.dart';
import 'package:changa_lab/data/repo/auth/two_factor_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:changa_lab/view/components/text/small_text.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class TwoFactorVerificationScreen extends StatefulWidget {
  const TwoFactorVerificationScreen({
    super.key,
  });

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    Get.put(TwoFactorController(repo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
           titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
          title: MyStrings.twoFactorAuth.tr,
          fromAuth: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
          child: GetBuilder<TwoFactorController>(
              builder: (controller) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: Dimensions.space20,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: MyColor.getPrimaryColor().withOpacity(.075), shape: BoxShape.circle),
                          child: CustomSvgPicture(image: MyImages.emailVerifyImage, height: 50, width: 50, color: MyColor.getPrimaryColor()),
                        ),
                        const SizedBox(height: Dimensions.space50),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                          child: SmallText(text: MyStrings.twoFactorMsg.tr, maxLine: 3, textAlign: TextAlign.center, textStyle: regularDefault.copyWith(color: MyColor.getLabelTextColor())),
                        ),
                        const SizedBox(height: Dimensions.space50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: regularDefault.copyWith(color: MyColor.getTextColor()),
                            length: 6,
                            textStyle: regularDefault.copyWith(color: MyColor.getTextColor()),
                            obscureText: false,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 40,
                                fieldWidth: 40,
                                inactiveColor: MyColor.getTextFieldDisableBorder(),
                                inactiveFillColor: MyColor.getTransparentColor(),
                                activeFillColor: MyColor.getTransparentColor(),
                                activeColor: MyColor.getPrimaryColor(),
                                selectedFillColor: MyColor.getTransparentColor(),
                                selectedColor: MyColor.getPrimaryColor()),
                            cursorColor: MyColor.primaryColor,
                            animationDuration: const Duration(milliseconds: 100),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            beforeTextPaste: (text) {
                              return true;
                            },
                            onChanged: (value) {
                              setState(() {
                                controller.currentText = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space30),
                        controller.submitLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                press: () {
                                  controller.verify2FACode(controller.currentText);
                                },
                                 cornerRadius: 8,
                                isOutlined: true,
                                text: MyStrings.verify.tr,
                              ),
                        const SizedBox(height: Dimensions.space30),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
