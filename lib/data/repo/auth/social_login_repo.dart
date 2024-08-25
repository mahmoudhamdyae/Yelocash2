import 'dart:convert';
import 'package:changa_lab/core/utils/method.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/model/global/response_model/response_model.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class SocialLoginRepo {

  ApiClient apiClient;

  SocialLoginRepo({ required this.apiClient});

  Future<ResponseModel> socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    Map<String, String>? map;

    if (provider == 'google') {
      map = {'token': accessToken, 'provider': "google"};
    }

    if (provider == 'linkedin') {
      map = {'token': accessToken, 'provider': "linkedin"};
    }

    if (provider == 'facebook') {
      map = {'token': accessToken, 'provider': "facebook"};
    }

    String url = '${UrlContainer.baseUrl}${UrlContainer.socialLoginEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;

  }



}
