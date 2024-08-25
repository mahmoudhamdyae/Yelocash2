

import 'package:changa_lab/data/service/api_service.dart';

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';

class FaqRepo{

  ApiClient apiClient;
  FaqRepo({required this.apiClient});

  Future<dynamic>loadFaq()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.faqEndPoint}';
    final response=await apiClient.request(url,Method.getMethod,null);
    return response;
  }

}