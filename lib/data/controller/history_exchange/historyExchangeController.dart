import 'dart:convert';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/exchange/exchange_history_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class HistoryExchangeController extends GetxController {
  ExchangeRepo exchangeRepo;
  HistoryExchangeController({required this.exchangeRepo});
  //
  bool isLoading = false;
  List<HistoryExchange> historyExchange = [];
  String imageurl = '';
  int page = 0;
  String? nextPageUrl = '';
  int index = 0;

  void changeIndex(int id) {
    index = id;
    page = 0;
    update();
  }

  // exchange history
  Future<void> getExchangeHistory() async {
    isLoading = true;

    page = page + 1;

    update();
    ResponseModel responseModel =
        await exchangeRepo.getExchangeHistory(page, index);
    if (responseModel.statusCode == 200) {
      ExchangeHistoryModel model =
          ExchangeHistoryModel.fromJson(jsonDecode(responseModel.responseJson));

      nextPageUrl = model.data?.exchanges?.nextPageUrl;

      if (model.status == MyStrings.success) {
        List<HistoryExchange>? tempData = model.data!.exchanges!.data;
        imageurl = model.data?.imagePath ?? '';

        if (tempData != null) {
          historyExchange = tempData;
        }
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
        );
      }
    } else {
      CustomSnackBar.error(
        errorList: [responseModel.message],
      );
    }
    isLoading = false;
    update();
  }

  //
  bool hasNext() {
    return nextPageUrl != null &&
            nextPageUrl!.isNotEmpty &&
            nextPageUrl != 'null'
        ? true
        : false;
  }
}
