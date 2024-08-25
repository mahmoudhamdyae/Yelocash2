import 'dart:convert';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/currency/buy_currency_modal.dart';
import 'package:changa_lab/data/model/currency/currency_model.dart';
import 'package:changa_lab/data/model/currency/sell_currency_modal.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/currency/currency_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  CurrencyRepo currencyRepo;
  CurrencyController({required this.currencyRepo});

  bool isLoading = false;
  String imagePath = "";

  List<Currency> currencyList = [];
  List<SellCurrency> sellCurrencyList = [];
  List<BuyCurrency> buyCurrencyList = [];

  Future<void> getAllCurrency() async {
    isLoading = true;
    update();
    ResponseModel response = await currencyRepo.getAllCurrency();
    if (response.statusCode == 200) {
      CurrencyModel model =
          CurrencyModel.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<Currency>? currency = model.data?.currencies;
        if (currency != null && currency.isNotEmpty) {
          currencyList.addAll(currency);
          imagePath = model.data!.imagePath!;
        } else {
          CustomSnackBar.error(
              errorList:
                  model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> sellCurrency() async {
    isLoading = true;
    update();
    ResponseModel response = await currencyRepo.sellCurrency();
    if (response.statusCode == 200) {
      SellCurrencyModal model =
          SellCurrencyModal.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<SellCurrency>? currency = model.data?.currencies;
        if (currency != null && currency.isNotEmpty) {
          sellCurrencyList.addAll(currency);
          imagePath = model.data!.imagePath!;
        } else {
          CustomSnackBar.error(
              errorList:
                  model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(
            errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
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
    if (response.statusCode == 200) {
      BuyCurrencyModal model = BuyCurrencyModal.fromJson(jsonDecode(response.responseJson));

      if (model.status == MyStrings.success) {
        List<BuyCurrency>? currency = model.data?.currencies;
        if (currency != null && currency.isNotEmpty) {
          buyCurrencyList.addAll(currency);
          imagePath = model.data!.imagePath!;
        } else {
          CustomSnackBar.error(errorList:model.message?.error ?? [MyStrings.somethingWentWrong]);
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

}
