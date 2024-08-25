import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/privacy/privacy_controller.dart';
import 'package:changa_lab/data/repo/privacy_repo/privacy_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/category_button.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PrivacyRepo(apiClient: Get.find()));
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: CustomAppBar(
          title: MyStrings.privacyPolicy.tr,
          bgColor: MyColor.primaryColor,
          isShowActionBtn: false,
          titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? const CustomLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: Dimensions.space10, top: Dimensions.space15),
                        child: SizedBox(
                          height: 30,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                controller.list.length,
                                (index) => Row(
                                  children: [
                                    CategoryButton(
                                        color: controller.selectedIndex == index ? MyColor.primaryColor : MyColor.secondaryColor,
                                        horizontalPadding: 8,
                                        verticalPadding: 7,
                                        textColor: controller.selectedIndex == index ? MyColor.colorWhite : MyColor.colorBlack,
                                        text: controller.list[index].dataValues?.title ?? '',
                                        press: () {
                                          controller.changeIndex(index);
                                        }),
                                    const SizedBox(width: Dimensions.space10)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Expanded(
                          child: Center(
                        child: SingleChildScrollView(child: Container(padding: const EdgeInsets.all(20), width: double.infinity, color: Colors.transparent, child: HtmlWidget(controller.selectedHtml, textStyle: regularDefault.copyWith(color: Colors.black), onLoadingBuilder: (context, element, loadingProgress) => const Center(child: CustomLoader())))),
                      ))
                    ],
                  ),
          ),
        ));
  }
}
