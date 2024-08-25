import 'package:changa_lab/data/controller/common/theme_controller.dart';
import 'package:changa_lab/data/controller/splash/splashController.dart';
import 'package:changa_lab/data/repo/splash/splashRepo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:changa_lab/data/controller/localization/localization_controller.dart';

import 'package:changa_lab/data/repo/auth/general_setting_repo.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      SplashController(repo: Get.find(), localizationController: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};

  return language;
}
