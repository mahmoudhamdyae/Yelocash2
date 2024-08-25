import 'dart:convert';
import 'dart:io';

import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/authorization/authorization_response_model.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';

import 'package:changa_lab/data/model/withdraw/withdraw_request_response_model.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../repo/withdraw/withdraw_repo.dart';

class AddNewWithdrawController extends GetxController {
  WithdrawRepo repo;
  AddNewWithdrawController({required this.repo});

  bool isLoading = true;

  List<Currency> sellCurrencyList = [];
  Currency? selectedCurrency;
  List<GlobalFormModel> formList = [];
  String selectedCurrencyID = "";
  final formKey = GlobalKey<FormState>();

  double receiveAmount = 0.0;
  TextEditingController sendingAmountController = TextEditingController(text: '');
  TextEditingController conversionAmountController = TextEditingController(text: '');
  TextEditingController walletController = TextEditingController(text: '');

  bool isNumeric(String str) {
    RegExp numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(str);
  }

  void initialValue() async {
    isLoading = true;
    submitLoading = false;
    formKey.currentState?.reset();
    selectedCurrency = null;
    selectedCurrencyID = '';
    selectedCurrency = null;
    sendingAmountController.text = '';
    sendingAmountController.clear();
    walletController.text = '';
    walletController.clear();
    update();
    await getWithdrawCurrency();
    
    isLoading = false;
    update();
  }

  double minExchangeAmount = 0.0;
  double maxExchangeAmount = 0.0;
  minMaxExchange() {
    double sellAt = double.tryParse(selectedCurrency?.sellAt?.toString() ?? "") ?? 0;
    double minimumLimitForSell = double.tryParse(selectedCurrency?.minimumLimitForSell?.toString() ?? "") ?? 0;
    double maxExchangeAmounts = double.tryParse(selectedCurrency?.maximumLimitForSell?.toString() ?? "") ?? 0;
    minExchangeAmount = sellAt * minimumLimitForSell;
    maxExchangeAmount = sellAt * maxExchangeAmounts;
    update();
  }

  void selectWithdrawCurrency(Currency value) {
    selectedCurrency = value;
    selectedCurrencyID = value.id.toString();
    formList.clear();
    if (value.userDetailsData?.formData != null) {
      List<GlobalFormModel>? tempList = value.userDetailsData?.formData?.list;
      if (tempList != null && tempList.isNotEmpty) {
        formList.addAll(tempList);
      }
    }
    update();
  }

  double count = 0.0;

  double countConversion() {
    conversionAmountController.clear();
    double sellAt = double.tryParse(selectedCurrency?.sellAt?.toString() ?? "") ?? 0;
    double sendingAmount = double.tryParse(sendingAmountController.text.toString() ?? "") ?? 0;

    if (sellAt == 0 || sendingAmount == 0) {
      conversionAmountController.text = "0";
    } else {
      double count = sendingAmount / sellAt;
      conversionAmountController.text = count.toStringAsFixed(2).toString();
    }

    update();
    return count;
  }

// New function to handle setting the conversion amount to 0 or ""
  void updateConversionAmountController(double value) {
    if (value == 0) {
      conversionAmountController.text = "";
    } else {
      conversionAmountController.text = value.toStringAsFixed(2).toString();
    }
    update();
  }

//
  bool submitLoading = false;
  Future<void> getWithdrawCurrency() async {
    ResponseModel response = await repo.getAllWithdrawMethod();
    if (response.statusCode == 200) {
      WithdrawCurrencyResponse model = WithdrawCurrencyResponse.fromJson(jsonDecode(response.responseJson));
      if (model.status == MyStrings.success) {
        List<Currency>? tempList = model.data?.currencies;
        tempList?.forEach((c) {
          c.userDetailsData?.formData?.list?.forEach((f) {
            print("form data");
            print(f.type);
          });
        });
        if (tempList != null) {
          sellCurrencyList.addAll(tempList);
        } else {
          sellCurrencyList.clear();
        }
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  //bool submitLoading=false;
  withdrawNow() async {
    List<String> list = hasError();

    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }

    submitLoading = true;
    update();

    AuthorizationResponseModel model = await repo.confirmWithdrawRequest(currency: selectedCurrencyID, list: formList, sendAmount: sendingAmountController.text);

    if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      CustomSnackBar.success(
        successList: model.message?.success ?? [MyStrings.success.tr],
      );
      formKey.currentState?.reset();
      sendingAmountController.clear();
      walletController.clear();
      selectedCurrency = null;
      selectedCurrencyID = "";
      receiveAmount = 0;
      formList.clear();
// remove money from storage
      update();
      Get.toNamed(RouteHelper.withdrawHistory);
    } else {
      CustomSnackBar.error(
        errorList: model.message?.error ?? [MyStrings.error.tr],
      );
    }

    submitLoading = false;
    update();
  }

  void changeSelectedTimeOnlyValue(int index, BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );

      formList[index].selectedValue = DateConverter.estimatedTime(selectedDateTime);
      formList[index].textEditingController?.text = DateConverter.estimatedTime(selectedDateTime);
      update();
    }

    update();
  }

  void changeSelectedDateTimeValue(int index, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        formList[index].selectedValue = DateConverter.estimatedDateTime(selectedDateTime);
        // formList[index].selectedValue = selectedDateTime.toIso8601String();
        formList[index].textEditingController?.text = DateConverter.estimatedDateTime(selectedDateTime);
        update();
      }
    }

    update();
  }

  void changeSelectedDateOnlyValue(int index, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      formList[index].selectedValue = DateConverter.estimatedDate(selectedDateTime);
      formList[index].textEditingController?.text = DateConverter.estimatedDate(selectedDateTime);
      update();
    }

    update();
  }

  List<String> hasError() {
    List<String> errorList = [];
    errorList.clear();

    for (var element in formList) {
      if (element.isRequired == 'required') {
        if (element.type == 'checkbox') {
          if (element.cbSelected == null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        } else if (element.type == 'file') {
          if (element.imageFile == null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        } else {
          if (element.selectedValue == '' || element.selectedValue == selectOne) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }
      }
    }

    return errorList;
  }

  String selectOne = MyStrings.selectOne;
  void changeSelectedValue(value, int index) {
    formList[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList[listIndex].selectedValue = formList[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {
    List<String> list = value.split('_');
    int index = int.parse(list[0]);
    bool status = list[1] == 'true' ? true : false;

    List<String>? selectedValue = formList[listIndex].cbSelected;

    if (selectedValue != null) {
      String? value = formList[listIndex].options?[index];
      if (status) {
        if (!selectedValue.contains(value)) {
          selectedValue.add(value!);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      } else {
        if (selectedValue.contains(value)) {
          selectedValue.removeWhere((element) => element == value);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      }
    } else {
      selectedValue = [];
      String? value = formList[listIndex].options?[index];
      if (status) {
        if (!selectedValue.contains(value)) {
          selectedValue.add(value!);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      } else {
        if (selectedValue.contains(value)) {
          selectedValue.removeWhere((element) => element == value);
          formList[listIndex].cbSelected = selectedValue;
          update();
        }
      }
    }
  }

  void pickFile(int index, {List<String>? extentions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: extentions ?? ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

    if (result == null) return;

    formList[index].imageFile = File(result.files.single.path!);
    String fileName = result.files.single.name;
    formList[index].selectedValue = fileName;
    update();

    return;
  }
}
