import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KycTextAnEmailSection extends StatelessWidget {
  GlobalFormModel model;
  Function onChanged;

  KycTextAnEmailSection({
    super.key,
    required this.onChanged,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          isRequired: model.isRequired == 'optional' ? false : true,
          instructions: model.instruction,
          hintText: '',
          needOutlineBorder: true,
          labelText: model.name ?? '',
          textInputType: MyUtils.getInputTextFieldType(model.type ?? 'text'),
          validator: (value) {
            if (model.isRequired != 'optional' && value.toString().isEmpty) {
              return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
            } else {
              return null;
            }
          },
          onChanged: (value) => onChanged(value),
          maxLines: model.type == "textarea" ? 5 : 1,
        ),
        const SizedBox(height: Dimensions.space10),
      ],
    );
  }
}
