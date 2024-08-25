import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/service/api_service.dart';

class DashBoardRepo {
  ApiClient apiClient;
  DashBoardRepo({required this.apiClient});
  //

  Future<ResponseModel> getDashBoard() async {
    String url = UrlContainer.baseUrl + UrlContainer.dashBoardUrl;
    return await apiClient.request(url,Method.getMethod,{},passHeader: true);
  }
}
