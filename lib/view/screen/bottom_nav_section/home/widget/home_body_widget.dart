import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/TodaysRate.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/latest_exchange/latest_exchange_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (exchangeController) {
      return Container(
        margin: const EdgeInsets.only(
          top: 666,
        ),
        padding: const EdgeInsets.all(Dimensions.screenAllPadding),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            exchangeController.latestExchanges.isEmpty
                ? const SizedBox.shrink()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyStrings.latestExchange.tr,
                  style: heading.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.Text16,
                    color: const Color(0xff1E2329),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.exchange);
                  },
                  child: Text(
                    MyStrings.viewAll.tr,
                    style: GoogleFonts.cairo(
                      color: const Color(0xffF0B90B),
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.Text12,
                    ),
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
              height: Dimensions.space8,
            ),
            Text(
              MyStrings.exchangeRateToday.tr,
              style: heading,
            ),
            const SizedBox(
              height: 16,
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
