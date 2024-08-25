import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/components/custom_radio_button.dart';
import 'package:changa_lab/view/components/text/label_text_with_instructions.dart';
import 'package:flutter/material.dart';


class KycRadioSection extends StatelessWidget {
  GlobalFormModel model;
  Function onChanged;
  int selectedIndex;
  KycRadioSection({
    super.key,
    required this.model,
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextInstruction(text: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true,instructions: model.instruction ?? ''),
        CustomRadioButton(
          title: model.name,
          selectedIndex: selectedIndex,
          list: model.options ?? [],
          onChanged: (index) => onChanged(index),
        ),
      ],
    );
  }
}
