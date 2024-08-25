import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/screen/exchange_prevew/widget/exchagne_kyc_section.dart';
import 'package:changa_lab/view/screen/exchange_prevew/widget/receive_prev_details.dart';
import 'package:changa_lab/view/screen/exchange_prevew/widget/sending_prev_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangePreviewScreen extends StatefulWidget {
  const ExchangePreviewScreen({super.key});

  @override
  State<ExchangePreviewScreen> createState() => _ExchangePreviewScreenState();
}

class _ExchangePreviewScreenState extends State<ExchangePreviewScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          bgColor: MyColor.appBarColor,
          title: MyStrings.exchangePreview.tr,
          titleStyle: heading.copyWith(color: MyColor.white),
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          return controller.isLoading ?
          const CustomLoader()
          : SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25, vertical: Dimensions.space12),
                  decoration: BoxDecoration(color: MyColor.primaryColor.withOpacity(.1), borderRadius: BorderRadius.circular(Dimensions.defaultRadius), border: Border.all(color: MyColor.primaryColor.withOpacity(.2)), boxShadow: MyUtils.getCardShadow()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Send ${'${Converter.sum(controller.prevExchange.sendingAmount ?? '', controller.prevExchange.charge?.sendingCharge?.totalCharge.toString() ?? '')} ${controller.prevExchange.sendCurrency?.curSym.toString()}'} via ${controller.prevExchange.sendCurrency?.name ?? ''} to get ${Converter.sub(controller.prevExchange.receivingAmount ?? '', controller.prevExchange.charge?.receivingCharge?.totalCharge.toString() ?? '')} ${controller.prevExchange.receivedCurrency?.curSym.toString()} via ${controller.prevExchange.receivedCurrency?.name ?? ''}',
                        textAlign: TextAlign.center,
                        style: regularDefault.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w600, fontSize: Dimensions.fontDefault),
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: Dimensions.space20),
                        decoration: BoxDecoration(
                          color: MyColor.unslectedTab,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TabBar(
                          splashBorderRadius: BorderRadius.circular(25),
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25), // Creates border
                            color: MyColor.title,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: MyColor.white,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          unselectedLabelColor: MyColor.title,
                          onTap: (i) {
                            setState(() {
                              selectedIndex = i;
                            });
                          },
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

                      Builder(builder: (_) {
                        if (selectedIndex == 0) {
                          return const SendingPrevDetails();
                        } else {
                          return const ReceivePrevDetails();
                        }
                      }),
                      const SizedBox(
                        height: Dimensions.space20,
                      ),
                      Visibility(
                        visible: controller.prevExchange.id != null,
                        child: const ExchangeKYCSection(),
                      ),
                      CustomTextField(
                        controller: controller.walletIdController,
                        labelText: MyStrings.walletNidNum.tr,
                        textInputType: TextInputType.text,
                        onChanged: (p) {},
                        needOutlineBorder: true,
                        hintText: MyStrings.enterBkashWalletNidNum.tr,
                      ),
                      const SizedBox(
                        height: Dimensions.space20,
                      ),
                      // const SwipeButton()
                      RoundedButton(
                        isOutlined: true,
                        text: MyStrings.exchangeNow.tr,
                        press: () {
                          controller.confirmExchange(id: controller.prevExchange.id.toString());
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));
        }));
  }
}
