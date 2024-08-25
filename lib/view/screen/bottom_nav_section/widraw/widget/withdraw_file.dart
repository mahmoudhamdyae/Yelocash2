import 'package:changa_lab/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:changa_lab/data/model/global/formdata/global_keyc_formData.dart';
import 'package:changa_lab/view/screen/auth/kyc/widget/widget/choose_file_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/data/controller/kyc_controller/kyc_controller.dart';
import 'package:changa_lab/data/model/kyc/kyc_response_model.dart';
 

class ConfirmWithdrawFile extends StatefulWidget {

  final int index;

  const ConfirmWithdrawFile({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  State<ConfirmWithdrawFile> createState() => _ConfirmWithdrawFileState();
}

class _ConfirmWithdrawFileState extends State<ConfirmWithdrawFile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(builder: (controller){
      GlobalFormModel? model=controller.formList[widget.index];
      return InkWell(
        onTap: (){
          controller.pickFile(widget.index);
        }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile));
    });
  }
}
