import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';

class FormRow extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormRow({Key? key, required this.label, required this.isRequired})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label.tr.toCapitalized(),
            style: regularDefault.copyWith(color: MyColor.labelTextColor)),
        Text(isRequired ? ' *' : '',
            style: boldDefault.copyWith(color: Colors.red))
      ],
    );
  }
}
