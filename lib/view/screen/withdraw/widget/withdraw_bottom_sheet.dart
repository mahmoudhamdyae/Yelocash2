// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:changa_lab/view/components/divider/custom_divider2.dart';
import 'package:changa_lab/view/components/text/bottom_sheet_label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:changa_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:changa_lab/view/components/column_widget/label_column.dart';
import 'package:changa_lab/view/components/row_widget/bottom_sheet_top_row.dart';

class WithdrawBottomSheet {
  //
  void withdrawBottomSheet(
    int index,
    BuildContext context,
    String currency,
  ) {
    CustomBottomSheet(
      child: GetBuilder<WithdrawHistoryController>(builder: (controller) {
        log(controller.withdrawList[index].id.toString());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetTopRow(header: MyStrings.withdrawInformation),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: LabelColumn(
                    header: MyStrings.withdrawMethod,
                    body: controller.withdrawList[index].method?.name ?? '',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: LabelColumn(
                    alignmentEnd: true,
                    header: MyStrings.withdrawCurrency,
                    body: controller.withdrawList[index].method?.curSym ?? '',
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 6,
                    child: LabelColumn(
                        header: MyStrings.withdrawAmount,
                        body:
                            '${controller.curSymbol}${Converter.formatNumber(controller.withdrawList[index].amount ?? '0')}')),
                Expanded(
                  flex: 2,
                  child: LabelColumn(
                    alignmentEnd: true,
                    header: MyStrings.charge,
                    body:
                        '${Converter.formatNumber(controller.withdrawList[index].charge ?? '')} ${controller.withdrawList[index].method?.curSym}',
                    lastTextRed: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: LabelColumn(
                        header: MyStrings.receiveAmountAfterCharge,
                        body:
                            '${Converter.formatNumber(controller.withdrawList[index].afterCharge ?? '')} ${controller.withdrawList[index].method?.curSym ?? 'USD'}')),
                Expanded(
                    flex: 4,
                    child: LabelColumn(
                        alignmentEnd: true,
                        header: MyStrings.conversionRate,
                        body:
                            '1 ${controller.withdrawList[index].method?.curSym} = ${Converter.formatNumber(controller.withdrawList[index].rate ?? '')} ${controller.withdrawList[index].currency}')),
              ],
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 4,
                    child: LabelColumn(
                        header: MyStrings.receiveAmount,
                        body:
                            '${Converter.formatNumber(controller.withdrawList[index].finalAmount ?? '0')} ${controller.withdrawList[index].method?.curSym}')),
                Expanded(
                  flex: 3,
                  child: LabelColumn(
                      alignmentEnd: true,
                      header: MyStrings.adminFeedback,
                      body: controller.withdrawList[index].adminFeedback ??
                          MyStrings.noFeedback),
                ),
              ],
            ),
            Visibility(
              visible:
                  controller.withdrawList[index].withdrawInformation != null &&
                      controller
                          .withdrawList[index].withdrawInformation!.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider2(space: Dimensions.space15),
                  BottomSheetLabelText(text: MyStrings.details.tr),
                  const SizedBox(
                    height: Dimensions.space15,
                  ),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.withdrawList[index]
                              .withdrawInformation?.length ??
                          0,
                      itemBuilder: (BuildContext context, int detailsIndex) {
                        final details = controller.withdrawList[index]
                            .withdrawInformation?[detailsIndex];
                        return Container(
                          margin:
                              const EdgeInsets.only(bottom: Dimensions.space15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          child: details?.type == 'file'
                              ? InkWell(
                                  onTap: () {
                                    controller.downloadAttachment(
                                        details?.value ?? '', context);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        (details?.name
                                                    .toString()
                                                    .capitalizeFirst ??
                                                '')
                                            .tr,
                                        style: regularDefault.copyWith(
                                            color: MyColor.bodyTextColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.file_download,
                                            size: 17,
                                            color: MyColor.primaryColor,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            MyStrings.attachment.tr,
                                            style: regularDefault.copyWith(
                                                color: MyColor.primaryColor),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : LabelColumn(
                                  header: (details?.name ?? '')
                                          .tr
                                          .capitalizeFirst ??
                                      '',
                                  body: details?.value.toString() ?? ''),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.space20),
          ],
        );
      }),
    ).customBottomSheet(context);
  }
}
