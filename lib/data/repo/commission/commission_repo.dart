

import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/service/api_service.dart';

class CommissionRepo {
  ApiClient apiClient;
  CommissionRepo({required this.apiClient});

  Future<ResponseModel> getCommissions(int page) async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.commissionLog}?page=$page';
    final response =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }
}
