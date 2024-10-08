// ignore_for_file: must_be_immutable, non_constant_identifier_names, library_private_types_in_public_api


import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/model/currency/buy_currency_modal.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_strings.dart';

class BuyCurrencyDropdawon extends StatefulWidget {
  bool isBorder;
  Color bgColor;
  final Function(BuyCurrency) onBuy;

  BuyCurrencyDropdawon({
    super.key,
    this.isBorder = true,
    this.bgColor = MyColor.white,
    required this.onBuy,
  });

  @override
  _BuyCurrencyDropdawonState createState() => _BuyCurrencyDropdawonState();
}

class _BuyCurrencyDropdawonState extends State<BuyCurrencyDropdawon> {
  DropdownController<BuyCurrency> currencyDropDawnController = DropdownController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
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
            if (currencyDropDawnController.isOpen) {
              currencyDropDawnController.close();
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: CoolDropdown<BuyCurrency>(
            isMarquee: true,
            controller: currencyDropDawnController,
            dropdownList: controller.tempbuyCurrencyList.map((BuyCurrency value) {
              return CoolDropdownItem<BuyCurrency>(
                value: value,
                label: "${value.name} ${value.curSym}",
                icon: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${controller.imagePath}/${value.image}'
                      )
                  ),
                ),
              );
            }).toList(),
            defaultItem: null,
            onChange: (value) async {
              if (currencyDropDawnController.isError) {
                await currencyDropDawnController.resetError();
              }
              currencyDropDawnController.close();
              controller.selectBuyCurrency(value.id?.toInt() ?? 0);
              widget.onBuy(value);
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
                )),
            dropdownOptions: DropdownOptions(
              borderRadius: BorderRadius.zero,
              top: 10,
              height: MediaQuery.of(context).size.height / 2,
              gap: const DropdownGap.all(2),
              borderSide:
              const BorderSide(width: 1, color: MyColor.borderColor),
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
              selectedTextStyle: appHeading,
              selectedBoxDecoration: BoxDecoration(
                border: Border.all(
                  color: MyColor.borderColor,
                  width: 1,
                ),
                color: MyColor.primary,
              ),
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
