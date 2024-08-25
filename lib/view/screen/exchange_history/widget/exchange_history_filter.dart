
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/data/controller/history_exchange/historyExchangeController.dart';
import 'package:changa_lab/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeHistoryFilter extends StatefulWidget {
  const ExchangeHistoryFilter({super.key});

  @override
  State<ExchangeHistoryFilter> createState() => _ExchangeHistoryFilterState();
}

class _ExchangeHistoryFilterState extends State<ExchangeHistoryFilter> {
  List<String> filterOptions = [
    'All Exchange',
    'Approved Exchange',
    'Pending Exchange',
    'Refunded Exchange',
    'Cancled Exchange'
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: GetBuilder<HistoryExchangeController>(builder: (controller) {
        return Column(
          children: [
            const BottomSheetHeaderRow(),
            CustomRadioButton(
              selectedIndex: controller.index,
              list: filterOptions,
              onChanged: (p) {
                controller.changeIndex(p);
              },
            ),
            const SizedBox(height: Dimensions.space45),
            RoundedButton(
                text: 'Apply'.toUpperCase(),
                isOutlined: true,
                press: () {
                  controller.getExchangeHistory();
                  Get.back();
                })
          ],
        );
      }),
    );
  }
}
