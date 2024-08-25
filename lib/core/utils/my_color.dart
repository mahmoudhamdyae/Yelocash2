import 'package:flutter/material.dart';

class MyColor {
  static const Color primary = Color(0xFF0A146E);
  // static const Color primary = Color(0xFFFF6D33);
  static const Color white = Color(0xFFFFFFFF);
  static const Color title = Color(0xFF292929);
  static const Color bg1 = Color(0xFFF9F9F9);
  static const Color body1 = Color(0xFF777777);
  static const Color body2 = Color(0xFF555555);
  static const Color unslectedTab = Color(0xFFe0e0e0);

  static const Color primaryColor = primary;
    static const Color delteBtnColor = redCancelTextColor;
  static const Color secondaryColor = Color(0xffF6F7FE);
  static const Color screenBgColor = Color(0xFFF9F9F9);
  static const Color primaryTextColor = Color(0xff262626);
  static const Color contentTextColor = Color(0xff777777);
  static const Color inputFillColor  = Colors.transparent;
   static const Color dividerColor =  Color(0xff30424A);
  static const Color lineColor = Color(0xffECECEC);
  static const Color titleColor = Color(0xFF292929);
  static const Color borderColor = Color(0xFFF2F2F2);
  static const Color bodyTextColor = Color(0xFF747475);

  static const Color labelTextColor = Color(0xff444444);
  static const Color smallTextColor1 = Color(0xff555555);

  static const Color appBarColor = primaryColor;
  static const Color appBarContentColor = colorWhite;

  static const Color textFieldDisableBorderColor = Color(0xffCFCEDB);
  static const Color textFieldEnableBorderColor = primaryColor;
  static const Color hintTextColor = Color(0xFFB0B0B0);

  static const Color lBorderColor = Color(0xffeff1f3);
     static const Color ticketDateColor = Color(0xff888888);

  static const Color primaryButtonColor = primaryColor;
  static const Color primaryButtonTextColor = colorWhite;
  static const Color secondaryButtonColor = colorWhite;
  static const Color secondaryButtonTextColor = colorBlack;

  static const Color iconColor = Color(0xff555555);
  static const Color filterEnableIconColor = primaryColor;
  static const Color filterIconColor = iconColor;

  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorBlack = Color(0xff262626);
  static const Color colorGreen = Color(0xff28C76F);
  static const Color colorRed = Color(0xFFD92027);
  static const Color colorGrey = Color(0xff555555);
  static const Color transparentColor = Colors.transparent;
  static const Color ticketDetails = Color(0xff5D5D5D);
  static const Color greenSuccessColor = greenP;
  static const Color redCancelTextColor = Color(0xFFF93E2C);
  static const Color highPriorityPurpleColor = Color(0xFF7367F0);
  static const Color pendingColor = Colors.orange;
  static const Color purpleAcccent = Color(0xFF7C4DFF);

  static const Color greenP = Color(0xFF28C76F);
  static const Color containerBgColor = Color(0xffF9F9F9);

  static Color getPrimaryColor() {
    return primaryColor;
  }
       static Color getPrupleColor() {
    return highPriorityPurpleColor;
  }

  static Color getScreenBgColor() {
    return screenBgColor;
  }
   static Color getRedCancelTextColor() {
    return redCancelTextColor;
  }
   static Color getPendingColor() {
    return MyColor.pendingColor;
  }
     static Color getPrupleAccentColor() {
    return purpleAcccent;
  }
   static Color getBodyTextColor() {
    return bodyTextColor;
  }
    static Color getBorderColor() {
    return lBorderColor;
  }
   static Color getDeleteButtonColor() {
    return delteBtnColor;
  }
      static Color getRedColor() {
    return colorRed;
  }
    static Color getGreenColor() {
    return greenP;
  }
  static Color getGreyText() {
    return MyColor.colorBlack.withOpacity(0.5);
  }
      static Color getGreyColor() {
    return MyColor.colorGrey;
  }

  static Color getAppBarColor() {
    return appBarColor;
  }
   static Color getTicketDetailsColor() {
    return ticketDetails;
  }

  static Color getAppBarContentColor() {
    return appBarContentColor;
  }

  static Color getHeadingTextColor() {
    return primaryTextColor;
  }

  static Color getContentTextColor() {
    return contentTextColor;
  }

  static Color getLabelTextColor() {
    return labelTextColor;
  }

  static Color getHintTextColor() {
    return hintTextColor;
  }

  static Color getTextFieldDisableBorder() {
    return textFieldDisableBorderColor;
  }

  static Color getTextFieldEnableBorder() {
    return textFieldEnableBorderColor;
  }

  static Color getPrimaryButtonColor() {
    return primaryButtonColor;
  }

  static Color getPrimaryButtonTextColor() {
    return primaryButtonTextColor;
  }

  static Color getSecondaryButtonColor() {
    return secondaryButtonColor;
  }

  static Color getSecondaryButtonTextColor() {
    return secondaryButtonTextColor;
  }

  static Color getIconColor() {
    return iconColor;
  }

  static Color getFilterDisableIconColor() {
    return filterIconColor;
  }

  static Color getSearchEnableIconColor() {
    return colorRed;
  }

  static Color getTransparentColor() {
    return transparentColor;
  }

  static Color getTextColor() {
    return colorBlack;
  }

  static Color getCardBgColor() {
    return colorWhite;
  }

  static List<Color> symbolPlate = [
    const Color(0xffDE3163),
    const Color(0xffC70039),
    const Color(0xff900C3F),
    const Color(0xff581845),
    const Color(0xffFF7F50),
    const Color(0xffFF5733),
    const Color(0xff6495ED),
    const Color(0xffCD5C5C),
    const Color(0xffF08080),
    const Color(0xffFA8072),
    const Color(0xffE9967A),
    const Color(0xff9FE2BF),
  ];

  static getSymbolColor(int index) {
    int colorIndex = index > 10 ? index % 10 : index;
    return symbolPlate[colorIndex];
  }
}
