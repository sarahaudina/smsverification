import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:sms_verification/movas/observable/theme/theme_observable.dart';

class TraeteloDefaultTheme implements ThemeO {
  @override
  Color get alertDialogAcceptText =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  TextStyle get alertDialogBodyTextStyle => TextStyle();

  @override
  TextStyle get alertDialogButtonTextStyle => TextStyle();

  @override
  Color get alertDialogOKText =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get alertDialogOutline =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get alertDialogSaveDraftText =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get alertDialogTextFieldColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  TextStyle get alertDialogTitleTextStyle => TextStyle();

  @override
  Color get defaultText =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get inputBackground =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get inputHint =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  TextStyle get titleStyle => TextStyle();

  @override
  Color get loadingIndicatorColor => Color(0xffE3FE49);

  @override
  Color get navBarLineColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get primary => Color.fromRGBO(109, 174, 66, 1);

  @override
  Color get primaryAccent => Color(0xff73CB5F);

  @override
  Color get primaryButton =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get primaryButtonText =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get primaryLight =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get selectableIconButtonOutline =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get sliderContainerColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get sliderOverlayColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Color get sliderThumbColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  LinearGradient get primaryButtonGradient => LinearGradient(
        colors: [
          Color(0xFFE9FC6A),
          Color.fromRGBO(109, 174, 66, 1),
        ],
        stops: [0, 0.2],
      );

  @override
  Color get disabledButtonColor => Color(0xFFF3F3F3);

  @override
  Color get greyButton => Color(0xFFF3F3F3);

  @override
  Color get redButton => Color(0xffF6DBE0);

  @override
  LinearGradient get greyGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.grey.shade200,
          Colors.grey.shade500,
        ],
      );

  @override
  Color get disabledButtonTextColor => Color(0xff434343);

  @override
  Color get navBarItemColor => Color(0xff434343);

  @override
  Color get gradientTextColor => Colors.white;

  @override
  Color get lightTextColor => Colors.white;

  @override
  Color get darkTextColor => Colors.black;

  @override
  Color get emptyCartColor => Color(0xff807b78);

  @override
  Color get departmentHeaderNavColor => Colors.white;

  @override
  Color get loadingBackgroundColor => Color(0xff22262d);
}
