import 'dart:convert';
import 'package:changa_lab/data/repo/auth/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/helper/shared_preference_helper.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/auth/login/login_response_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
// import 'package:changa_lab/data/repo/login/loginRepo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;
  LoginController({required this.loginRepo});

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  List<String> errors = [];
  bool remember = false;

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  void checkAndGotoNextStep(LoginResponseModel responseModel) async {
    bool needEmailVerification =
        responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification =
        responseModel.data?.user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    if (remember) {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userIdKey,
        responseModel.data?.user?.id.toString() ?? '-1');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenType,
        responseModel.data?.tokenType ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userEmailKey,
        responseModel.data?.user?.email ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userPhoneNumberKey,
        responseModel.data?.user?.mobile ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userNameKey,
        responseModel.data?.user?.username ?? '');

     await loginRepo.sendUserToken();
    bool isProfileCompleteEnable =
        responseModel.data?.user?.profileComplete == '0' ? true : false;

    if (needSmsVerification == false &&
        needEmailVerification == false &&
        isTwoFactorEnable == false) {
      if (isProfileCompleteEnable) {
        Get.offAndToNamed(RouteHelper.profileCompleteScreen);
      } else {
        Get.offAndToNamed(RouteHelper.bottomNavBar);
      }
    } else if (needSmsVerification == true &&
        needEmailVerification == true &&
        isTwoFactorEnable == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [true, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needSmsVerification == true && needEmailVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [true, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,
          arguments: [isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,
          arguments: [false, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen,
          arguments: isProfileCompleteEnable);
    }

    if (remember) {
      changeRememberMe();
    }
  }

  bool isSubmitLoading = false;
  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel model = await loginRepo.loginUser(
        emailController.text.toString(), passwordController.text.toString());

    if (model.statusCode == 200) {
      LoginResponseModel loginModel =
          LoginResponseModel.fromJson(jsonDecode(model.responseJson));
      if (loginModel.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        checkAndGotoNextStep(loginModel);
      } else {
        CustomSnackBar.error(
            errorList:
                loginModel.message?.error ?? [MyStrings.loginFailedTryAgain]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';

    if (remember) {
      remember = false;
    }
    update();
  }
}
