import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/service/api_service.dart';

class CurrencyRepo {
  ApiClient apiClient;
  CurrencyRepo({required this.apiClient});

  // All currencies
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
  // Sell currencies
   Future<dynamic> sellCurrency() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.currencyUrl}${UrlContainer.currencySell}';
    ResponseModel response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
    // Buy currencies
   Future<dynamic> buyCurrency() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.currencyUrl}${UrlContainer.currencyBuy}';
    ResponseModel response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
