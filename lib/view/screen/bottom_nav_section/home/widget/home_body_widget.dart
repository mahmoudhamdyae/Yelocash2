import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/dashboard/dashboard_controller.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/kyc_warning_section.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/TodaysRate.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/latest_exchange/latest_exchange_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (exchangeController) {
      return Container(
        margin: const EdgeInsets.only(
          top: 420,
        ),
        padding: const EdgeInsets.all(Dimensions.screenAllPadding),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             GetBuilder<DashboardController>(builder: (dashBoardController)=> KYCWarningSection(controller: dashBoardController)),
            exchangeController.latestExchanges.isEmpty
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        MyStrings.latestExchange.tr,
                        style: heading,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelper.exchange);
                        },
                        child: Text(
                          MyStrings.viewAll.tr,
                          style: bodyText.copyWith(color: MyColor.primary),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            exchangeController.latestExchanges.isEmpty
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        exchangeController.latestExchanges.length,
                        (index) => LatestExchangeCard(
                          exchange: exchangeController.latestExchanges[index],
                          imgPath: exchangeController.imageUrl,
                        ),
                      ),
                    )),
            const SizedBox(
              height: Dimensions.space12,
            ),
            Text(
              MyStrings.exchangeRateToday.tr,
              style: heading,
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<HomeController>(builder: (controller) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.currencyList.length,
                itemBuilder: (context, i) {
                  return TodaysRate(
                    currency: controller.currencyList[i],
                    imgpath:
                        '${controller.imagePath}/${controller.currencyList[i].image}',
                  );
                },
              );
            }),
          ],
        ),
      );
    });
  }
}
