import 'dart:convert';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/commission_log/commission_log_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/model/referral/referral_model.dart';
import 'package:changa_lab/data/repo/referral/referral_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReferralController extends GetxController {
  ReferralRepo referralRepo;
  ReferralController({required this.referralRepo});

  bool isLoading = true;
  List<User> referralList = [];

  String? refferalLink;
  int page = 0;
  String searchReferrals = "";

  TextEditingController searchController = TextEditingController();

  void initData() async {
    await allReferralsData();
    isLoading = false;
    update();
  }

  void loadPaginationData() async {
    await allReferralsData();
    update();
  }

  void searchReferral() async {
    filterLoading = true;
    update();
    page = 0;
    referralList.clear();
    searchReferrals = searchController.text;
    await allReferralsData();
    filterLoading = false;
    
    update();
  }

  Future<void> allReferralsData() async {
    
      referralList.clear();
  

    ResponseModel responseModel = await referralRepo.getReferralData();

    if (responseModel.statusCode == 200) {
      ReferralModel referralModel = ReferralModel.fromJson(jsonDecode(responseModel.responseJson));

      refferalLink = referralModel.data?.affiliateLink;

      if (referralModel.status.toString().toLowerCase() == "success") {
        List<User>? tempList = referralModel.data?.user?.allReferrals ?? [];
        
        if (tempList != null && tempList.isNotEmpty) {
          referralList.addAll(tempList);
        }
        isLoading = false;
        
        update();
      } else {
        CustomSnackBar.error(errorList: referralModel.message?.error ?? [MyStrings.somethingWentWrong]);
        return;
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      return;
    }
  }

  bool isSearch = false;
  void changeSearchStatus() {
    isSearch = !isSearch;
    if (!isSearch) {
      searchController.text = '';
      filterData();
    }
    update();
  }

  bool filterLoading = false;
  Future<void> filterData() async {
    searchReferrals = searchController.text;
    page = 0;
    filterLoading = true;
    update();
    await allReferralsData();
    filterLoading = false;
    update();
  }

  bool hasNext() {
    return refferalLink != null && refferalLink!.isNotEmpty && refferalLink != 'null' ? true : false;
  }
}
