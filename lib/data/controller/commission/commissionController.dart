import 'dart:convert';
import 'dart:developer';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/commission_log/commission_log_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/commission/commission_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class CommissionController extends GetxController {
  CommissionRepo commissionRepo;
  CommissionController({required this.commissionRepo});
  //data variables
  List<Commission> commissionList = [];
  bool isLoading = false;
  String currency = "";
  String currencySym = "";
  String nextPageUrl = "null";
  int page = 0;

  Future<void> initialValue() async {
    isLoading = true;
    page = 1;
    commissionList.clear();
    currency = commissionRepo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym =
        commissionRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    //
    update();
    await getCommission();
    isLoading = false;
    update();
  }

  Future<void> loadPaginationData() async {
    page = page + 1;
    log('Pagination $page');
    await getCommission();
    update();
  }

  // get all commission
  Future<void> getCommission() async {
    isLoading = true;

    update();
    ResponseModel responseModel = await commissionRepo.getCommissions(page);
    if (responseModel.statusCode == 200) {
      CommissionLogModel model =
          CommissionLogModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Commission>? tempData = model.data?.commission?.data;
      if (model.status == MyStrings.success) {
        if (tempData != null) {
          log(tempData.length.toString());
          commissionList.addAll(tempData);
        }
      } else {
        CustomSnackBar.error(errorList: model.message!.error ?? []);
      }
    } else {
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
      Get.back();
    }
    isLoading = false;
    update();
  }

  bool hasNext() {
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }
}
