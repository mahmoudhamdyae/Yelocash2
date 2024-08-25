import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/checkbox/custom_check_box.dart';
import 'package:changa_lab/view/components/custom_drop_down_button_with_text_field.dart';
import 'package:changa_lab/view/components/custom_radio_button.dart';
import 'package:changa_lab/view/components/form_row.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/components/text/label_text_with_instructions.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_checkbox_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_date_time_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_radio_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_select_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_text_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/widget/widget/choose_file_list_item.dart';
import 'package:changa_lab/view/screen/auth/kyc/widget/widget/file_item.dart';
import 'package:changa_lab/view/screen/bottom_nav_section/widraw/widget/withdraw_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/data/model/withdraw/withdraw_request_response_model.dart' as kyc;

class WithdrawKYCSection extends StatefulWidget {
  const WithdrawKYCSection({super.key});

  @override
  State<WithdrawKYCSection> createState() => _WithdrawKYCSectionState();
}

class _WithdrawKYCSectionState extends State<WithdrawKYCSection> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(builder: (withdrawController) {
      return Form(
        key: withdrawController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: withdrawController.formList.length,
                itemBuilder: (ctx, index) {
              GlobalFormModel? model = withdrawController.formList[index];
                   return Padding(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (MyUtils.getTextInputType(model.type ?? 'text')) ...[
                        KycTextAnEmailSection(
                          onChanged: (value) {
                            withdrawController.changeSelectedValue(value, index);
                          },
                          model: model,
                        )
                      ] else if (model.type == "select") ...[
                        KycSelectSection(
                          onChanged: (value) {
                            withdrawController.changeSelectedValue(value, index);
                          },
                          model: model,
                        )
                      ] else if (model.type == 'radio') ...[
                        KycRadioSection(
                          model: model,
                          onChanged: (selectedIndex) {
                            withdrawController.changeSelectedRadioBtnValue(index, selectedIndex);
                          },
                          selectedIndex: withdrawController.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                        )
                      ] else if (model.type == "checkbox") ...[
                        KycCheckBoxSection(
                          model: model,
                          onChanged: (value) {
                            withdrawController.changeSelectedCheckBoxValue(index, value);
                          },
                          selectedValue: withdrawController.formList[index].cbSelected,
                        )
                      ] else if (model.type == "datetime" || model.type == "date" || model.type == "time") ...[
                        KycDateTimeSection(
                          model: model,
                          onChanged: (value) {
                            withdrawController.changeSelectedValue(value, index);
                          },
                          onTap: () {
                            if (model.type == "time") {
                              withdrawController.changeSelectedTimeOnlyValue(index, context);
                            } else if (model.type == "date") {
                              withdrawController.changeSelectedDateOnlyValue(index, context);
                            } else {
                              withdrawController.changeSelectedDateTimeValue(index, context);
                            }
                          },
                          controller: withdrawController.formList[index].textEditingController!,
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
                                      withdrawController.pickFile(index, extentions: model.extensions?.split(','));
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
            // const SizedBox(height: Dimensions.space25),
            // // Center(
            //   child: withdrawController.submitLoading
            //       ? const RoundedLoadingBtn()
            //       : RoundedButton(
            //           press: () {
            //             if (formKey.currentState!.validate()) {
            //               withdrawController.submitKycData();
            //             }
            //           },
            //           text: MyStrings.submit,
            //         ),
            // ),
          ],
        ),
      );
    });
  }
}
