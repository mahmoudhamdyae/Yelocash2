import 'dart:convert';
import 'package:changa_lab/core/route/route_middle_ware.dart';
import 'package:changa_lab/data/model/country/country_model.dart';
import 'package:changa_lab/data/model/model/error_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/auth/sign_up_model/registration_response_model.dart';
import 'package:changa_lab/data/model/auth/sign_up_model/sign_up_model.dart';

import 'package:changa_lab/data/model/general_setting/general_setting_response_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';

import 'package:changa_lab/data/repo/auth/general_setting_repo.dart';
import 'package:changa_lab/data/repo/auth/signup_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({required this.registrationRepo, required this.generalSettingRepo});

  bool isLoading = true;
  bool agreeTC = false;

  GeneralSettingResponseModel generalSettingMainModel = GeneralSettingResponseModel();

  bool checkPasswordStrength = false;
  bool needAgree = true;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode companyNameFocusNode = FocusNode();
  final FocusNode refferalCodeFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
    final TextEditingController refferalCodeController = TextEditingController();

  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? firstName;
  String? lastName;

  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  bool submitLoading = false;

  signUpUser() async {
    if (needAgree && !agreeTC) {
      CustomSnackBar.error(
        errorList: [MyStrings.agreePolicyMessage],
      );
      return;
    }

    submitLoading = true;
    update();

    SignUpModel model = getUserData();

    ResponseModel responseModel = await registrationRepo.registerUser(model);

    if (responseModel.statusCode == 200) {
      RegistrationResponseModel model = RegistrationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success.tr]);
        RouteMiddleWare.checkUserStatusAndGoToNextStep(user: model.data?.user, accessToken: model.data?.accessToken ?? '', tokenType: model.data?.tokenType ?? '');
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }
 SignUpModel getUserData() {
     String referenceValue =refferalCodeController.text.toString().split('=').last;
    SignUpModel model = SignUpModel(
      firstName: fNameController.text.toString(),
      lastName: lNameController.text.toString(),
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
      refferalCode: referenceValue.toString(),
      agree: agreeTC ? true : false,
    );

    return model;
  }

  void closeAllController() {
    isLoading = false;
    emailController.text = '';
    passwordController.text = '';
    cPasswordController.text = '';
    fNameController.text = '';
    lNameController.text = '';
    mobileController.text = '';
    countryController.text = '';
  }

  clearAllData() {
    closeAllController();
  }

  List<ErrorModel> passwordValidationRules = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  bool isCountryLoading = true;
  void initData() async {
    isLoading = true;
    update();
    await getCountryData();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();
    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == 'success') {
        generalSettingMainModel = model;
        registrationRepo.apiClient.storeGeneralSetting(model);
      } else {
        List<String> message = [MyStrings.somethingWentWrong.tr];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
      return;
    }

    needAgree = generalSettingMainModel.data?.generalSetting?.agree.toString() == '0' ? false : true;
    checkPasswordStrength = generalSettingMainModel.data?.generalSetting?.securePassword.toString() == '0' ? false : true;

    isLoading = false;
    update();
  }

  bool countryLoading = false;

  List<Countries> countryList = [];

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await registrationRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));

      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
    }

    countryLoading = false;
    update();
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg.tr;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  bool noInternet = false;
  void changeInternet(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }
  

  void updateValidationList(String value) {
    passwordValidationRules[0].hasError = value.contains(RegExp(r'[A-Z]')) ? false : true;
    passwordValidationRules[1].hasError = value.contains(RegExp(r'[a-z]')) ? false : true;
    passwordValidationRules[2].hasError = value.contains(RegExp(r'[0-9]')) ? false : true;
    passwordValidationRules[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? false : true;
    passwordValidationRules[4].hasError = value.length >= 6 ? false : true;

    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }
}
