import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/service/api_service.dart';

class HomeRepo {
  ApiClient apiClient;
  HomeRepo({required this.apiClient});
  // TODO:Get All Currency
  Future<dynamic> getAllCurrency() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.currencyUrl}';
    ResponseModel response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
  // TODO:Sell
}
