import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/data/controller/exchange/exchangeController.dart';
import 'package:changa_lab/view/components/custom_no_data_found_class.dart';

import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/history_exchange/historyExchangeController.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:changa_lab/view/components/card/custom_card.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/image/custom_svg_picture.dart';
import 'package:changa_lab/view/screen/exchange_history/widget/exchange_history_card.dart';
import 'package:changa_lab/view/screen/exchange_history/widget/exchange_history_filter.dart';
import 'package:changa_lab/view/screen/traceexchagne/widget/trace_exchange_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeHistory extends StatefulWidget {
  const ExchangeHistory({super.key});

  @override
  State<ExchangeHistory> createState() => _ExchangeHistoryState();
}

class _ExchangeHistoryState extends State<ExchangeHistory> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<HistoryExchangeController>().getExchangeHistory();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<HistoryExchangeController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExchangeRepo(apiClient: Get.find()));
    final controller =
        Get.put(HistoryExchangeController(exchangeRepo: Get.find()));
    final exchangecontroller =
        Get.put(ExchangeController(exchangeRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      exchangecontroller.trackExchangeController.clear();
      controller.page = 0;
      controller.changeIndex(0);
      controller.getExchangeHistory();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // bgColor: ,
        title: MyStrings.exchangeHistory.tr,
        titleStyle: heading.copyWith(color: MyColor.white),
        isShowBackBtn: true,
        action: [
          GestureDetector(
            onTap: () {
              CustomBottomSheet(child: const TraceExchangeBottomSheet())
                  .customBottomSheet(context);
            },
            child: Center(
              child: Text(
                MyStrings.traceExchange.tr,
                style: bodyText.copyWith(color: MyColor.white, fontSize: 10),
              ),
            ),
          ),
          const SizedBox(
            width: Dimensions.space10,
          ),
          Container(
            color: const Color(0xFFB1B1B1),
            height: 14,
            width: 1,
          ),
          const SizedBox(
            width: Dimensions.space10,
          ),
          GestureDetector(
            onTap: () {

              CustomBottomSheet(child: const ExchangeHistoryFilter())
                  .customBottomSheet(context);
            },
            child: const CustomSvgPicture(
              image: MyImages.setting,
              width: 20,
              height: 20,
              color: MyColor.white,
            ),
          ),
          const SizedBox(
            width: Dimensions.space10,
          ),
        ],
      ),
      body: GetBuilder<HistoryExchangeController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : controller.historyExchange.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: controller.historyExchange.length + 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        if (i == controller.historyExchange.length) {
                          return controller.hasNext()
                              ? Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(5),
                                  child: const CustomLoader())
                              : const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomCard(
                            width: MediaQuery.of(context).size.width,
                            child: ExchangeHistoryCard(
                              historyExchange: controller.historyExchange[i],
                              imagePath: controller.imageurl,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const NoDataOrInternetScreen();
      }),
    );
  }
}
