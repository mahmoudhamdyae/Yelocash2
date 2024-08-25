import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KycDateTimeSection extends StatelessWidget {
  GlobalFormModel model;
  Function onChanged;
  Function onTap;
  TextEditingController? controller;
  KycDateTimeSection({
    super.key,
    required this.model,
    required this.onTap,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      instructions: model.instruction,
      isRequired: model.isRequired == 'optional' ? false : true,
      hintText: (model.name ?? '').toString().capitalizeFirst,
      needOutlineBorder: true,
      labelText: model.name ?? '',
      controller: controller,
      textInputType: TextInputType.datetime,
      readOnly: true,
      validator: (value) {
        if (model.isRequired != 'optional' && value.toString().isEmpty) {
          return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
        } else {
          return null;
        }
      },
      onTap: () {
        onTap();
      },
      onChanged: (value) => onChanged(value),
    );
  }
}
