import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/data/model/general_setting/general_setting_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  List<String> onboardTitleList = [
    'Currency buying and selling log.',
    'Exchange any currency from everywhere.',
    'Premium and quick support.',
  ];


  List<String> onboardSubtitleList = [
    'Offering rapid, trustworthy, and global digital currency exchange services.',
    'Experience efficient and secure digital currencies exchange worldwide.',
    'Bridging global markets with local support for digital currency exchanges.',
  ];

  List<String> onboardImageList = [
    MyImages.onboard1,
    MyImages.onboard2,
    MyImages.onboard3,
  ];

  bool isLoading = true;

  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  List<String> onBoardImage = [];
}
