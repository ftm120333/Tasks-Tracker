import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class Res {
  ///Image Assets

  /// Main page Icons

  ///Font sizes
  static const double titleFontSize = 25;
  static const double titleFontSizeLS = 30;
  static const double subTitleFontSize = 18;
  static const double textFontSizeLS = 20;
  static const double textFontSize = 14;
  static const double hintFontSize = 12;
  static const double subTextFontSizeL = 12;
  static const double subTextFontSizeS = 11;
  static const double mainIconSize = 48;
  static const double bigIconSize = 34;
  static const double smallIconSize = 24;

  ///Icons
  static const String appIcon = "assets/appIcon.png";

  ///Colors
  static final HexColor kPrimaryColor = HexColor("#11294B");
  static final HexColor sPrimaryColor = HexColor("#FFC767");
  static final HexColor dGrayColor = HexColor("#D5D5D5");
  static final HexColor lGrayColor = HexColor("#D5D5D5");
  static final HexColor lGrayColor2 = HexColor("#FAFAFA");
  static final HexColor ddGrayColor = HexColor("#555555");
  static final HexColor whiteColor = HexColor("#ffffff");
  static final HexColor blackColor = HexColor("#000000");
  static final HexColor grey = HexColor("#e5e5e5");
  static final HexColor chatColor = HexColor("#DFDFE0");
  static final HexColor chatGray = HexColor("#B1B1C2");
  static final HexColor chatGray2 = HexColor("#F3F4F8");
  static final HexColor dGreen = HexColor("#0DA8AA");
  static final HexColor lightGreen = HexColor("#55C3BB");

  ///Fonts

  static TextStyle titleStyle = TextStyle(
      color: Res.blackColor,
      fontSize: Res.subTitleFontSize,
      fontWeight: FontWeight.bold);
  static TextStyle TitleStyleLS = TextStyle(
      color: Res.blackColor,
      fontSize: Res.titleFontSizeLS,
      fontWeight: FontWeight.bold);
  static TextStyle TitleStyleGrey = TextStyle(
      color: Res.dGrayColor,
      fontSize: Res.titleFontSize,
      fontWeight: FontWeight.bold);
  static TextStyle TitleStyleGreyLS = TextStyle(
      color: Res.dGrayColor,
      fontSize: Res.titleFontSizeLS,
      fontWeight: FontWeight.bold);
  static TextStyle TitleStyleWhite = TextStyle(
      color: Res.whiteColor,
      fontSize: Res.subTitleFontSize,
      fontWeight: FontWeight.bold);
  static TextStyle SubTitleStyle =
      TextStyle(color: Res.kPrimaryColor, fontSize: Res.subTitleFontSize);
  static TextStyle textStyleDarkGrey = //subTextFontSizeL
      TextStyle(color: Res.ddGrayColor, fontSize: Res.textFontSize);
  static TextStyle textStyleDropDownItems =
      TextStyle(color: Res.ddGrayColor, fontSize: Res.subTextFontSizeS);
  static TextStyle textStyleDarkGreyLS =
      TextStyle(color: Res.ddGrayColor, fontSize: Res.textFontSizeLS);
  static TextStyle textStyleBoldDarkGrey = TextStyle(
      color: Res.ddGrayColor,
      fontSize: Res.textFontSize,
      fontWeight: FontWeight.bold);
  static TextStyle subtextStyleDarkGrey =
      TextStyle(color: Res.ddGrayColor, fontSize: Res.subTextFontSizeS);
  static TextStyle hintTextStyleGrey =
      TextStyle(color: Res.grey, fontSize: Res.hintFontSize);
  static TextStyle textStyleBoldGrey = TextStyle(
      color: Res.dGrayColor,
      fontSize: Res.textFontSize,
      fontWeight: FontWeight.bold);

  static TextStyle textStyleBoldPrimaryColor = TextStyle(
      color: Res.kPrimaryColor,
      fontSize: Res.textFontSize,
      fontWeight: FontWeight.bold);

  static TextStyle textStyleNormalWhiteL = TextStyle(
    color: Res.whiteColor,
    fontSize: Res.textFontSize,
  );
  static TextStyle textStyleNormalWhiteLLS = TextStyle(
    color: Res.whiteColor,
    fontSize: Res.textFontSizeLS,
  );
  static TextStyle textStyleNormalWhiteM = TextStyle(
    color: Res.whiteColor.withOpacity(0.8),
    fontSize: Res.subTextFontSizeL,
  );

  static final ShapeBorder roundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      // topLeft: Radius.circular(20.0),
      //  topRight: Radius.circular(10.0),
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
    ),
  );
}
