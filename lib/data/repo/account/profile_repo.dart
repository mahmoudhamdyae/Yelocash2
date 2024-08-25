
import 'dart:convert';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/authorization/authorization_response_model.dart';
import 'package:changa_lab/data/model/kyc/kyc_response_model.dart';
import 'package:changa_lab/data/model/profile/profile_complete_post_model.dart';
import 'package:changa_lab/data/model/user_post_model/user_post_model.dart';
import 'package:changa_lab/data/repo/kyc/kyc_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/push_notification_service.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  
  List<Map<String, String>> fieldList = [];
  List<ModelDynamicValue> filesList = [];
  
 Future<bool> updateProfile(UserPostModel m, bool isProfile, {List<KycFormModel>? list}) async {
    try {
      apiClient.initToken();
      await modelToMap(list ?? []);
      String url = '${UrlContainer.baseUrl}${isProfile ? UrlContainer.updateProfileEndPoint : UrlContainer.profileCompleteEndPoint}';

      var request = http.MultipartRequest('POST', Uri.parse(url));

      Map<String, String> finalMap = {};

      for (var element in fieldList) {
        finalMap.addAll(element);
      }

      finalMap['firstname'] = m.firstname;
      finalMap['lastname'] = m.lastName;
      finalMap['address'] = m.address ?? '';
      finalMap['zip'] = m.zip ?? '';
      finalMap['state'] = m.state ?? "";
      finalMap['city'] = m.city ?? '';

      request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

      for (var file in filesList) {
        request.files.add(http.MultipartFile(file.key ?? '', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
      }

      if (m.image != null) {
        request.files.add(http.MultipartFile('image', m.image!.readAsBytes().asStream(), m.image!.lengthSync(), filename: m.image!.path.split('/').last));
      }
      request.fields.addAll(finalMap);

      http.StreamedResponse response = await request.send();

      String jsonResponse = await response.stream.bytesToString();
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.success]);
        return true;
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail.tr]);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: ${e.toString()}');
      }
      return false;
    }
  }

  Future<dynamic> modelToMap(List<KycFormModel> list) async {
    for (var e in list) {
      if (e.type == 'checkbox') {
        if (e.cbSelected != null && e.cbSelected!.isNotEmpty) {
          for (int i = 0; i < e.cbSelected!.length; i++) {
            fieldList.add({'${e.label}[$i]': e.cbSelected![i]});
          }
        }
      } else if (e.type == 'file') {
        if (e.imageFile != null) {
          filesList.add(ModelDynamicValue(e.label, e.imageFile!));
        }
      } else {
        if (e.selectedValue != null && e.selectedValue.toString().isNotEmpty) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      }
    }
  }
 
 
  Future<ResponseModel> completeProfile(ProfileCompletePostModel model) async {
    dynamic params = model.toMap();
    String url = '${UrlContainer.baseUrl}${UrlContainer.profileCompleteEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> loadProfileInfo() async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;

  }

   Future<dynamic> getCountryList() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }
   Future<void> updateDeviceToken() async {
    await PushNotificationService(apiClient: Get.find()).sendUserToken();
  }
}
