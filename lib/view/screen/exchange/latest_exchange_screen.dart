import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/exchange/exchangeController.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/screen/exchange/widget/exchange_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeListScreen extends StatefulWidget {
  const ExchangeListScreen({super.key});

  @override
  State<ExchangeListScreen> createState() => _ExchangeListScreenState();
}

class _ExchangeListScreenState extends State<ExchangeListScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<ExchangeController>().getAllExchanges();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<ExchangeController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExchangeRepo(apiClient: Get.find()));
    final exchange = Get.put(ExchangeController(exchangeRepo: Get.find()));
    //
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      exchange.page = 0;
      exchange.getAllExchanges();
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
      backgroundColor: MyColor.bg1,
      appBar: CustomAppBar(
        title: MyStrings.latestExchange.tr,
        bgColor: MyColor.primary,
        titleStyle: bodyText.copyWith(color: MyColor.white),
      ),
      body: GetBuilder<ExchangeController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.latestExchanges.length + 1,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    if (i == controller.latestExchanges.length) {
                      return controller.hasNext()
                          ? Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5),
                              child: const CustomLoader(
                                isPagination: true,
                              ),
                            )
                          : const SizedBox();
                    }
                    return ExchangeCard(
                      exchange: controller.latestExchanges[i],
                      imgPath: controller.imageurl,
                    );
                  },
                ),
              );
      }),
    );
  }
}
