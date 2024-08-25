
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/exchange/exchangeController.dart';
import 'package:changa_lab/data/model/exchange/exchange_model.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/screen/exchange_details/widget/exchange_received_details.dart';
import 'package:changa_lab/view/screen/exchange_details/widget/exchange_send_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeDetailsScreen extends StatefulWidget {
  const ExchangeDetailsScreen({super.key});

  @override
  State<ExchangeDetailsScreen> createState() => _ExchangeDetailsScreenState();
}

class _ExchangeDetailsScreenState extends State<ExchangeDetailsScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    int id = Get.arguments[0];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExchangeRepo(apiClient: Get.find()));
    final controller = Get.put(ExchangeController(exchangeRepo: Get.find()));
    controller.exchangeDetails = ExchangeModel();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.dawnloadURL;
      controller.getExchangeByID(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bg1,
      appBar: CustomAppBar(
        isShowBackBtn: true,
        title: MyStrings.exchangeDetails.tr,
        titleStyle: heading.copyWith(color: MyColor.white),
      ),
      body: GetBuilder<ExchangeController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                child: DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.space10,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.unslectedTab,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TabBar(
                            onTap: (i) {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            splashBorderRadius: BorderRadius.circular(25),
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(25), // Creates border
                              color: MyColor.title,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: MyColor.white,
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            unselectedLabelColor: MyColor.title,
                            tabs: [
                              Tab(
                                text: MyStrings.sending.tr,
                              ),
                              Tab(
                                text: MyStrings.receiveing.tr,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.space20,
                        ),
                        Builder(builder: (_) {
                          if (selectedIndex == 0) {
                            return ExchangeSendingDetails(
                              exchange: controller.exchangeDetails,
                            );
                          } else {
                            return ExchangeReceivedDetails(
                              exchange: controller.exchangeDetails,
                            );
                          }
                        }),
                        const SizedBox(
                          height: Dimensions.space20,
                        ),
                        RoundedButton(
                          text: MyStrings.downloading.tr.toUpperCase(),
                          press: () {
                            controller.downloadAttachment(
                                controller.dawnloadURL.toString(), context);
                          },
                          isOutlined: true,
                        )
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
