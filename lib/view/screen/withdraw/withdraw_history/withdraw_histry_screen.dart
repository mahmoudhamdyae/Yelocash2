import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:changa_lab/data/repo/withdraw/withdraw_history_repo.dart';
import 'package:changa_lab/view/components/custom_no_data_found_class.dart';
import 'package:get/get.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../widget/custom_withdraw_card.dart';
import '../widget/withdraw_bottom_sheet.dart';
import '../widget/withdraw_history_top.dart';

class WidthrawHistoryScreen extends StatefulWidget {
  const WidthrawHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WidthrawHistoryScreen> createState() => _WidthrawHistoryScreenState();
}

class _WidthrawHistoryScreenState extends State<WidthrawHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<WithdrawHistoryController>().hasNext()) {
        Get.find<WithdrawHistoryController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawHistoryRepo(apiClient: Get.find()));
    final controller =
        Get.put(WithdrawHistoryController(withdrawHistoryRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
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
    return GetBuilder<WithdrawHistoryController>(
      builder: (controller) => Container(
        color: MyColor.appBarColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.bg1,
            appBar: CustomAppBar(
              titleStyle: heading.copyWith(color: MyColor.white),
              title: MyStrings.withdrawHistory,
              action: [
                const SizedBox(width: Dimensions.space7),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.addWithdrawMethodScreen);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 7, right: 10, bottom: 7, top: 7),
                    padding: const EdgeInsets.all(Dimensions.space7),
                    decoration: const BoxDecoration(
                        color: MyColor.colorWhite, shape: BoxShape.circle),
                    child: const Icon(Icons.add,
                        color: MyColor.primaryColor, size: 15),
                  ),
                ),
                const SizedBox(width: Dimensions.space15),
              ],
            ),
            body: controller.isLoading
                ? const CustomLoader()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.space20,
                        left: Dimensions.space15,
                        right: Dimensions.space15),
                    child: Column(
                      children: [
                        Visibility(
                          visible: controller.isSearch,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WithdrawHistoryTop(),
                              SizedBox(height: Dimensions.space10),
                            ],
                          ),
                        ),
                        Expanded(
                          child: controller.withdrawList.isEmpty &&
                                  controller.filterLoading == false
                              ? const Center(
                                  child: NoDataOrInternetScreen(),
                                )
                              : controller.filterLoading
                                  ? const CustomLoader()
                                  : SizedBox(
                                      height: MediaQuery.of(context).size.height,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                            controller.withdrawList.length + 1,
                                        controller: scrollController,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                                height: Dimensions.space10),
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              controller.withdrawList.length) {
                                            return controller.hasNext()
                                                ? const CustomLoader(
                                                    isPagination: true)
                                                : const SizedBox();
                                          }
                                          return CustomWithdrawCard(
                                            onPressed: () {
                                              WithdrawBottomSheet()
                                                  .withdrawBottomSheet(
                                                index,
                                                context,
                                                controller.currency,
                                                // controller.withdrawList[index],
                                              );
                                            },
                                            trxValue: controller
                                                    .withdrawList[index].trx ??
                                                "",
                                            date: DateConverter
                                                .isoToLocalDateAndTime(controller
                                                        .withdrawList[index]
                                                        .createdAt ??
                                                    ""),
                                            status: controller.getStatus(index),
                                            statusBgColor:
                                                controller.getColor(index),
                                            amount:
                                                "${Converter.formatNumber(controller.withdrawList[index].amount ?? " ")} ${controller.currency}",
                                          );
                                        },
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
