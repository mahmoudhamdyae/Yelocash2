import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/custom_drop_down_button_with_text_field.dart';
import 'package:changa_lab/view/components/text/label_text_with_instructions.dart';
import 'package:flutter/material.dart';

class KycSelectSection extends StatelessWidget {
  GlobalFormModel model;
  Function onChanged;
  KycSelectSection({
    super.key,
    required this.model,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextInstruction(
          text: model.name ?? '',
          isRequired: model.isRequired == 'optional' ? false : true,
          instructions: model.instruction,
        ),
        const SizedBox(height: Dimensions.textToTextSpace),
        CustomDropDownWithTextField(
          list: model.options ?? [],
          onChanged: (value) => onChanged(value),
          selectedValue: model.selectedValue,
        ),
        const SizedBox(height: Dimensions.space10)
      ],
    );
  }
}
