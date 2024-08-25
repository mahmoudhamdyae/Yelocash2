import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/activity/widget/activiti_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ActivitiScreen extends StatefulWidget {
  const ActivitiScreen({super.key});

  @override
  State<ActivitiScreen> createState() => _ActivitiScreenState();
}

class _ActivitiScreenState extends State<ActivitiScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.bottomNavBar,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: MyColor.appBarColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: MyColor.colorWhite,
          systemNavigationBarIconBrightness: Theme.of(context).brightness,
        ),
        child: Scaffold(
          backgroundColor: MyColor.bg1,
          appBar: CustomAppBar(
            title: MyStrings.activity.tr,
            isShowBackBtn: false,
            titleStyle: heading.copyWith(color: MyColor.white),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: GetBuilder<DashboardController>(builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GetBuilder<HomeController>(builder: (homecontroller) {
                            return ActivitiCard(
                              imgPath: MyImages.wallet,
                              isusd: true,
                              name: MyStrings.currentBalance.tr,
                              value: '${homecontroller.defaultCurrencySymbol}${double.parse(controller.balance).toStringAsFixed(2)}',
                            );
                          }),
                          ActivitiCard(
                            imgPath: MyImages.check,
                            isusd: false,
                            name: MyStrings.approvedexchange.tr,
                            value: controller.exchangeCount.approved ?? '00',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ActivitiCard(
                            imgPath: MyImages.clock,
                            isusd: false,
                            name: MyStrings.pendingexchange.tr,
                            value: controller.exchangeCount.pending ?? '00',
                          ),
                          ActivitiCard(
                            imgPath: MyImages.cancel,
                            isusd: false,
                            name: MyStrings.cancelexchange.tr,
                            value: controller.exchangeCount.cancel ?? '00',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ActivitiCard(
                            imgPath: MyImages.refund,
                            isusd: false,
                            name: MyStrings.refundexchange.tr,
                            value: controller.exchangeCount.refunded ?? '00',
                          ),
                          ActivitiCard(imgPath: MyImages.exchange, isusd: false, name: MyStrings.totalexchange.tr, value: controller.exchangeCount.total ?? '00'),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
