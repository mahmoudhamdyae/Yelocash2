import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/auth/login_controller.dart';
import 'package:changa_lab/data/repo/auth/login_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/components/text/default_text.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import 'package:changa_lab/view/screen/auth/login/widget/social_login_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Container(
        color: MyColor.appBarColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bg1,
            body: GetBuilder<LoginController>(builder: (controller) {
              return SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.space30,
                    ),
                    Text(
                      MyStrings.wellComeback.tr,
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
                      MyStrings.loginsubtitle.tr,
                      style: regularMediumLarge.copyWith(
                        fontSize: Dimensions.fontLarge,
                        color: MyColor.contentTextColor,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(height: Dimensions.space20),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextField(
                            labelText: MyStrings.username.tr,
                            needOutlineBorder: true,
                            animatedLabel: true,
                            onChanged: (value) {},
                            hintText: MyStrings.username.tr,
                            //isIcon: true,
                            textInputType: TextInputType.emailAddress,
                            controller: controller.emailController,
                            focusNode: controller.emailFocusNode,
                            nextFocus: controller.passwordFocusNode,
                            inputAction: TextInputAction.next,
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
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: Dimensions.space25,
                          ),
                          CustomTextField(
                            labelText: MyStrings.password.tr,
                            needOutlineBorder: true,
                            animatedLabel: true,
                            hintText: MyStrings.password.tr,
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocusNode,
                            onChanged: (value) {},
                            //isIcon: true,
                            isPassword: true,
                            isShowSuffixIcon: true,
                            textInputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            prefixicon: const SizedBox(
                              width: 22,
                              height: 22,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomSvgPicture(
                                  image: MyImages.lock,
                                  fit: BoxFit.scaleDown,
                                  color: MyColor.hintTextColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: Dimensions.space25),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                                    activeColor: MyColor.primaryColor,
                                    checkColor: MyColor.colorWhite,
                                    value: controller.remember,
                                    side: WidgetStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                        width: 1.0,
                                        color: controller.remember ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder(),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.changeRememberMe();
                                    },
                                  ),
                                  Text(MyStrings.rememberMe.tr, style: bodyText.copyWith(color: MyColor.titleColor)),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  controller.clearTextField();
                                  Get.toNamed(RouteHelper.forgotPasswordScreen);
                                },
                                child: DefaultText(
                                  text: MyStrings.forgotPassword.tr,
                                  textColor: MyColor.title,
                                  fontSize: Dimensions.Text12,
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: Dimensions.space30),
                          controller.isSubmitLoading
                              ? const RoundedLoadingBtn()
                              : RoundedButton(
                                  text: MyStrings.signIn.tr.toUpperCase(),
                                  press: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.loginUser();
                                    }
                                  },
                                  cornerRadius: 8,
                                  isOutlined: true,
                                ),
                          const SizedBox(
                            height: Dimensions.space10,
                          ),
                          const SocialLoginSection(),
                          const SizedBox(
                            height: Dimensions.space40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(MyStrings.doNotHaveAccount.tr, style: textinput.copyWith(color: MyColor.titleColor, fontFamily: 'popins', fontWeight: FontWeight.w500)),
                              const SizedBox(width: Dimensions.space5),
                              InkWell(
                                onTap: () {
                                  Get.offNamed(RouteHelper.registrationScreen);
                                },
                                child: Text(
                                  MyStrings.signUp.tr,
                                  style: textinput.copyWith(
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
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
