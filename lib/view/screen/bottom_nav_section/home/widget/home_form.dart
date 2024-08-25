import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_images.dart';

import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';

import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/model/currency/sell_currency_modal.dart';

import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';

import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/get_currency_select.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/home/widget/send_currency_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/model/currency/buy_currency_modal.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({
    super.key,
  });

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {

  SellCurrency? sellCurrency;
  BuyCurrency? buyCurrency;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(builder: (controller) {
      return Positioned(
        top: 80,
        right: 15,
        left: 15,
        child: Container(
          height: 560,
          width: width,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: MyUtils.getBottomSheetShadow(),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  const Spacer(),
                  GetBuilder<HomeController>(builder: (controller) {
                    return sellCurrency == null ? Image.asset(
                      MyImages.placeholder,
                      height: 55,
                      width: 55,
                    ) : SizedBox(
                      height: 55,
                      width: 55,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${controller.imagePath}/${sellCurrency?.image}')
                      ),
                    );
                  }),
                  const SizedBox(width: 40,),
                  Image.asset(
                    MyImages.arrows,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 40,),
                  GetBuilder<HomeController>(builder: (controller) {
                    return buyCurrency == null ? Image.asset(
                      MyImages.placeholder,
                      height: 55,
                      width: 55,
                    ) : SizedBox(
                      height: 55,
                      width: 55,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${controller.imagePath}/${buyCurrency?.image}')
                      ),
                    );
                  }),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              Text(
                MyStrings.youSend.tr,
                style: appHeading.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff1E2329),
                ),
              ),
              const SizedBox(
                height: Dimensions.space8,
              ),
              SendCurrencySelect(onSell: (SellCurrency value) {
                setState(() {
                  sellCurrency = value;
                });
              },),
              const SizedBox(height: Dimensions.space5),
              // think from admin end  here  user  end this is buy but from admin end this is sell so that we use minimumLimitForSell instead of minimumLimitForBuy
              controller.selectedSendCurrency != null
                  ? RichText(
                text: TextSpan(
                  text: '${MyStrings.limit.tr}: ',
                  style: bodyText.copyWith(
                    fontSize: 10,
                    color: const Color(0xff1E2329),
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                        text:
                        '${Converter.formatNumber(controller.selectedSendCurrency?.minimumLimitForBuy ?? "")} - ${Converter.formatNumber(controller.selectedSendCurrency?.maximumLimitForBuy ?? '')} ${controller.selectedSendCurrency?.curSym}',
                        style: bodyText.copyWith(
                          color: const Color(0xff1E2329),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              )
                  : const SizedBox(height: 16),
              const SizedBox(
                height: 6,
              ),
              Text(
                MyStrings.youGet.tr,
                style: appHeading.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff1E2329),
                ),
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              GetCurrencySelect(onBuy: (BuyCurrency value) {
                setState(() {
                  buyCurrency = value;
                });
              },),
              const SizedBox(height: Dimensions.space5),
              // think from admin end  here  user  end this is buy but from admin end this is sell so that we use minimumLimitForSell instead of minimumLimitForBuy
              controller.selectedbuyCurrency != null
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${MyStrings.limit.tr}: ',
                      style: bodyText.copyWith(
                        fontSize: 10,
                        color: const Color(0xff1E2329),
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                            text: '${Converter.formatNumber(controller.selectedbuyCurrency?.minimumLimitForSell ?? "")} - ${Converter.formatNumber(controller.selectedbuyCurrency?.maximumLimitForSell ?? '')} ${controller.selectedbuyCurrency?.curSym}',
                            style: bodyText.copyWith(
                              color: const Color(0xff1E2329),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${MyStrings.reserve.tr}: ',
                      style: regularDefault.copyWith(
                        fontSize: Dimensions.fontSmall,
                        color: const Color(0xff1E2329),
                      ),
                      children: [
                        TextSpan(
                            text:
                            '${Converter.formatNumber(controller.selectedbuyCurrency?.reserve ?? "")} ${controller.selectedbuyCurrency?.curSym}',
                            style: regularDefault.copyWith(
                              color: const Color(0xff1E2329),
                              fontSize: Dimensions.fontSmall,
                            )),
                      ],
                    ),
                  ),
                ],
              )
                  : const SizedBox(height: 19),
              const SizedBox(
                height: Dimensions.space8,
              ),
              Expanded(
                child: GetBuilder<HomeController>(builder: (controller) {
                  return controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                    text: MyStrings.exchangeNow.tr,
                    press: () {
                      controller.createExchange();
                    },
                    cornerRadius: 5,
                    isOutlined: true,
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
