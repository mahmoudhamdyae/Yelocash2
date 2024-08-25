import 'package:changa_lab/core/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'my_strings.dart';

class MyUtils {
  static splashScreen() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.getPrimaryColor(),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.getPrimaryColor(),
        systemNavigationBarIconBrightness: Brightness.light));
  }
  static makePortraitOnly(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

     static makePortraitAndLandscape(){
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
       DeviceOrientation.landscapeLeft,
       DeviceOrientation.landscapeRight,
     ]);
   }
   
  static allScreen() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.getPrimaryColor(),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.colorWhite,
        systemNavigationBarIconBrightness: Brightness.dark));
  }
  static TextInputType getInputTextFieldType(String type) {
    if (type == "email") {
      return TextInputType.emailAddress;
    } else if (type == "number") {
      return TextInputType.number;
    } else if (type == "url") {
      return TextInputType.url;
    }
    return TextInputType.text;
  }
  static bool getTextInputType(String type) {
    if (type == "text") {
      return true;
    } else if (type == "email") {
      return true;
    } else if (type == "number") {
      return true;
    } else if (type == "url") {
      return true;
    } else if (type == "textarea") {
      return true;
    }
    return false;
  }

  static dynamic getShadow() {
    return [
      BoxShadow(
          blurRadius: 15.0,
          offset: const Offset(0, 25),
          color: Colors.grey.shade500.withOpacity(0.6),
          spreadRadius: -35.0),
    ];
  }

  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static getOperationTitle(String value) {
    String number = value;
    RegExp regExp = RegExp(r'^(\d+)(\w+)$');
    Match? match = regExp.firstMatch(number);
    if (match != null) {
      String? num = match.group(1) ?? '';
      String? unit = match.group(2) ?? '';
      String title = '${MyStrings.last.tr} $num ${unit.capitalizeFirst}';
      return title.tr;
    } else {
      return value.tr;
    }
  }
    static bool isImage(String path) {
    if (path.contains('.jpg')) {
      return true;
    }
    if (path.contains('.png')) {
      return true;
    }
    if (path.contains('.jpeg')) {
      return true;
    }
    return false;
  }

  static bool isXlsx(String path) {
    if (path.contains('.xlsx')) {
      return true;
    }
    if (path.contains('.xls')) {
      return true;
    }
    if (path.contains('.xlx')) {
      return true;
    }
    return false;
  }

  static bool isDoc(String path) {
    if (path.contains('.doc')) {
      return true;
    }
    if (path.contains('.docs')) {
      return true;
    }
    return false;
  }
}
