import 'dart:convert';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/dashboard/dashboard_response_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/dashboard/dashboard_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController {
  DashBoardRepo dashBoardRepo;
  DashboardController({required this.dashBoardRepo});

  bool isLoading = false;
  ExchangeCount exchangeCount = ExchangeCount();
  String balance = "0.00";
  String isKycVerified = '1';
  Future<void> getDashboardData() async {
    isLoading = true;
    update();

    ResponseModel response = await dashBoardRepo.getDashBoard();
    if (response.statusCode == 200) {
      DashBoardResponseModel model = DashBoardResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status == MyStrings.success) {
        final tempExchange = model.data?.exchangeCount;
        balance = model.data?.balance ?? '0';
        isKycVerified = model.data?.user?.kv?? '0';
        if (tempExchange != null) {
          exchangeCount = tempExchange;
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
