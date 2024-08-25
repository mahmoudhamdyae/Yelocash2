import 'package:changa_lab/core/route/route.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/localization/localization_controller.dart';
import 'package:changa_lab/data/controller/menu/my_menu_controller.dart';
import 'package:changa_lab/data/repo/auth/general_setting_repo.dart';
import 'package:changa_lab/data/repo/menu_repo/menu_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:changa_lab/view/components/divider/custom_divider2.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/menu/widget/delete_account_bottom_sheet_body.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/menu/widget/menuTiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    final controller = Get.put(MyMenuController(menuRepo: Get.find(), repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.bottomNavBar,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: MyColor.appBarColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: MyColor.colorWhite,
          systemNavigationBarIconBrightness: Theme.of(context).brightness,
        ),
        child: Scaffold(
            backgroundColor: MyColor.screenBgColor,
            appBar: CustomAppBar(
              isShowBackBtn: false,
              title: MyStrings.menu.tr,
              titleStyle: bodyText.copyWith(color: MyColor.white),
            ),
            body: GetBuilder<MyMenuController>(builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    // part 1 profile
                    Container(
                      decoration: BoxDecoration(color: MyColor.white, boxShadow: MyUtils.getCardShadow()),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space12),
                      child: Column(
                        children: [
                          MenuTile(
                            imagePath: MyImages.user,
                            title: MyStrings.profile.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.profileScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.lock,
                            title: MyStrings.changePassword.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.changePasswordScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.wallet,
                            title: MyStrings.exchangeHistory.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.exchangeHistory);
                            },
                          ),
                        ],
                      ),
                    ),
                    // part 2
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    // part 1 profile
                    Container(
                      decoration: BoxDecoration(color: MyColor.white, boxShadow: MyUtils.getCardShadow()),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space12),
                      child: Column(
                        children: [
                          MenuTile(
                            imagePath: MyImages.withdraw,
                            title: MyStrings.withdrawHistory.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.withdrawHistory);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.addMoney,
                            title: MyStrings.commissionLog.tr,
                            isSvg: false,
                            action: () {
                              Get.toNamed(RouteHelper.commissionLog);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.refferal,
                            title: MyStrings.referrals.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.refferalScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.support,
                            title: MyStrings.supportTicket,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.allTicketScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.twoFa,
                            title: MyStrings.twoFactorAuth,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.twoFactorSetupScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    // part 1 profile
                    Container(
                      decoration: BoxDecoration(color: MyColor.white, boxShadow: MyUtils.getCardShadow()),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space12),
                      child: Column(
                        children: [
                          MenuTile(
                            imagePath: MyImages.language,
                            title: MyStrings.language.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.languageScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.faq,
                            title: MyStrings.faq.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.faqScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.policy,
                            title: MyStrings.privacyPolicy.tr,
                            isSvg: true,
                            action: () {
                              Get.toNamed(RouteHelper.privacyScreen);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          MenuTile(
                            imagePath: MyImages.deleteAccount,
                            title: MyStrings.deleteAccount.tr,
                            isSvg: true,
                            action: () {
                              CustomBottomSheet(
                                isNeedMargin: true,
                                child: const DeleteAccountBottomsheetBody(),
                              ).customBottomSheet(context);
                            },
                          ),
                          const CustomDivider2(
                            space: Dimensions.space10,
                          ),
                          controller.logoutLoading
                              ? const Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: MyColor.primaryColor, strokeWidth: 2.00),
                                  ),
                                )
                              : MenuTile(
                                  imagePath: MyImages.logout.tr,
                                  title: MyStrings.logout.tr,
                                  isSvg: true,
                                  action: () {
                                    controller.logout();
                                  },
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    // part 1 profile
                  ],
                ),
              );
            })),
      ),
    );
  }
}
