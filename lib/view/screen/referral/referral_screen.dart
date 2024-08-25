import 'package:changa_lab/core/helper/date_converter.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/referral/referral_controller.dart';
import 'package:changa_lab/data/repo/referral/referral_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/custom_no_data_found_class.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<ReferralController>().hasNext()) {
        Get.find<ReferralController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    MyUtils.makePortraitOnly();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReferralRepo(apiClient: Get.find()));
    final controller = Get.put(ReferralController(referralRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.initData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    MyUtils.makePortraitAndLandscape();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferralController>(
      builder: (controller) => Container(
        color: MyColor.primaryColor,
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: MyColor.bg1,
              appBar: CustomAppBar(
                title: MyStrings.referrals,
                titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
              ),
              body: controller.isLoading
                  ? const Center(child: CustomLoader())
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyStrings.referralLink,
                            textAlign: TextAlign.center,
                            style: regularSmall.copyWith(color: MyColor.colorBlack),
                          ),
                          const SizedBox(height: Dimensions.space10),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: DottedBorder(
                              color: MyColor.colorBlack.withOpacity(0.22),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        controller.refferalLink ?? "",
                                        textAlign: TextAlign.center,
                                        style: regularDefault.copyWith(color: MyColor.colorBlack),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: controller.refferalLink ?? ""));
                                          CustomSnackBar.success(successList: [MyStrings.referralLinkCopied]);
                                        },
                                        child: const Icon(Icons.copy, color: MyColor.primaryColor, size: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20),
                          Expanded(
                              child: controller.referralList.isEmpty && controller.filterLoading == false
                                  ? NoDataOrInternetScreen(
                                      paddingTop: 10,
                                      message: MyStrings.noReferralFound,
                                      imageHeight: controller.isSearch ? 0.75 : 0.8,
                                    )
                                  : SizedBox(
                                      height: MediaQuery.of(context).size.height,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        itemCount: controller.referralList.length,
                                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                                            decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(10)),
                                                        child: Text(
                                                          "${index + 1}".padLeft(2, "0"),
                                                          textAlign: TextAlign.center,
                                                          style: GoogleFonts.inter(color: MyColor.getTextColor(), fontWeight: FontWeight.w500, fontSize: 17),
                                                        ),
                                                      ),
                                                      const SizedBox(width: Dimensions.space10),
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "${controller.referralList[index].firstname ?? ''} ${controller.referralList[index].lastname ?? ''}",
                                                              style: regularDefault.copyWith(
                                                                color: MyColor.colorBlack,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            const SizedBox(height: Dimensions.space5),
                                                            Text(
                                                              controller.referralList[index].username ?? '',
                                                              style: regularSmall.copyWith(color: MyColor.colorBlack.withOpacity(.5), fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: Dimensions.space5,
                                                ),
                                                Text(
                                                  DateConverter.isoStringToLocalDateOnly(controller.referralList[index].createdAt ?? ''),
                                                  style: regularSmall.copyWith(color: MyColor.colorGrey, fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ))
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}
