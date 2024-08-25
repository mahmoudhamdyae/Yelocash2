import 'dart:convert';
import 'dart:io';
import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/authorization/authorization_response_model.dart';
import 'package:changa_lab/data/model/exchange/manual_exchange_response_model.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualExchangeConfirmController extends GetxController {
  ExchangeRepo exchangeRepo;
  ManualExchangeConfirmController({
    required this.exchangeRepo,
  });

  bool isLoading = true;
  String imagePath = "";
  String defaultCurrency = "";
  String defaultCurrencySymbol = "";
  String selectOne = MyStrings.selectOne;
  List<GlobalFormModel> formList = [];

  String exchangeId = '-1';
  void initData(String exchangeId) {
    this.exchangeId = exchangeId;
    update();
    beforeInitLoadKycData();
  }

  bool submitLoading = false;
  submitKycData() async {
    List<String> list = hasError();

    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }

    submitLoading = true;
    update();

    AuthorizationResponseModel response = await exchangeRepo.submitConfirmManualExchangeData(formList, exchangeId);

    if (response.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      Get.offAllNamed(RouteHelper.bottomNavBar);
      CustomSnackBar.success(successList: response.message?.success ?? [MyStrings.success.tr]);
    } else {
      CustomSnackBar.error(errorList: response.message?.error ?? [MyStrings.requestFail.tr]);
    }

    submitLoading = false;
    update();
  }

  beforeInitLoadKycData() async {
    isLoading = true;
    update();

    ResponseModel responseModel = await exchangeRepo.getManualExchangeResponse(exchangeId);

    if (responseModel.statusCode == 200) {
      ManualExchangeResponseModel model = ManualExchangeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        List<GlobalFormModel>? tList = model.data?.requiredData?.formData?.list ?? [];

        if (tList.isNotEmpty) {
          formList.clear();
          for (var element in tList) {
            if (element.type == 'select') {
              bool? isEmpty = element.options?.isEmpty;
              bool empty = isEmpty ?? true;
              if (element.options != null && empty != true) {
                element.options?.insert(0, selectOne);
                element.selectedValue = element.options?.first;
                formList.add(element);
              }
            } else {
              formList.add(element);
            }
          }
        }
      }
    }

    isLoading = false;
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

  //
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
}
