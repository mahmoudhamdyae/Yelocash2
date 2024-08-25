import 'package:changa_lab/data/controller/exchange/manual_exchange_confirm_controller.dart';
import 'package:changa_lab/view/screen/auth/kyc/widget/widget/choose_file_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/controller/kyc_controller/kyc_controller.dart';
import 'package:changa_lab/data/model/kyc/kyc_response_model.dart';

class ManualFileItem extends StatefulWidget {
  final int index;

  const ManualFileItem({Key? key, required this.index}) : super(key: key);

  @override
  State<ManualFileItem> createState() => _ManualFileItemState();
}

class _ManualFileItemState extends State<ManualFileItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManualExchangeConfirmController>(builder: (controller) {
      final model = controller.formList[widget.index];
      return InkWell(
          onTap: () {
            controller.pickFile(widget.index);
          },
          child: ChooseFileItem(fileName: model.selectedValue ?? MyStrings.chooseFile.tr));
    });
  }
}
