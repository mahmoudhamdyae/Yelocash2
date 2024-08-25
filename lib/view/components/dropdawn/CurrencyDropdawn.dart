// ignore_for_file: must_be_immutable, non_constant_identifier_names, library_private_types_in_public_api

import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:changa_lab/data/model/withdraw/withdraw_request_response_model.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:get/get.dart';

class CurrencyDropDawn extends StatefulWidget {
  bool isBorder;
  Color bgColor;
  String imgPath;

  CurrencyDropDawn({
    super.key,
    required this.imgPath,
    this.isBorder = true,
    this.bgColor = MyColor.white,
  });

  @override
  _CurrencyDropDawnState createState() => _CurrencyDropDawnState();
}

class _CurrencyDropDawnState extends State<CurrencyDropDawn> {
  final CurrencyDropDawnController = DropdownController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(builder: (controller) {
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
          borderRadius: BorderRadius.circular(8),
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
          child: CoolDropdown<Currency>(
            isMarquee: true,
            controller: CurrencyDropDawnController,
            dropdownList: controller.sellCurrencyList.map((Currency value) {
              return CoolDropdownItem<Currency>(
                value: value,
                label: "${"${value.name.toString()}"" -${value.curSym.toString()}"}",
                icon: SizedBox(height: 25, width: 25, child: CircleAvatar(backgroundImage: NetworkImage('${widget.imgPath}/${value.image}'))),
              );
            }).toList(),
            defaultItem: null,
            onChange: (value) async {
              if (CurrencyDropDawnController.isError) {
                await CurrencyDropDawnController.resetError();
              }
              CurrencyDropDawnController.close();
              //
              controller.selectWithdrawCurrency(value);
              controller.countConversion();
              controller.minMaxExchange();
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
                placeholder: MyStrings.selectOne,
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
              borderSide: const BorderSide(width: 1, color: MyColor.borderColor),
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
              boxDecoration: BoxDecoration(color: MyColor.white, border: Border.all(color: MyColor.borderColor, width: 1)),
              selectedTextStyle: bodyText,
              selectedBoxDecoration: BoxDecoration(
                  border: Border.all(
                    color: MyColor.borderColor,
                    width: 1,
                  ),
                  color: MyColor.bg1),
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
