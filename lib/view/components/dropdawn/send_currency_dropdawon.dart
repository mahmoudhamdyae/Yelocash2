// ignore_for_file: must_be_immutable, non_constant_identifier_names, library_private_types_in_public_api


import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/model/currency/sell_currency_modal.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:get/get.dart';

class SendCurrencyDropDawon extends StatefulWidget {
  bool isBorder;
  Color bgColor;
  final Function(SellCurrency) onSell;

  SendCurrencyDropDawon({
    super.key,
    this.isBorder = true,
    this.bgColor = MyColor.white,
    required this.onSell,
  });

  @override
  _SendCurrencyDropDawonState createState() => _SendCurrencyDropDawonState();
}

class _SendCurrencyDropDawonState extends State<SendCurrencyDropDawon> {
  final CurrencyDropDawnController = DropdownController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: MyColor.transparentColor,
          border: widget.isBorder
              ? Border.all(
            color: MyColor.borderColor,
            width: 1,
          )
              : const Border(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: WillPopScope(
          onWillPop: () async {
            if (CurrencyDropDawnController.isOpen) {
              CurrencyDropDawnController.close();
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: CoolDropdown<SellCurrency>(
            isMarquee: true,
            controller: CurrencyDropDawnController,
            dropdownList: controller.tempsellCurrencyList.map((SellCurrency value) {
              return CoolDropdownItem<SellCurrency>(
                value: value,
                label: "${value.name} - ${value.curSym}",

                icon: Container(
                    margin: const EdgeInsetsDirectional.only(start: Dimensions.space5),
                    height: 25,
                    width: 25,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${controller.imagePath}/${value.image}')
                    )
                ),
              );
            }).toList(),
            defaultItem: null,
            onChange: (value) async {
              if (CurrencyDropDawnController.isError) {
                await CurrencyDropDawnController.resetError();
              }
              CurrencyDropDawnController.close();
              controller.selectSellCurrency(value.id?.toInt() ?? 0);
              widget.onSell(value);
            },
            onOpen: (value) {},
            resultOptions: ResultOptions(
              openBoxDecoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              icon: const SizedBox(
                width: 10,
                height: 10,
                child: CustomPaint(
                  painter: DropdownArrowPainter(),
                ),
              ),
              textOverflow: TextOverflow.ellipsis,
              render: ResultRender.all,
              alignment: Alignment.center,
              placeholderTextStyle: bodyText,
              placeholder: MyStrings.selectOne.tr,
              isMarquee: true,
              boxDecoration: const BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.zero,
              ),
            ),
            dropdownOptions: DropdownOptions(
              borderRadius: BorderRadius.zero,
              top: 10,
              height: MediaQuery.of(context).size.height / 2,
              gap: const DropdownGap.all(2),
              borderSide:const BorderSide(width: 1, color: MyColor.borderColor),
              padding: const EdgeInsets.all(10),
              align: DropdownAlign.left,
              animationType: DropdownAnimationType.scale,
            ),
            dropdownTriangleOptions: const DropdownTriangleOptions(
              width: 0,
              height: 0,
              align: DropdownTriangleAlign.center,
              borderRadius: 3,
              left: 20,
            ),
            dropdownItemOptions: DropdownItemOptions(
              boxDecoration: BoxDecoration(
                  color: MyColor.white,
                  border: Border.all(
                    color: MyColor.borderColor,
                    width: 1,
                  )),
              selectedTextStyle: bodyText,
              selectedBoxDecoration: BoxDecoration(
                  border: Border.all(
                    color: MyColor.borderColor,
                    width: 1,
                  ),
                  color: MyColor.primary.withOpacity(0.4)),
              isMarquee: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              render: DropdownItemRender.all,
              textOverflow: TextOverflow.ellipsis,
              textStyle: bodyText,
              height: 50,
            ),
          ),
        ),
      );
    });
  }
}
