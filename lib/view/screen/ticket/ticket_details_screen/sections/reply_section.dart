import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_icons.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/util.dart';
import 'package:changa_lab/data/controller/support/ticket_details_controller.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/circle_icon_button.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/components/text-form-field/label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/style.dart';
import '../../../../components/image/custom_svg_picture.dart';

class ReplySection extends StatelessWidget {
  const ReplySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailsController>(
        builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: MyStrings.message.tr,
                  needOutlineBorder: true,
                  hintText: MyStrings.enterYourMessage.tr,
                  isPassword: false,
                  controller: controller.replyController,
                  maxLines: 5,
                  isShowSuffixIcon: false,
                  onSuffixTap: () {},
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                controller.attachmentList.isNotEmpty ? const SizedBox(height: 20) : const SizedBox.shrink(),
                InkWell(
                  onTap: () {
                    controller.pickFile();
                  },
                  child: LabelTextField(
                    readOnly: true,
                    labelTextColor: MyColor.colorBlack,
                    inputTextStyle: regularDefault.copyWith(color: MyColor.colorBlack),
                    contentPadding: const EdgeInsets.all(Dimensions.space10),
                    isAttachment: true,
                    labelText: MyStrings.attachment.tr,
                    hintText: MyStrings.chooseAFile.tr,
                    inputAction: TextInputAction.done,
                    onChanged: (value) {
                      return;
                    },
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.pickFile();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                        margin: const EdgeInsets.all(Dimensions.space5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: MyColor.getPrimaryColor(),
                        ),
                        child: Text(
                          MyStrings.upload,
                          style: regularDefault.copyWith(color: MyColor.colorWhite),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space3),
                Text("${MyStrings.supportedFileType.tr} ${MyStrings.ext}", style: regularSmall.copyWith(color: MyColor.getGreyColor())),
                const SizedBox(height: Dimensions.space20),
                controller.attachmentList.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(
                                controller.attachmentList.length,
                                (index) => Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(Dimensions.space5),
                                          decoration: const BoxDecoration(),
                                          child: MyUtils.isImage(controller.attachmentList[index].path)
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                  child: Image.file(
                                                    controller.attachmentList[index],
                                                    width: context.width / 5,
                                                    height: context.width / 5,
                                                    fit: BoxFit.cover,
                                                  ))
                                              : MyUtils.isDoc(controller.attachmentList[index].path)
                                                  ? Container(
                                                      width: context.width / 5,
                                                      height: context.width / 5,
                                                      decoration: BoxDecoration(
                                                        color: MyColor.colorWhite,
                                                        borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                        border: Border.all(color: MyColor.getBorderColor(), width: 1),
                                                      ),
                                                      child: const Center(
                                                        child: CustomSvgPicture(
                                                          svgColor: false,
                                                          image: MyIcons.doc,
                                                          height: 45,
                                                          width: 45,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: context.width / 5,
                                                      height: context.width / 5,
                                                      decoration: BoxDecoration(
                                                        color: MyColor.colorWhite,
                                                        borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                        border: Border.all(color: MyColor.getBorderColor(), width: 1),
                                                      ),
                                                      child: const Center(
                                                        child: CustomSvgPicture(
                                                          svgColor: false,
                                                          image: MyIcons.pdfFile,
                                                          height: 45,
                                                          width: 45,
                                                        ),
                                                      ),
                                                    ),
                                        ),
                                        CircleIconButton(
                                          onTap: () {
                                            controller.removeAttachmentFromList(index);
                                          },
                                          height: Dimensions.space20,
                                          width: Dimensions.space20,
                                          backgroundColor: MyColor.getRedColor(),
                                          child:const Icon(
                                            Icons.close,
                                            color: MyColor.colorWhite,
                                            size: Dimensions.space15,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //
                          ],
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: Dimensions.space30),
                controller.submitLoading
                    ? const RoundedLoadingBtn()
                    : RoundedButton(
                        verticalPadding: Dimensions.space15,
                        color: MyColor.primaryColor,
                        text: MyStrings.reply.tr,
                        press: () {
                          controller.uploadTicketViewReply();
                        },
                         cornerRadius: 8,
                         isOutlined: true,
                      ),
                const SizedBox(height: Dimensions.space30),
              ],
            ));
  }
}
