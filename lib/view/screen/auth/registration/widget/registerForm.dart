import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/auth/auth/registration_controller.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/screen/auth/registration/widget/validation_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  //
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.space17),
              CustomTextField(
                needOutlineBorder: true,
                animatedLabel: true,
                controller: controller.fNameController,
                focusNode: controller.firstNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.lastNameFocusNode,
                onChanged: (p) {},
                hintText: MyStrings.firstName.tr,
                labelText: MyStrings.firstName.tr,
                isIcon: true,
                prefixicon: const SizedBox(
                  width: 22,
                  height: 22,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomSvgPicture(
                      image: MyImages.avatar,
                      fit: BoxFit.scaleDown,
                      color: MyColor.hintTextColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.kFirstNameNullError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: Dimensions.space17),
              CustomTextField(
                needOutlineBorder: true,
                animatedLabel: true,
                controller: controller.lNameController,
                focusNode: controller.lastNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.emailFocusNode,
                onChanged: (p) {},
                hintText: MyStrings.lastName.tr,
                labelText: MyStrings.lastName.tr,
                isIcon: true,
                prefixicon: const SizedBox(
                  width: 22,
                  height: 22,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomSvgPicture(
                      image: MyImages.avatar,
                      fit: BoxFit.scaleDown,
                      color: MyColor.hintTextColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.kLastNameNullError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: Dimensions.space17),
              CustomTextField(
                needOutlineBorder: true,
                animatedLabel: true,
                onChanged: (p) {},
                hintText: MyStrings.email.tr,
                labelText: MyStrings.email.tr,
                isIcon: true,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                prefixicon: const SizedBox(
                  width: 22,
                  height: 22,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomSvgPicture(
                      image: MyImages.email,
                      fit: BoxFit.scaleDown,
                      color: MyColor.hintTextColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return MyStrings.enterYourEmail.tr;
                  }
                  if (!value.contains('@')) {
                    return MyStrings.emailVerificationFailed.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: Dimensions.space17),
              Focus(
                onFocusChange: (hasFocus) {
                  controller.changePasswordFocus(hasFocus);
                },
                child: CustomTextField(
                  needOutlineBorder: true,
                  animatedLabel: true,
                  hintText: MyStrings.password.tr,
                  labelText: MyStrings.password.tr,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  nextFocus: controller.confirmPasswordFocusNode,
                  onChanged: (value) {
                    if (controller.checkPasswordStrength) {
                      controller.updateValidationList(value);
                    }
                  },
                  //isIcon: true,
                  isPassword: true,
                  isShowSuffixIcon: true,
                  textInputType: TextInputType.text,
                  prefixicon: SizedBox(
                    width: 22,
                    height: 22,
                    child: SvgPicture.asset(
                      MyImages.lock,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return MyStrings.enterYourPassword_.tr;
                    }
                    if (value.length < 6) {
                      return MyStrings.minSixChar.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: Dimensions.textToTextSpace),
              Visibility(visible: controller.hasPasswordFocus && controller.checkPasswordStrength, child: ValidationWidget(list: controller.passwordValidationRules)),
              const SizedBox(height: Dimensions.space17),
              CustomTextField(
                needOutlineBorder: true,
                animatedLabel: true,
                hintText: MyStrings.confirmPassword.tr,
                labelText: MyStrings.confirmPassword.tr,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                onChanged: (p) {},
                isPassword: true,
                isShowSuffixIcon: true,
                textInputType: TextInputType.text,
                prefixicon: SizedBox(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(
                    MyImages.lock,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: Dimensions.space20),
           CustomTextField(
                needOutlineBorder: true,
                animatedLabel: true,
                onChanged: (p) {},
                hintText: MyStrings.referralCode.tr,
                labelText: MyStrings.referralCode.tr,
                isIcon: true,
                controller: controller.refferalCodeController,
                focusNode: controller.refferalCodeFocusNode,
                textInputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    activeColor: MyColor.primaryColor,
                    checkColor: MyColor.colorWhite,
                    value: controller.agreeTC,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => BorderSide(
                        width: 1.0,
                        color: controller.agreeTC ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder(),
                      ),
                    ),
                    onChanged: (p) {
                      controller.updateAgreeTC();
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      style: regularDefault,
                      children: [
                        TextSpan(
                          text: '${MyStrings.iAgreeWith} ',
                          style: regularMediumLarge.copyWith(
                            fontSize: 14,
                            fontFamily: 'popins',
                            color: MyColor.contentTextColor,
                          ),
                          children: [
                            TextSpan(
                              text: MyStrings.policies.toLowerCase().tr,
                              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteHelper.privacyScreen),
                              style: regularMediumLarge.copyWith(
                                fontSize: 14,
                                fontFamily: 'popins',
                                color: MyColor.titleColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space30),
              controller.submitLoading
                  ? const RoundedLoadingBtn()
                  : RoundedButton(
                      text: MyStrings.signUp.tr.toUpperCase(),
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signUpUser();
                        }
                      },
                      cornerRadius: 8,
                      isOutlined: true,
                    ),
              const SizedBox(
                height: Dimensions.space25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MyStrings.alreadyAccount.tr,
                    style: regularMediumLarge.copyWith(
                      fontSize: 16,
                      fontFamily: 'popins',
                      color: MyColor.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.space5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offNamed(RouteHelper.loginScreen);
                    },
                    child: Text(
                      MyStrings.signIn.tr,
                      style: regularMediumLarge.copyWith(
                        fontSize: 16,
                        fontFamily: 'popins',
                        color: MyColor.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
