import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/home/home_controller.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/form_row.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_checkbox_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_date_time_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_radio_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_select_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_text_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/widget/widget/choose_file_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeKYCSection extends StatelessWidget {
  const ExchangeKYCSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homecontroller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: homecontroller.formList.length,
              itemBuilder: (ctx, index) {
                GlobalFormModel model = homecontroller.formList[index];

                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (MyUtils.getTextInputType(model.type ?? 'text')) ...[
                        KycTextAnEmailSection(
                          onChanged: (value) {
                            homecontroller.changeSelectedValue(value, index);
                          },
                          model: model,
                        )
                      ] else if (model.type == "select") ...[
                        KycSelectSection(
                          onChanged: (value) {
                            homecontroller.changeSelectedValue(value, index);
                          },
                          model: model,
                        )
                      ] else if (model.type == 'radio') ...[
                        KycRadioSection(
                          model: model,
                          onChanged: (selectedIndex) {
                            homecontroller.changeSelectedRadioBtnValue(index, selectedIndex);
                          },
                          selectedIndex: homecontroller.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                        )
                      ] else if (model.type == "checkbox") ...[
                        KycCheckBoxSection(
                          model: model,
                          onChanged: (value) {
                            homecontroller.changeSelectedCheckBoxValue(index, value);
                          },
                          selectedValue: homecontroller.formList[index].cbSelected,
                        )
                      ] else if (model.type == "datetime" || model.type == "date" || model.type == "time") ...[
                        KycDateTimeSection(
                          model: model,
                          onChanged: (value) {
                            homecontroller.changeSelectedValue(value, index);
                          },
                          onTap: () {
                            if (model.type == "time") {
                              homecontroller.changeSelectedTimeOnlyValue(index, context);
                            } else if (model.type == "date") {
                              homecontroller.changeSelectedDateOnlyValue(index, context);
                            } else {
                              homecontroller.changeSelectedDateTimeValue(index, context);
                            }
                          },
                          controller: homecontroller.formList[index].textEditingController!,
                        )
                      ],
                      model.type == 'file'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormRow(label: (model.name ?? '').tr, isRequired: model.isRequired == 'optional' ? false : true),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                  child: InkWell(
                                    splashColor: MyColor.primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                    onTap: () {
                                      homecontroller.pickFile(index, extentions: model.extensions?.split(','));
                                    },
                                    child: ChooseFileItem(
                                      fileName: model.selectedValue ?? MyStrings.chooseFile.tr,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: Dimensions.space10),
                    ],
                  ),
                );
              }),
          const SizedBox(height: Dimensions.space25),
          /*  Center(
              child: withdrawController.submitLoading
                  ? const RoundedLoadingBtn()
                  : RoundedButton(
                      press: () {
                        if (formKey.currentState!.validate()) {
                          withdrawController.submitKycData();
                        }
                      },
                      text: MyStrings.submit,
                    ),
            ),*/
        ],
      );
    });
  }
}
