import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:changa_lab/data/controller/exchange/exchangeController.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/controller/localization/localization_controller.dart';
import 'package:changa_lab/data/repo/currency/currency_repo.dart';
import 'package:changa_lab/data/repo/dashboard/dashboard_repo.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/repo/home/home_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/home_appBar.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/home_body_widget.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/home_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    Get.put(ExchangeRepo(apiClient: Get.find()));
    Get.put(ExchangeController(exchangeRepo: Get.find()));
    Get.put(DashBoardRepo(apiClient: Get.find()));
    Get.put(DashboardController(dashBoardRepo: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    Get.put(CurrencyRepo(apiClient: Get.find()));

    final controller = Get.put(HomeController(
      homeRepo: Get.find(),
      exchangeRepo: Get.find(),
      currencyRepo: Get.find(),
      dashboardController: Get.find(),
    ));
    //
    controller.isLoading = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return controller.isLoading
          ? const CustomLoader()
          : WillPopWidget(
              nextRoute: '',
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: MyColor.appBarColor,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: MyColor.colorWhite,
                  systemNavigationBarIconBrightness: Theme.of(context).brightness,
                ),
                child: const Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          HomeAppBar(),
                          HomeBodyWidget(),
                          HomeForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
