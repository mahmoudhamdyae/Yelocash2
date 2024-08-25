import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/url_container.dart';
import 'package:changa_lab/data/controller/account/profile_complete_controller.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/image/my_image_widget.dart';
import 'package:changa_lab/view/components/text-form-field/label_text_field.dart';
import 'package:changa_lab/view/screen/auth/profile_complete/widget/country_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/components/will_pop_widget.dart';
import '../../../../data/repo/account/profile_repo.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(
      apiClient: Get.find(),
    ));
    final controller = Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();
    controller.getCountryData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Container(
        color: MyColor.appBarColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            appBar: CustomAppBar(
              title: MyStrings.profileComplete.tr,
              isShowBackBtn: true,
              fromAuth: false,
              isProfileCompleted: true,
              titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
              bgColor: MyColor.getAppBarColor(),
            ),
            body: GetBuilder<ProfileCompleteController>(
              builder: (controller) => SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.space25),
                      CustomTextField(
                        animatedLabel: true,
                        needOutlineBorder: true,
                        labelText: MyStrings.username.tr,
                        hintText: "${MyStrings.enterYour.tr} ${MyStrings.username.toLowerCase().tr}",
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.usernameFocusNode,
                        controller: controller.usernameController,
                        nextFocus: controller.mobileNoFocusNode,
                        onChanged: (value) {
                          return;
                        },
                      ),
                      LabelTextField(
                        outLineBorderColor: MyColor.textFieldDisableBorderColor,
                        radius: 4,
                        // fillColor: MyColor.textFieldColor,
                        onChanged: (v) {},
                        labelText: "",
                        hintText: MyStrings.enterYourPhoneNumber,
                        controller: controller.mobileNoController,
                        focusNode: controller.mobileNoFocusNode,
                        textInputType: TextInputType.phone,
                        inputAction: TextInputAction.next,
                        prefixIcon: SizedBox(
                          width: 100,
                          child: FittedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    CountryBottomSheet.profileCompleteCountryBottomSheet(context, controller);
                                  },
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space12),
                                    decoration: BoxDecoration(
                                      color: MyColor.getTransparentColor(),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        MyImageWidget(
                                          imageUrl: UrlContainer.countryFlagImageLink.replaceAll('{countryCode}', controller.countryCode.toString().toLowerCase()),
                                          height: Dimensions.space25,
                                          width: Dimensions.space40 + 2,
                                        ),
                                        const SizedBox(width: Dimensions.space5),
                                        Text("+${controller.mobileCode}" ?? ''),
                                        const SizedBox(width: Dimensions.space3),
                                        Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: MyColor.getIconColor(),
                                        ),
                                        Container(
                                          width: 2,
                                          height: Dimensions.space12,
                                          color: MyColor.getBorderColor(),
                                        ),
                                        const SizedBox(width: Dimensions.space8)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space25),
                      CustomTextField(
                        animatedLabel: true,
                        needOutlineBorder: true,
                        labelText: MyStrings.address.tr,
                        hintText: "${MyStrings.enterYour.tr} ${MyStrings.address.toLowerCase().tr}",
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.addressFocusNode,
                        controller: controller.addressController,
                        nextFocus: controller.stateFocusNode,
                        onChanged: (value) {
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      CustomTextField(
                        animatedLabel: true,
                        needOutlineBorder: true,
                        labelText: MyStrings.state.tr,
                        hintText: "${MyStrings.enterYour.tr} ${MyStrings.state.toLowerCase().tr}",
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.stateFocusNode,
                        controller: controller.stateController,
                        nextFocus: controller.cityFocusNode,
                        onChanged: (value) {
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      CustomTextField(
                        animatedLabel: true,
                        needOutlineBorder: true,
                        labelText: MyStrings.city.tr,
                        hintText: "${MyStrings.enterYour.tr} ${MyStrings.city.toLowerCase().tr}",
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.cityFocusNode,
                        controller: controller.cityController,
                        nextFocus: controller.zipCodeFocusNode,
                        onChanged: (value) {
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      CustomTextField(
                        animatedLabel: true,
                        needOutlineBorder: true,
                        labelText: MyStrings.zipCode.tr,
                        hintText: "${MyStrings.enterYour.tr} ${MyStrings.zipCode.toLowerCase().tr}",
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        focusNode: controller.zipCodeFocusNode,
                        controller: controller.zipCodeController,
                        onChanged: (value) {
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.space35),
                      controller.submitLoading
                          ? const RoundedLoadingBtn()
                          :RoundedButton(
                        text: MyStrings.submit.tr.toUpperCase(),
                        press: () {
                           controller.updateProfile();
                        },
                        cornerRadius: 8,
                        isOutlined: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
