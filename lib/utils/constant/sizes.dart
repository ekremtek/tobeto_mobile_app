import 'package:flutter/material.dart';

abstract class SizeRadius {
  SizeRadius._();

  static double radius5px = 5;
  static double radius8px = 8;
  static double radius16px = 16;
  static double radius20px = 20;
}

abstract class ScreenUtil {
  ScreenUtil._();

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

abstract class ScreenPadding {
  ScreenPadding._();
  static double padding6px = 6;
  static double padding8px = 8;
  static double padding12px = 12;
  static double padding16px = 16;
  static double padding18px = 18;
  static double padding24px = 24;
  static double padding32px = 32;
  static double padding58px = 58;
  static double screenpadding = 24;
}

abstract class IconSize {
  IconSize._();
  static double size30px = 30;
  static double size35px = 35;
  static double size60px = 60;
}