import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:changa_lab/data/model/currency/buy_currency_modal.dart';
import 'package:changa_lab/data/model/currency/currency_model.dart';
import 'package:changa_lab/data/model/currency/sell_currency_modal.dart';
import 'package:changa_lab/data/model/exchange/confirm_exchange_modal.dart' as confirm_exchange_modal;
import 'package:changa_lab/data/model/exchange/create_exchange_response_modal.dart';
import 'package:changa_lab/data/model/exchange/exchange_list_model.dart';
import 'package:changa_lab/data/model/exchange/exchange_prev_modal.dart';
import 'package:changa_lab/data/model/general_setting/general_setting_response_model.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/currency/currency_repo.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/repo/home/home_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;
  ExchangeRepo exchangeRepo;
  CurrencyRepo currencyRepo;
  DashboardController dashboardController;

  HomeController({
    required this.homeRepo,
    required this.exchangeRepo,
    required this.currencyRepo,
    required this.dashboardController,
  });

  String imageUrl = '';
  String email = "";
  bool isLoading = true;
  String username = "";
  String siteName = "";
  String imagePath = "";
  String defaultCurrency = "";
  String defaultCurrencySymbol = "";
  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();
  int page = 0;

  String? nextPageUrl;
  // data variables

  PrevExchange prevExchange = PrevExchange();
  int? sendCurrencyID;
  int? buyCurrencyID;

  SellCurrency? selectedSendCurrency;
  BuyCurrency? selectedbuyCurrency;

  List<Currency> currencyList = [];
  List<LatestExchange> latestExchanges = [];

  List<SellCurrency> sellCurrencyList = [];
  List<SellCurrency> tempsellCurrencyList = [];

  List<BuyCurrency> buyCurrencyList = [];
  List<BuyCurrency> tempbuyCurrencyList = [];

  TextEditingController sendingAmountController = TextEditingController(text: '');
  TextEditingController getingAmountController = TextEditingController(text: '');
  TextEditingController walletIdController = TextEditingController(text: '');

  double receiveAmount = 0.0;
  double amountSend = 0.0;



  bool isNumeric(String str) {
    RegExp numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(str);
  }

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = true;
    submitLoading = false;
    sendingAmountController.text = '';
    getingAmountController.text = '';
    walletIdController.text = '';
    update();
    await loadData();
    prevExchange = PrevExchange();
    isLoading = false;
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

  Future<void> loadData() async {
    formList.clear();
    selectedSendCurrency = null;
    selectedbuyCurrency = null;
    receiveAmount = 0;
    amountSend = 0;
    page = 0;
    sendCurrencyID = null;
    buyCurrencyID = null;
    sendingAmountController.clear();
    getingAmountController.clear();

    defaultCurrency = homeRepo.apiClient.getCurrencyOrUsername();
    username = homeRepo.apiClient.getCurrencyOrUsername(isCurrency: false);
    email = homeRepo.apiClient.getUserEmail();
    defaultCurrencySymbol = homeRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    generalSettingResponseModel = homeRepo.apiClient.getGSData();
    siteName = generalSettingResponseModel.data?.generalSetting?.siteName ?? "";
    await dashboardController.getDashboardData();
    getAllExchanges();
    buyCurrency();
    sellCurrency();
    getAllCurrency();
  }

  Future<void> getAllExchanges() async {
    // isLoading = true;

    latestExchanges.clear();
    update();

    ResponseModel responseModel = await exchangeRepo.getAllExchanges(page);
    if (responseModel.statusCode == 200) {
      LatestExchangeResponseModel model = LatestExchangeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == MyStrings.success) {
        List<LatestExchange>? tempData = model.data!.exchanges?.data;
        imageUrl = model.data?.imagePath ?? '';

        if (tempData != null) {
          latestExchanges.clear();
          latestExchanges = tempData;
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading = false;
    update();
  }

  //
  Future<void> getAllCurrency() async {
    currencyList.clear();
    isLoading = true;
    update();
    ResponseModel response = await currencyRepo.getAllCurrency();
    if (response.statusCode == 200) {
      CurrencyModel model = CurrencyModel.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<Currency>? currency = model.data?.currencies;
        if (currency != null && currency.isNotEmpty) {
          currencyList.addAll(currency);
          imagePath = model.data!.imagePath!;
          log(imagePath.toString());
        } else {
          CustomSnackBar.success(successList: [response.message]);
        }
      } else {
        CustomSnackBar.error(errorList: [response.message]);
      }
    } else {
      log('Error: CurrencyController.getAllCurrency');
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();
  }

  Future<void> sellCurrency() async {
    isLoading = true;
    update();
    ResponseModel response = await currencyRepo.sellCurrency();

    sellCurrencyList.clear();
    tempsellCurrencyList.clear();

    if (response.statusCode == 200) {
      SellCurrencyModal model = SellCurrencyModal.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<SellCurrency>? currency = model.data?.currencies;
        if (currency != null && currency.isNotEmpty) {
          sellCurrencyList.addAll(currency);
          tempsellCurrencyList.addAll(currency);
          // imagePath = model.data!.imagePath!;
        } else {
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> buyCurrency() async {
    isLoading = true;
    update();
    ResponseModel response = await currencyRepo.sellCurrency();

    buyCurrencyList.clear();
    tempbuyCurrencyList.clear();

    if (response.statusCode == 200) {
      BuyCurrencyModal model = BuyCurrencyModal.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<BuyCurrency>? currency = model.data?.currencies;
        if (currency != null && currency.isNotEmpty) {
          buyCurrencyList.addAll(currency);
          tempbuyCurrencyList.addAll(currency);
          // imagePath = model.data!.imagePath!;
        } else {
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  void selectSellCurrency(int id) async {


    ResponseModel response = await currencyRepo.getSelected(id);

    buyCurrencyList.clear();
    tempbuyCurrencyList.clear();

    if (response.statusCode == 200) {
      BuyCurrencyModal model =
      BuyCurrencyModal.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<BuyCurrency> currency = model.data?.currencies ?? [];
        if (currency != null && currency.isNotEmpty) {
          buyCurrencyList.addAll(currency);
          tempbuyCurrencyList.addAll(currency);
        } else {
          // CustomSnackBar.error(
          //     errorList:
          //     model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    update();








    sendCurrencyID = id;
    selectedSendCurrency = tempsellCurrencyList.firstWhere((element) => element.id == id);

    // tempbuyCurrencyList.clear();
    //
    // List<BuyCurrency> newBuyCurrency = [];
    // for (var element in buyCurrencyList) {
    //   if(element.id.toString() != id.toString()){
    //     newBuyCurrency.add(element);
    //   }
    // }
    //
    // tempbuyCurrencyList.clear();
    // tempbuyCurrencyList.addAll(newBuyCurrency);
    //
    if (buyCurrencyID != null) {
      receiveAmountCount(double.tryParse(getingAmountController.text) ?? 0.0);
    }

    update();
  }

  void selectBuyCurrency(int id) async {

    ResponseModel response = await currencyRepo.getSelected2(id);

    sellCurrencyList.clear();
    tempsellCurrencyList.clear();

    if (response.statusCode == 200) {
      SellCurrencyModal model =
      SellCurrencyModal.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<SellCurrency> currency = model.data?.currencies ?? [];
        if (currency != null && currency.isNotEmpty) {
          sellCurrencyList.addAll(currency);
          tempsellCurrencyList.addAll(currency);
        } else {
          // CustomSnackBar.error(
          //     errorList:
          //     model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    update();




    buyCurrencyID = id;
    selectedbuyCurrency =
        tempbuyCurrencyList.firstWhere((element) => element.id == id);

    // tempsellCurrencyList.clear();
    //
    // List<SellCurrency> newSellCurrency = [];
    // for (var element in sellCurrencyList) {
    //   if(element.id.toString() != id.toString()){
    //     newSellCurrency.add(element);
    //   }
    // }
    //
    // tempsellCurrencyList.clear();
    // tempsellCurrencyList.addAll(newSellCurrency);

    if (sendCurrencyID != null && sendingAmountController.text.isNotEmpty) {
      sendAmountCount(double.parse(sendingAmountController.text));
    }

    update();
  }

  void receiveAmountCount(double val) {
    log('$sendCurrencyID, $buyCurrencyID');
    if (selectedSendCurrency != null && selectedbuyCurrency != null) {
      amountSend = 0;
      amountSend = double.parse(selectedbuyCurrency?.sellAt.toString() ?? '0.00') / double.parse(selectedSendCurrency?.buyAt.toString() ?? '0.00') * val;

      sendingAmountController.text = amountSend.toStringAsFixed(2);
      update();
    } else {
      amountSend = 0;
      update();
    }
  }

  void sendAmountCount(double val) {
    if (selectedSendCurrency != null && selectedbuyCurrency != null) {
      receiveAmount = 0;
      receiveAmount = double.parse(selectedSendCurrency?.buyAt.toString() ?? '0.00') / double.parse(selectedbuyCurrency?.sellAt.toString() ?? '0.00') * val;
      getingAmountController.text = receiveAmount.toStringAsFixed(2);
      update();
    } else {
      receiveAmount = 0;
      getingAmountController.text = val.toString();
      update();
    }
  }

  bool submitLoading = false;
  Future<void> createExchange() async {
    submitLoading = true;
    update();
    if (sendingAmountController.text.isNotEmpty && sendCurrencyID != null && buyCurrencyID != null) {
      ResponseModel responseModel = await exchangeRepo.createExchange(sendcurrencyID: sendCurrencyID.toString(), receveingCurrencyID: buyCurrencyID.toString(), amount: sendingAmountController.text);
      if (responseModel.statusCode == 200) {
        final CreateExchangeModal modal = CreateExchangeModal.fromJson(jsonDecode(responseModel.responseJson));
        if (modal.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
          CreateExchangeResponse? data = modal.data?.exchange;
          if (data != null) {
            final id = modal.data?.exchange?.id.toString();

            sendingAmountController.text = '';
            getingAmountController.text = '';
            walletIdController.text = '';

            Get.toNamed(RouteHelper.exchangePreview);
            await getPreviousExchange(id.toString());
          } else {
            CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
          }
        } else {
          CustomSnackBar.error(errorList: modal.message!.error ?? []);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } else {
      CustomSnackBar.error(errorList: ['Enter Your Details']);
    }
    submitLoading = false;
    update();
  }

  List<GlobalFormModel> formList = [];
  String selectedCurrencyID = "";
  final formKey = GlobalKey<FormState>();

  Future<void> getPreviousExchange(String id) async {
    isLoading = true;
    formList.clear();
    update();
    ResponseModel responseModel = await exchangeRepo.getExchangePrev(id.toString());
    if (responseModel.statusCode == 200) {
      PrevExchangeModal model = PrevExchangeModal.fromJson(jsonDecode(responseModel.responseJson));
      PrevExchange? data = model.data?.exchange;
      if (model.status == MyStrings.success) {
        if (data != null) {
          prevExchange = data;
          if (prevExchange.receivedCurrency?.userDetailsData?.formData?.list != null) {
            List<GlobalFormModel>? tempList = prevExchange.receivedCurrency?.userDetailsData?.formData?.list;
            if (tempList != null && tempList.isNotEmpty) {
              formList.clear();
              for (var element in tempList) {
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
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
      Get.back();
    }
    isLoading = false;
    update();
  }

  Future<void> confirmExchange({required String id}) async {
    isLoading = true;
    update();
    if (walletIdController.text.isNotEmpty) {
      confirm_exchange_modal.ConfirmExchangeModel responseModel = await exchangeRepo.confirmExchange(
        id: id,
        walletID: walletIdController.text,
        list: formList,
      );

      if (responseModel.status == MyStrings.success) {
        if (responseModel.data?.isAutometic == true) {
          if (responseModel.data?.redirectUrl != null) {
            Get.offAndToNamed(RouteHelper.autoPayementScreen, arguments: [responseModel.data?.redirectUrl]);
          }
        } else {
          Get.toNamed(RouteHelper.manualExchangeConfirmScreen, arguments: id);
        }
        CustomSnackBar.success(successList: responseModel.message!.success ?? []);
      } else {
        CustomSnackBar.error(errorList: responseModel.message!.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.enterBkashWalletNidNum]);
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
