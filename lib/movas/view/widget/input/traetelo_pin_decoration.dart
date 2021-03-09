import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:pin_input_text_field/src/builder/color_builder.dart';
import 'package:pin_input_text_field/src/style/obscure.dart';
import 'package:pin_input_text_field/src/util/radius_util.dart';
import 'package:pin_input_text_field/src/util/utils.dart';
import 'package:pin_input_text_field/src/decoration/pin_decoration.dart';

/// The object determine the box stroke etc.
class CustomBoxLooseDecoration extends PinDecoration implements SupportGap {
  /// The box border radius.
  final Radius radius;

  /// The box border width.
  final double strokeWidth;

  /// The adjacent box gap.
  final double gapSpace=16;

  /// The gaps between every two adjacent box, higher priority than [gapSpace].
  final List<double> gapSpaces;

  /// The box border color of index character.
  final ColorBuilder strokeColorBuilder;

  /// The background color of index character.
  final ColorBuilder bgColorBuilder;

  final double preferredPinWidth = 54;

  final double preferredHeight = 68;

  const CustomBoxLooseDecoration({
    TextStyle textStyle,
    ObscureStyle obscureStyle,
    String errorText,
    TextStyle errorTextStyle,
    String hintText,
    TextStyle hintTextStyle,
    this.radius: const Radius.circular(8.0),
    this.strokeWidth: 1.0,
    // this.gapSpace: 16.0,
    this.gapSpaces,
    @required this.strokeColorBuilder,
    this.bgColorBuilder,
    // this.pinWidth
    // this.preferredHeight,
  })  : assert(strokeColorBuilder != null),
        super(
        textStyle: textStyle,
        obscureStyle: obscureStyle,
        errorText: errorText,
        errorTextStyle: errorTextStyle,
        hintText: hintText,
        hintTextStyle: hintTextStyle,
        bgColorBuilder: bgColorBuilder,
      );

  @override
  PinEntryType get pinEntryType => PinEntryType.boxLoose;

  @override
  PinDecoration copyWith({
    TextStyle textStyle,
    ObscureStyle obscureStyle,
    String errorText,
    TextStyle errorTextStyle,
    String hintText,
    TextStyle hintTextStyle,
    ColorBuilder bgColorBuilder,
  }) {
    return CustomBoxLooseDecoration(
      textStyle: textStyle ?? this.textStyle,
      obscureStyle: obscureStyle ?? this.obscureStyle,
      errorText: errorText ?? this.errorText,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      hintText: hintText ?? this.hintText,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      strokeColorBuilder: this.strokeColorBuilder,
      strokeWidth: this.strokeWidth,
      radius: this.radius,
      // gapSpace: this.gapSpace,
      gapSpaces: this.gapSpaces,
      bgColorBuilder: this.bgColorBuilder,
      // pinWidth: this.pinWidth
      // preferredHeight: this.preferredHeight
    );
  }

  @override
  void notifyChange(String pin) {
    strokeColorBuilder.notifyChange(pin);
    bgColorBuilder?.notifyChange(pin);
  }

  @override
  void drawPin(
      Canvas canvas,
      Size size,
      String text,
      int pinLength,
      Cursor themeData,
      ) {
    /// Calculate the height of paint area for drawing the pin field.
    /// it should honor the error text (if any) drawn by
    /// the actual texfield behind.
    /// but, since we can access the drawn textfield behind from here,
    /// we use a simple logic to calculate it.
    double mainHeight;
    if (errorText != null && errorText.isNotEmpty) {
      mainHeight = preferredHeight + (errorTextStyle.fontSize + 3.0);
    } else {
      mainHeight = preferredHeight;
    }

    Paint borderPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    double gapTotalLength =
        gapSpaces?.reduce((a, b) => a + b) ?? (pinLength - 1) * gapSpace;

    List<double> actualGapSpaces =
        gapSpaces ?? List.filled(pinLength - 1, gapSpace);

    /// Calculate the width of each underline.
    double singleWidth = preferredPinWidth;
    if (size.width < preferredPinWidth*pinLength + (pinLength-1)*gapSpace) {
      singleWidth = (size.width - ((pinLength-1)*gapSpace)) / pinLength;

      /// Update height to keep proportion
      mainHeight = preferredHeight/preferredPinWidth*singleWidth;
    }

    double leftPadding = (size.width - pinLength*singleWidth - (pinLength-1)*gapSpace - strokeWidth*2*pinLength) / 2;

    var startX = leftPadding + strokeWidth / 2;
    var startY = mainHeight - strokeWidth / 2;

    /// Assign paint if [bgColorBuilder] is not null
    Paint insidePaint;
    if (bgColorBuilder != null) {
      insidePaint = Paint()
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;
    }

    /// Draw the each rect of pin.
    for (int i = 0; i < pinLength; i++) {
      if (errorText != null && errorText.isNotEmpty) {
        /// only draw error-color as border-color or solid-color
        /// if errorText is not null
        borderPaint.color = errorTextStyle.color;
      } else {
        borderPaint.color = strokeColorBuilder.indexProperty(i);
      }
      RRect rRect = RRect.fromRectAndRadius(
          Rect.fromLTRB(
            startX,
            strokeWidth / 2,
            startX + singleWidth + strokeWidth,
            startY,
          ),
          radius);
      canvas.drawRRect(rRect, borderPaint);
      if (insidePaint != null) {
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTRB(
                  startX + strokeWidth / 2,
                  strokeWidth,
                  startX + singleWidth + strokeWidth / 2,
                  startY - strokeWidth / 2,
                ),
                getInnerRadius(radius, strokeWidth)),
            insidePaint..color = bgColorBuilder.indexProperty(i));
      }
      startX += singleWidth +
          strokeWidth * 2 +
          (i == pinLength - 1 ? 0 : actualGapSpaces[i]);
    }

    /// The char index of the [text]
    var index = 0;
    startY = 0.0;

    /// Determine whether display obscureText.
    bool obscureOn = obscureStyle != null && obscureStyle.isTextObscure;

    text.runes.forEach((rune) {
      String code;
      if (obscureOn) {
        code = obscureStyle.obscureText;
      } else {
        code = String.fromCharCode(rune);
      }
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          style: textStyle,
          text: code,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      /// Layout the text.
      textPainter.layout();

      /// No need to compute again
      if (startY == 0.0) {
        startY = mainHeight / 2 - textPainter.height / 2;
      }
      startX = leftPadding + singleWidth * index +
          singleWidth / 2 -
          textPainter.width / 2 +
          actualGapSpaces.take(index).sumList() +
          strokeWidth * index * 2 +
          strokeWidth;
      textPainter.paint(canvas, Offset(startX, startY));
      index++;
    });

    if (hintText != null) {
      hintText.substring(index).runes.forEach((rune) {
        String code = String.fromCharCode(rune);
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            style: hintTextStyle,
            text: code,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        /// Layout the text.
        textPainter.layout();

        startY = mainHeight / 2 - textPainter.height / 2;
        startX = singleWidth * index +
            singleWidth / 2 -
            textPainter.width / 2 +
            actualGapSpaces.take(index).sumList() +
            strokeWidth * index * 2 +
            strokeWidth;
        textPainter.paint(canvas, Offset(startX, startY));
        index++;
      });
    }
  }

  @override
  double get getGapWidth => gapSpace;

  @override
  List<double> get getGapWidthList => gapSpaces;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is CustomBoxLooseDecoration &&
              runtimeType == other.runtimeType &&
              radius == other.radius &&
              strokeWidth == other.strokeWidth &&
              gapSpace == other.gapSpace &&
              gapSpaces == other.gapSpaces &&
              strokeColorBuilder == other.strokeColorBuilder &&
              bgColorBuilder == other.bgColorBuilder;

  @override
  int get hashCode =>
      super.hashCode ^
      radius.hashCode ^
      strokeWidth.hashCode ^
      gapSpace.hashCode ^
      gapSpaces.hashCode ^
      strokeColorBuilder.hashCode ^
      bgColorBuilder.hashCode;

  @override
  String toString() {
    return 'BoxLooseDecoration{radius: $radius, strokeWidth: $strokeWidth, gapSpace: $gapSpace, gapSpaces: $gapSpaces, strokeColorBuilder: $strokeColorBuilder, bgColorBuilder: $bgColorBuilder}';
  }
}
