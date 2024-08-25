import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/checkbox/custom_check_box.dart';
import 'package:changa_lab/view/components/text/label_text_with_instructions.dart';
import 'package:flutter/material.dart';


class KycCheckBoxSection extends StatelessWidget {
  GlobalFormModel model;
  Function onChanged;
  List<String>? selectedValue;
  KycCheckBoxSection({
    super.key,
    required this.model,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextInstruction(text: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true, instructions: model.instruction),
        CustomCheckBox(
          selectedValue: selectedValue,
          list: model.options ?? [],
          onChanged: (value) => onChanged(value),
        ),
      ],
    );
  }
}
