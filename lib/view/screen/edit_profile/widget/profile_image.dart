import 'dart:io';
import 'package:changa_lab/view/screen/auth/profile_complete/widget/build_circle_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:changa_lab/view/components/circle_image_button.dart';
import '../../../../../../../../core/utils/my_color.dart';
import '../../../../../../../core/utils/my_images.dart';
import '../../../../../data/controller/account/profile_controller.dart';

class ProfileWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child:  ClipOval(
          child: CircleImageWidget(
            imagePath: MyImages.profileImage,
            width: 90,
            height: 90,
            isProfile: true
          ),
        ),
      ),
    );
  }

}
