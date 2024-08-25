import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/auth/forget_password/verify_password_controller.dart';
import 'package:changa_lab/data/repo/auth/login_repo.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:changa_lab/view/components/text/default_text.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {



  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller = Get.put(VerifyPasswordController(loginRepo: Get.find()));

    controller.email = Get.arguments;

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          fromAuth: true,
          isShowBackBtn: true,
          titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
          title: MyStrings.passVerification.tr,
        ),
        body: GetBuilder<VerifyPasswordController>(
          builder: (controller) => controller.isLoading ?
          Center(
            child: CircularProgressIndicator(color: MyColor.getPrimaryColor())
          ) :
          SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.space50),
                  Container(
                    height: 100, width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColor.primaryColor.withOpacity(.07),
                      shape: BoxShape.circle
                    ),
                   child: CustomSvgPicture(image:MyImages.emailVerifyImage, height: 50, width: 50, color: MyColor.getPrimaryColor())),
                  const SizedBox(height: Dimensions.space25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DefaultText(text: '${MyStrings.verifyPasswordSubText.tr} : ${controller.getFormatedMail().tr}', textAlign: TextAlign.center, textColor: MyColor.getContentTextColor())),
                  const SizedBox(height: Dimensions.space40),
                  OTPFieldWidget(onChanged: (value){
                    setState(() {
                      controller.currentText = value;
                    });
                  }),
                  const SizedBox(height: Dimensions.space25),
                  controller.verifyLoading ? const RoundedLoadingBtn() : RoundedButton(
                    text: MyStrings.verify.tr,
                    press: () {
                      if (controller.currentText.length != 6) {
                        controller.hasError=true;
                      }
                      else {
                        controller.verifyForgetPasswordCode(controller.currentText);
                      }
                    }
                  ),
                  const SizedBox(height: Dimensions.space25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(text: MyStrings.didNotReceiveCode.tr, textColor: MyColor.getTextColor()),
                      const SizedBox(width: Dimensions.space5),
                     controller.isResendLoading?
                     const SizedBox(
                       height: 17,
                       width: 17,
                       child: CircularProgressIndicator(color: MyColor.primaryColor,),):
                     TextButton(
                        onPressed: (){
                          controller.resendForgetPassCode();
                        },
                        child: DefaultText(text: MyStrings.resend.tr, textStyle: regularDefault.copyWith(color: MyColor.getPrimaryColor())
                        ),
                      )
                    ],
                  )
                 ],
                ),
              )
          )
      )
    ),
  );
 }
}

