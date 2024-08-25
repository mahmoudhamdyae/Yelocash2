import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/my_images.dart';
import 'package:changa_lab/core/utils/my_strings.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/data/controller/support/new_ticket_controller.dart';
import 'package:changa_lab/data/repo/support/support_repo.dart';
import 'package:changa_lab/data/service/api_service.dart';
import 'package:changa_lab/view/components/app-bar/custom_appbar.dart';
import 'package:changa_lab/view/components/buttons/rounded_button.dart';
import 'package:changa_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:changa_lab/view/components/text-form-field/custom_text_field.dart';
import 'package:changa_lab/view/components/text-form-field/label_text_field.dart';
import 'package:changa_lab/view/components/text/label_text.dart';
import 'package:changa_lab/view/screen/ticket/new_ticket_screen/section/attachment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({super.key});

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportTicketRepo(apiClient: Get.find()));
    Get.put(NewTicketController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewTicketController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          title: MyStrings.addNewTicket.tr,
          bgColor: MyColor.primaryColor,
          titleStyle: regularDefault.copyWith(color: MyColor.colorWhite),
        
        ),
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.textToTextSpace),
                      CustomTextField(
                        labelText: MyStrings.subject.tr,
                        hintText: MyStrings.enterYourSubject.tr,
                        controller: controller.subjectController,
                        isPassword: false,
                        isShowSuffixIcon: false,
                        needOutlineBorder: true,
                        nextFocus: controller.messageFocusNode,
                        onSuffixTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: Dimensions.textToTextSpace),
                      const SizedBox(height: Dimensions.textToTextSpace),
                      LabelText(text: MyStrings.priority.tr),
                      const SizedBox(height: Dimensions.space5),
                      DropDownTextFieldContainer(
                        color: MyColor.getTransparentColor(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: DropdownButton<String>(
                            dropdownColor: MyColor.colorWhite,
                            value: controller.selectedPriority,
                            elevation: 8,
                            icon: SvgPicture.asset(MyImages.arrowDown,height: 15),
                            iconDisabledColor: MyColor.getGreyColor(),
                            iconEnabledColor: MyColor.getPrimaryColor(),
                            isExpanded: true,
                            underline: Container(
                              height: 0,
                              color: MyColor.getPrupleAccentColor()
                            ),
                            onChanged: (String? newValue) {
                              controller.setPriority(newValue);
                            },
                            items: controller.priorityList.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: regularDefault.copyWith(fontSize: Dimensions.fontDefault),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.textToTextSpace),
                      const SizedBox(height: Dimensions.textToTextSpace),
                      CustomTextField(
                        labelText: MyStrings.message.tr,
                        needOutlineBorder: true,
                        hintText: MyStrings.enterYourMessage.tr,
                        isPassword: false,
                        controller: controller.messageController,
                        maxLines: 5,
                        focusNode: controller.messageFocusNode,
                        isShowSuffixIcon: false,
                        onSuffixTap: () {},
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: Dimensions.textToTextSpace),
                      const SizedBox(height: Dimensions.textToTextSpace),
                      InkWell(
                        onTap: () {
                          controller.pickFile();
                        },
                        child: LabelTextField(
                          readOnly: true,
                          contentPadding: const EdgeInsets.all(Dimensions.space10),
                          isAttachment: true,
                          labelText: MyStrings.attachment.tr,
                          hintText: MyStrings.chooseAFile.tr,
                          inputAction: TextInputAction.done,
                          onChanged: (value) {
                            return;
                          },
                          suffixIcon: GestureDetector(
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
                      const SizedBox(height: Dimensions.space2),
                      Text("${MyStrings.supportedFileType.tr.toTitleCase()} ${MyStrings.ext.tr}", style: regularSmall.copyWith(color: MyColor.getGreyText())),
                      const SizedBox(height: Dimensions.space10),
                      const AttachmentSection(),
                      const SizedBox(height: 30),
                      Center(
                        child: controller.submitLoading ?
                        const RoundedLoadingBtn() :
                        RoundedButton(
                          isOutlined: true,
                          isColorChange: true,
                          verticalPadding: Dimensions.space15,
                          cornerRadius: Dimensions.space8,
                          color: MyColor.getPrimaryColor(),
                          text: MyStrings.submit.tr,
                          press: () {
                            controller.submit();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class DropDownTextFieldContainer extends StatelessWidget {

  final Widget child;
  final Color color;

  const DropDownTextFieldContainer({
    super.key,
    required this.child,
    this.color = MyColor.primaryColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
        border: Border.all(color: MyColor.getTextFieldDisableBorder(), width: .5),
      ),
      child: child,
    );
  }
}
