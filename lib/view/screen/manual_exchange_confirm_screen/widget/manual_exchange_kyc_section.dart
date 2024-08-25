import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/exchange/manual_exchange_confirm_controller.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/form_row.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_checkbox_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_date_time_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_radio_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_select_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/section/kyc_text_section.dart';
import 'package:changa_lab/view/screen/auth/kyc/widget/widget/choose_file_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualExchangeConfirmKYCSection extends StatefulWidget {
  const ManualExchangeConfirmKYCSection({super.key});

  @override
  State<ManualExchangeConfirmKYCSection> createState() => _ManualExchangeConfirmKYCSectionState();
}

class _ManualExchangeConfirmKYCSectionState extends State<ManualExchangeConfirmKYCSection> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManualExchangeConfirmController>(builder: (controller) {
      return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: controller.formList.length,
                itemBuilder: (ctx, index) {
                  GlobalFormModel model = controller.formList[index];

                  return Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (MyUtils.getTextInputType(model.type ?? 'text')) ...[
                          KycTextAnEmailSection(
                            onChanged: (value) {
                              controller.changeSelectedValue(value, index);
                            },
                            model: model,
                          )
                        ] else if (model.type == "select") ...[
                          KycSelectSection(
                            onChanged: (value) {
                              controller.changeSelectedValue(value, index);
                            },
                            model: model,
                          )
                        ] else if (model.type == 'radio') ...[
                          KycRadioSection(
                            model: model,
                            onChanged: (selectedIndex) {
                              controller.changeSelectedRadioBtnValue(index, selectedIndex);
                            },
                            selectedIndex: controller.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                          )
                        ] else if (model.type == "checkbox") ...[
                          KycCheckBoxSection(
                            model: model,
                            onChanged: (value) {
                              controller.changeSelectedCheckBoxValue(index, value);
                            },
                            selectedValue: controller.formList[index].cbSelected,
                          )
                        ] else if (model.type == "datetime" || model.type == "date" || model.type == "time") ...[
                          KycDateTimeSection(
                            model: model,
                            onChanged: (value) {
                              controller.changeSelectedValue(value, index);
                            },
                            onTap: () {
                              if (model.type == "time") {
                                controller.changeSelectedTimeOnlyValue(index, context);
                              } else if (model.type == "date") {
                                controller.changeSelectedDateOnlyValue(index, context);
                              } else {
                                controller.changeSelectedDateTimeValue(index, context);
                              }
                            },
                            controller: controller.formList[index].textEditingController!,
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
                                        controller.pickFile(index, extentions: model.extensions?.split(','));
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
            Center(
              child: controller.submitLoading
                  ? const RoundedLoadingBtn()
                  : RoundedButton(
                      press: () {
                        if (formKey.currentState!.validate()) {
                          controller.submitKycData();
                        }
                      },
                      cornerRadius: 8,
                      isOutlined: true,
                      text: MyStrings.submit.tr,
                    ),
            ),
          ],
        ),
      );
    });
  }
}
