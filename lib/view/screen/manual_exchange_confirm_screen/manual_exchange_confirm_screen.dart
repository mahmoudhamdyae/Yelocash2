import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/exchange/manual_exchange_confirm_controller.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/screen/manual_exchange_confirm_screen/widget/manual_exchange_kyc_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualExchangeConfirmScreen extends StatefulWidget {
  const ManualExchangeConfirmScreen({super.key});

  @override
  State<ManualExchangeConfirmScreen> createState() => _ManualExchangeConfirmScreenState();
}

class _ManualExchangeConfirmScreenState extends State<ManualExchangeConfirmScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExchangeRepo(apiClient: Get.find()));
    final controller = Get.put(ManualExchangeConfirmController(exchangeRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String exchangeId = Get.arguments;
      controller.initData(exchangeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          bgColor: MyColor.appBarColor,
          title: MyStrings.payment.tr,
          titleStyle: heading.copyWith(color: MyColor.white),
        ),
        body: GetBuilder<ManualExchangeConfirmController>(builder: (controller) {
          return controller.isLoading ? const CustomLoader() : const SingleChildScrollView(padding: EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12), child: ManualExchangeConfirmKYCSection());
        }));
  }
}
