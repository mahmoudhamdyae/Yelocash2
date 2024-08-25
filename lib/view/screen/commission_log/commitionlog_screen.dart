// ignore_for_file: unnecessary_null_comparison

import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/commission/commissionController.dart';
import 'package:changa_lab/data/repo/commission/commission_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/custom_no_data_found_class.dart';
import 'package:changa_lab/view/screen/commission_log/widget/commission_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommissionLogScreen extends StatefulWidget {
  const CommissionLogScreen({super.key});

  @override
  State<CommissionLogScreen> createState() => _CommissionLogScreenState();
}

class _CommissionLogScreenState extends State<CommissionLogScreen> {
  final ScrollController scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  fetchData() {
    Get.find<CommissionController>().loadPaginationData();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<CommissionController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CommissionRepo(apiClient: Get.find()));
    // Get.put()
    final controller = Get.put(CommissionController(commissionRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialValue();
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
        bgColor: MyColor.primary,
        title: MyStrings.commissionLog.tr,
        titleStyle: bodyText.copyWith(color: MyColor.white),
      ),
      body: GetBuilder<CommissionController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: controller.commissionList.isNotEmpty
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: controller.commissionList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CommissionCard(
                              commission: controller.commissionList[i],
                              currency: controller.currency,
                            ),
                          );
                        },
                      )
                    : const NoDataOrInternetScreen(),
              );
      }),
    );
  }
}
