import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/controller/exchange/exchangeController.dart';
import 'package:changa_lab/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TraceExchangeBottomSheet extends StatelessWidget {
  const TraceExchangeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: GetBuilder<ExchangeController>(builder: (controller) {
        return Column(
          children: [
            const BottomSheetHeaderRow(),
            CustomTextField(
              needOutlineBorder: true,
              controller: controller.trackExchangeController,
              labelText: MyStrings.trackYourExchange.tr,
              hintText: MyStrings.yourExcahnageID.tr,
              onChanged: (text) {},
            ),
            const SizedBox(height: Dimensions.space45),
            controller.isLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    text: 'Track Now'.toUpperCase(),
                    isOutlined: true,
                    press: () {
                      // controller.getExchangeByID(id);
                      if (controller.trackExchangeController.text.isEmpty) {
                        CustomSnackBar.error(errorList: [MyStrings.enterTransactionNumber.tr]);
                      } else {
                        controller.trackExchange(controller.trackExchangeController.text.toUpperCase());
                      }
                    })
          ],
        );
      }),
    );
  }
}
