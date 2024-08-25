import 'package:changa_lab/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/auth/auth/registration_controller.dart';
import 'package:changa_lab/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:changa_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:changa_lab/view/components/card/bottom_sheet_card.dart';
import 'package:get/get.dart';

class CountryBottomSheet {
  static void bottomSheet(
      BuildContext context, RegistrationController controller) {
    CustomBottomSheet(
        child: Column(
      children: [
        const BottomSheetHeaderRow(header: ''),
        const SizedBox(
          height: 15,
        ),
        controller.isLoading
            ? const SizedBox(height: 100, child: CustomLoader())
            : ListView.builder(
                itemCount: controller.countryList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.countryController.text =
                          controller.countryList[index].country ?? '';
                      controller.setCountryNameAndCode(
                          controller.countryList[index].country ?? '',
                          controller.countryList[index].countryCode ?? '',
                          controller.countryList[index].dialCode ?? '');

                      Navigator.pop(context);

                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: BottomSheetCard(
                      child: Text(
                        '+${controller.countryList[index].dialCode}  ${controller.countryList[index].country?.tr ?? ''}',
                        style: regularDefault.copyWith(
                          color: MyColor.getTextColor(),
                        ),
                      ),
                    ),
                  );
                })
      ],
    )).customBottomSheet(context);
  }
}
