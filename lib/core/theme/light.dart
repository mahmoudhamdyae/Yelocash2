

import 'package:changa_lab/core/utils/my_color.dart';
import 'package:changa_lab/core/utils/style.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    fontFamily: 'Inter',
    primaryColor: MyColor.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: MyColor.bg1,
    hintColor: MyColor.hintTextColor,
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.getPrimaryColor(),
    ),
    cardColor: MyColor.colorWhite,
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.primaryColor,
        elevation: 0,
        titleTextStyle: regularDefault.copyWith(color: MyColor.colorWhite),
        iconTheme: const IconThemeData(
            size: 20,
            color: MyColor.colorWhite
        )
    ),
    radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(MyColor.primaryColor),
        overlayColor: MaterialStateProperty.all(MyColor.colorWhite)
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.primaryColor),
    ));