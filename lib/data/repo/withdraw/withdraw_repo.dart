import 'dart:convert';
import 'package:changa_lab/core/utils/method.dart' as request;
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/authorization/authorization_response_model.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/model/withdraw/withdraw_request_response_model.dart';
// import 'package:changa_lab/data/model/kyc/kyc_response_model.dart';
import 'package:changa_lab/data/repo/kyc/kyc_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:http/http.dart' as http;

class WithdrawRepo {
  ApiClient apiClient;
  WithdrawRepo({required this.apiClient});

  Future<dynamic> getAllWithdrawMethod() async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.withdraw}${UrlContainer.widthrawCurrency}';
    ResponseModel responseModel = await apiClient
        .request(url, request.Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> getWithdrawConfirmScreenData(String trxId) async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.withdrawConfirmScreenUrl}$trxId';
    ResponseModel responseModel = await apiClient
        .request(url, request.Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  // Future<ResponseModel> createWithdrawRequest() async {
  //   String url = '${UrlContainer.baseUrl}${UrlContainer.addWithdrawRequestUrl}';
  //   ResponseModel responseModel = await apiClient
  //       .request(url, request.Method.postMethod, {}, passHeader: true);
  //   return responseModel;
  // }

  List<Map<String, String>> fieldList = [];
  List<ModelDynamicValue> filesList = [];

  Future<dynamic> confirmWithdrawRequest({
    required String currency,
    required List<GlobalFormModel> list,
    required String sendAmount,
  }) async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.withdraw}${UrlContainer.widthrawSave}';

    apiClient.initToken();
    await modelToMap(list);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> finalMap = {
      "currency": currency,
      "send_amount": sendAmount,
    };

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add(http.MultipartFile(file.key ?? '',
          file.value.readAsBytes().asStream(), file.value.lengthSync(),
          filename: file.value.path.split('/').last));
    }

    request.fields.addAll(finalMap);
    http.StreamedResponse response = await request.send();
    String jsonResponse = await response.stream.bytesToString();
    AuthorizationResponseModel model =
        AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    return model;
  }

  // Future<ResponseModel> getAllWithdrawHistory(int page,
  //     {String searchText = ""}) async {
  //   String url =
  //       "${UrlContainer.baseUrl}${UrlContainer.withdrawHistoryUrl}?page=$page&search=$searchText";
  //   ResponseModel responseModel = await apiClient
  //       .request(url, request.Method.getMethod, null, passHeader: true);
  //   return responseModel;
  // }

  Future<dynamic> modelToMap(List<GlobalFormModel> list) async {
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
}
