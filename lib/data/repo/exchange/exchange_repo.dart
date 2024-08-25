// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer';

import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/authorization/authorization_response_model.dart';
import 'package:changa_lab/data/model/exchange/confirm_exchange_modal.dart' as confirm_exchange_modal;
import 'package:changa_lab/data/model/exchange/exchange_prev_modal.dart';
import 'package:changa_lab/data/model/exchange/manual_exchange_response_model.dart' as manual_exchange_confirm_Model;
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/data/model/global/meassage_model.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/repo/kyc/kyc_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:http/http.dart' as http;

class ExchangeRepo {
  ApiClient apiClient;

  ExchangeRepo({required this.apiClient});

  Future<ResponseModel> getAllExchanges(int page) async {
    final url = '${UrlContainer.baseUrl}${UrlContainer.exchangeUrl}?page=$page';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> getExchangeById(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.exchangeDetails}${id.toString()}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> trackExchange(String exchangeID) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.trackExchange}';
    final body = {'exchange_id': exchangeID};
    final response = await apiClient.request(url, Method.postMethod, body, passHeader: true);
    return response;
  }

  Future<ResponseModel> getExchangePrev(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.preview}${id.toString()}';
    log(url.toString());
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> getExchangeHistory(int page, int id) async {
    var url = '${UrlContainer.baseUrl}${UrlContainer.exchangeHistory}?page=$page';
    if (id == 1) {
      url = '${UrlContainer.baseUrl}${UrlContainer.approved}?page=$page';
      //  approve exchange
    } else if (id == 2) {
      url = '${UrlContainer.baseUrl}${UrlContainer.pending}?page=$page';
      //  pending exchange
    } else if (id == 3) {
      url = '${UrlContainer.baseUrl}${UrlContainer.refunded}?page=$page';
      //  refund exchange
    } else if (id == 4) {
      url = '${UrlContainer.baseUrl}${UrlContainer.canceled}?page=$page';
    }

    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> createExchange({required String sendcurrencyID, required String receveingCurrencyID, required String amount}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.create}';

    final body = {'sending_currency': sendcurrencyID, 'receiving_currency': receveingCurrencyID, 'sending_amount': amount};

    final response = await apiClient.request(url, Method.postMethod, body, passHeader: true);
    return response;
  }

  Future<ResponseModel> prevExchange(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.preview}${id.toString()}';
    final response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  List<Map<String, String>> fieldList = [];
  List<ModelDynamicValue> filesList = [];

  Future<dynamic> confirmExchange({
    required String walletID,
    required String id,
    required List<GlobalFormModel> list,
  }) async {
    try {
      String url = '${UrlContainer.baseUrl}${UrlContainer.confirm}$id';

      apiClient.initToken();
      if (list.isNotEmpty) {
        await modelToMap(list);
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));
      Map<String, String> finalMap = {
        "wallet_id": walletID,
      };

      for (var element in fieldList) {
        finalMap.addAll(element);
      }

      request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

      for (var file in filesList) {
        request.files.add(http.MultipartFile(file.key ?? '', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
      }

      request.fields.addAll(finalMap);
      http.StreamedResponse response = await request.send();
      String jsonResponse = await response.stream.bytesToString();

      confirm_exchange_modal.ConfirmExchangeModel model = confirm_exchange_modal.ConfirmExchangeModel.fromJson(jsonDecode(jsonResponse));

      return model;
    } catch (e) {
      return confirm_exchange_modal.ConfirmExchangeModel(status: 'error', message: Message(error: [e.toString()]));
    }
  }

  Future<ResponseModel> getManualExchangeResponse(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.exchangeManualConfirm}$id';
    final response = await apiClient.request(url, Method.getMethod, {}, passHeader: true);
    return response;
  }

  Future<AuthorizationResponseModel> submitConfirmManualExchangeData(List<GlobalFormModel> list, String exchangeId) async {
    apiClient.initToken();
    await modelToMap(list);
    String url = '${UrlContainer.baseUrl}${UrlContainer.exchangeManualConfirm}$exchangeId';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String> finalMap = {};

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add(http.MultipartFile(file.key ?? '', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    request.fields.addAll(finalMap);
    http.StreamedResponse response = await request.send();

    String jsonResponse = await response.stream.bytesToString();
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    return model;
  }

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
          fieldList.add({e.label ?? '': e.selectedValue.toString()});
        }
      }
    }
  }
}
