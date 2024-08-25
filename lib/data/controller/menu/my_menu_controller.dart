import 'dart:convert';
import 'package:changa_lab/data/model/authorization/authorization_response_model.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/general_setting/general_setting_response_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/auth/general_setting_repo.dart';
import 'package:changa_lab/data/repo/menu_repo/menu_repo.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';

class MyMenuController extends GetxController{

  MenuRepo menuRepo;
  GeneralSettingRepo repo;
  MyMenuController({required this.menuRepo, required this.repo});

  bool logoutLoading = false;
  bool isLoading     = true;
  bool noInternet    = false;

  bool balTransferEnable = true;
  bool langSwitchEnable  = true;

  void loadData()async{

    isLoading = true;
    update();

    //await configureMenuItem();
    isLoading = false;
    update();

  }
  bool removeLoading = false;
  Future<void> removeAccount() async {
    removeLoading = true;
    update();

      final responseModal = await menuRepo.removeAccount();
      if (responseModal.statusCode == 200) {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModal.responseJson));
        if (model.status?.toLowerCase() == MyStrings.success) {
          await menuRepo.clearSharedPrefData();
          Get.offAllNamed(RouteHelper.loginScreen);
          CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.accountDeletedSuccessfully]);
        } else {
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModal.message]);
      }


    removeLoading = false;
    update();
  }

  Future<void>logout()async{
    logoutLoading = true;
    update();

    await menuRepo.logout();
    CustomSnackBar.success(successList: [MyStrings.logoutSuccessMsg]);

    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);

  }

  bool isTransferEnable = true;
  bool isWithdrawEnable = true;
  bool isInvoiceEnable  = true;


  // configureMenuItem() async{

  //   update();
  //   ResponseModel response = await repo.getGeneralSetting();
  //   if(response.statusCode==200){
  //     GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
  //     if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
  //       bool langStatus  = model.data?.generalSetting?.enableLanguage == '0' ? false: true;
  //       langSwitchEnable = langStatus;
  //       repo.apiClient.storeGeneralSetting(model);
  //       update();
  //     }
  //     else {
  //       List<String>message=[MyStrings.somethingWentWrong];
  //       CustomSnackBar.error(errorList:model.message?.error??message);
  //       return;
  //     }
  //   }else{
  //     if(response.statusCode==503){
  //       //noInternet=true;
  //       update();
  //     }
  //     CustomSnackBar.error(errorList:[response.message]);
  //     return;
  //   }
  // }
}