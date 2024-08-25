import 'package:changa_lab/core/helper/string_format_helper.dart';
import 'package:changa_lab/view/components/text/label_text_with_instructions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:changa_lab/core/utils/dimensions.dart';
import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:changa_lab/view/components/text/label_text.dart';

class CustomTextField extends StatefulWidget {
  final String? instructions;
  final VoidCallback? onTap;
    final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int maxLines;
  final bool animatedLabel;
  final Color fillColor;
  final bool isRequired;
// edited /20-7-23
  final Widget? prefixicon;
  final Widget? suffixWidget;
  final BoxConstraints? suffixIconConstraints;
  final bool? isDense;
  // edited /29-7-2023
  final bool isborderNone;
  const CustomTextField({
    Key? key,
       this.instructions,
       this.onTap,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.transparentColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needRequiredSign = false,
    this.maxLines = 1,
    this.animatedLabel = false,
    this.isRequired = false,
    this.prefixicon,
    this.suffixWidget,
    this.suffixIconConstraints,
    this.isDense,
    this.isborderNone = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

// build the state
  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: regularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 5, left: 15, right: 15, bottom: 5),
                  labelText: widget.labelText?.tr ?? '',
                  labelStyle: regularDefault.copyWith(
                      color: MyColor.getLabelTextColor()),
                  fillColor: widget.fillColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                    borderRadius:
                        BorderRadius.circular(Dimensions.defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: MyColor.getTextFieldEnableBorder()),
                      borderRadius:
                          BorderRadius.circular(Dimensions.defaultRadius)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: MyColor.getTextFieldDisableBorder()),
                      borderRadius:
                          BorderRadius.circular(Dimensions.defaultRadius)),
                  suffixIconConstraints: widget.suffixIconConstraints,
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(
                              icon: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: MyColor.hintTextColor,
                                  size: 20),
                              onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null
                    ? FocusScope.of(context).requestFocus(widget.nextFocus)
                    : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   LabelTextInstruction(
                    text: widget.labelText.toString().toCapitalized(),
                    isRequired: widget.isRequired,
                    instructions: widget.instructions,
                  ),
                  const SizedBox(height: Dimensions.textToTextSpace),
                  TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style:
                        regularDefault.copyWith(color: MyColor.getTextColor()),
                    //textAlign: TextAlign.left,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, left: 15, right: 15, bottom: 5),
                      hintText:
                          widget.hintText != null ? widget.hintText!.tr : '',
                      hintStyle: regularLarge.copyWith(
                        color: MyColor.getHintTextColor().withOpacity(0.7),
                      ),
                      fillColor: MyColor.transparentColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: MyColor.getTextFieldDisableBorder()),
                          borderRadius:
                              BorderRadius.circular(Dimensions.mediumRadius)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: MyColor.getTextFieldEnableBorder()),
                          borderRadius:
                              BorderRadius.circular(Dimensions.mediumRadius)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: MyColor.getTextFieldDisableBorder()),
                          borderRadius:
                              BorderRadius.circular(Dimensions.mediumRadius)),
                      prefixIcon: widget.prefixicon,
                      isDense: widget.isDense,
                      suffixIconConstraints: widget.suffixIconConstraints,
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: MyColor.hintTextColor,
                                      size: 20),
                                  onPressed: _toggle)
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : widget.suffixWidget
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null
                        ? FocusScope.of(context).requestFocus(widget.nextFocus)
                        : null,
                    onChanged: (text) => widget.onChanged!(text),
                    onTap: widget.onTap,
                  )
                ],
              )
        : widget.isborderNone
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: regularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getPrimaryColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,

                decoration: InputDecoration(
                  isDense: widget.isDense,
                  contentPadding: const EdgeInsets.only(
                      top: 5, left: 0, right: 0, bottom: 0),
                  labelText: widget.labelText?.tr,
                  labelStyle: regularDefault.copyWith(
                      color: MyColor.getLabelTextColor()),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: widget.hintText != null ? widget.hintText!.tr : '',
                  hintStyle: regularLarge.copyWith(
                    color: MyColor.getHintTextColor().withOpacity(0.7),
                  ),
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(
                              icon: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: MyColor.hintTextColor,
                                  size: 20),
                              onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null
                    ? FocusScope.of(context).requestFocus(widget.nextFocus)
                    : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              )
            : TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: bodyText,
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getHintTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  isDense: widget.isDense,
                  contentPadding: const EdgeInsets.only(
                      top: 5, left: 0, right: 0, bottom: 5),
                  labelText: widget.labelText?.tr,
                  labelStyle: regularDefault.copyWith(
                      color: MyColor.getLabelTextColor()),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: MyColor.getTextFieldEnableBorder())),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: MyColor.getTextFieldDisableBorder())),
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(
                              icon: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: MyColor.hintTextColor,
                                  size: 20),
                              onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null
                    ? FocusScope.of(context).requestFocus(widget.nextFocus)
                    : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
