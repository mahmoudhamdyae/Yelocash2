import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:changa_lab/data/repo/withdraw/withdraw_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/widraw/widget/withdraw_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WithdrawScreen extends StatefulWidget {
  bool isBack;
  WithdrawScreen({
    super.key,
    this.isBack = false,
  });

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    final controller = Get.put(AddNewWithdrawController(repo: Get.find()));
    // implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: MyColor.appBarColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.colorWhite,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
      child: Scaffold(
          backgroundColor: MyColor.bg1,
          appBar: CustomAppBar(
            title: MyStrings.withdrawHead.tr,
            bgColor: MyColor.appBarColor,
            isShowBackBtn: widget.isBack,
            titleStyle: heading.copyWith(color: MyColor.white),
          ),
          body: GetBuilder<AddNewWithdrawController>(builder: (widcontroller) {
            return widcontroller.isLoading
                ? const CustomLoader()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: MyColor.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: MyColor.borderColor,
                                )),
                            child: const WithdrawBody(),
                          )
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
