import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/exchange/exchangeController.dart';
import 'package:changa_lab/data/model/exchange/exchange_model.dart';
import 'package:changa_lab/data/repo/exchange/exchange_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/divider/custom_divider.dart';
import 'package:changa_lab/view/screen/exchange_prevew/widget/saveing_list_tile.dart';
import 'package:changa_lab/view/screen/traceexchagne/widget/track_exchange_receiveing_details.dart';
import 'package:changa_lab/view/screen/traceexchagne/widget/track_sending_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TraceExchangeScreen extends StatefulWidget {
  const TraceExchangeScreen({super.key});

  @override
  State<TraceExchangeScreen> createState() => _TraceExchangeScreenState();
}

class _TraceExchangeScreenState extends State<TraceExchangeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    // int id = Get.arguments[0];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ExchangeRepo(apiClient: Get.find()));
    final controller = Get.put(ExchangeController(exchangeRepo: Get.find()));
    controller.exchangeDetails = ExchangeModel();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.getExchangeByID(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trace Your Exchange',
        titleStyle: heading.copyWith(
          color: MyColor.white,
        ),
      ),
      body: GetBuilder<ExchangeController>(builder: (controller) {
        return SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space5,
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
                        borderRadius: BorderRadius.circular(25), // Creates border
                        color: MyColor.title,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: MyColor.white,
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
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
                      return TrackExchangeSendingDetails(
                        exchange: controller.traceExchange,
                      );
                    } else {
                      return TrackExchangeReceivedDetails(
                        exchange: controller.traceExchange,
                      );
                    }
                  }),
                  const SizedBox(
                    height: Dimensions.space2,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric( vertical: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: MyColor.bg1,
                      border: Border.all(color: MyColor.primaryColor.withOpacity(.1)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(MyStrings.status.tr.toUpperCase(), style: bodyText),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.traceExchange.status == "2" ? MyColor.pendingColor : MyColor.redCancelTextColor,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                controller.traceExchange.status == "2" ? MyStrings.pending.tr : MyStrings.cancel.tr,
                                style: bodyText.copyWith(
                                  fontSize: 10,
                                  color: controller.traceExchange.status == "2" ? MyColor.pendingColor : MyColor.redCancelTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.space20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('${MyStrings.your.tr} ${controller.traceExchange.sendCurrency?.name??''} ${MyStrings.walletNidNum}'.toUpperCase(),maxLines: 2, style: bodyText)),
                            const SizedBox(width: Dimensions.space20),
                            Text(
                              controller.traceExchange.walletId.toString(),
                              style: heading,
                            ),
                          ],
                        ),
                        const CustomDivider(bottomSpace: Dimensions.space15,topSpace: Dimensions.space15),
                        SavinglistTile(
                          isSendingCharged: false,
                          name: MyStrings.yourExcahnageID.tr,
                          isTitleBold: false,
                          isSubTitleBold: false,
                          value: controller.traceExchange.exchangeId.toString(),
                          isbottomDevider: false,
                        ),
                        const CustomDivider(bottomSpace: Dimensions.space15,topSpace: Dimensions.space8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(MyStrings.exchangeDate.tr, style: bodyText,maxLines: 2,)),
                            SizedBox(width: Dimensions.space5),
                            Text(
                              DateConverter.convertIsoToString(controller.traceExchange.createdAt.toString()),
                              style: bodyText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.space10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space20,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
