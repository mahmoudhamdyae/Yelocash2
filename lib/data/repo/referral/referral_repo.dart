

import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/service/api_service.dart';

class ReferralRepo{
  ApiClient apiClient;
  ReferralRepo({required this.apiClient});

  Future<ResponseModel> getReferralData()async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.referralEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;

  }
}