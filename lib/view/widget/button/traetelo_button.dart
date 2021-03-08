import 'package:flutter/material.dart';
import 'package:movas/movas.dart';
import 'package:sms_verification/observable/theme_observable.dart';

class TraeteloButton extends StatelessWidget {
  final VoidCallback onTap;
  final text;
  final TraeteloButtonType buttonType;
  final bool compressed;
  final Widget action;
  final bool bold;
  Color color;

  TraeteloButton(
      {this.onTap,
      this.text,
      this.compressed = false,
      this.action,
      this.bold = false,
      this.buttonType});

  TraeteloButton.gradient(
      {this.onTap,
      this.text,
      this.compressed = false,
      this.action,
      this.bold = false})
      : buttonType = TraeteloButtonType.gradient;

  TraeteloButton.grey(
      {this.onTap,
        this.text,
        this.compressed = false,
        this.action,
        this.bold = false})
      : buttonType = TraeteloButtonType.grey;

  TraeteloButton.color(
      {this.onTap,
        this.color,
        this.text,
        this.compressed = false,
        this.action,
        this.bold = false})
      : buttonType = TraeteloButtonType.color;

  bool get hasAction => action != null;

  @override
  Widget build(BuildContext context) {
    var title = Padding(
        padding: EdgeInsets.symmetric(vertical: compressed ? 14 : 22.0),
        child: text is Widget
            ? text
            : Text(
                text,
                style: TextStyle(
                    color: getTextColor(context),
                    fontSize: compressed ? 16 : 19,
                    fontWeight: bold ? FontWeight.w900 : FontWeight.normal),
                textAlign: TextAlign.center,
              ));
    return Container(
      decoration: buildDecoration(context),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: onTap,
        child: hasAction
            ? Row(
                children: <Widget>[
                  Spacer(),
                  FittedBox(fit: BoxFit.fitHeight, child: title),
                  Flexible(
                      flex: 5,
                      child: Align(
                          alignment: Alignment.centerRight, child: action))
                ],
              )
            : title,
      ),
    );
  }

  BoxDecoration buildDecoration(BuildContext context) {
    ThemeO theme = StaticProvider.of(context);

    if (onTap == null) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.disabledButtonColor,
      );
    }

    if (buttonType == TraeteloButtonType.gradient) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: theme.primaryButtonGradient,
      );
    }
    if (buttonType == TraeteloButtonType.grey) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.greyButton,
      );
    }
    if (buttonType == TraeteloButtonType.color) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: this.color,
      );
    }

  }

  Color getTextColor(BuildContext context) {
    ThemeO theme = StaticProvider.of(context);

    if (onTap == null) {
      return theme.disabledButtonTextColor;
    }

    if (buttonType == TraeteloButtonType.gradient) {
      return theme.gradientTextColor;
    }
    if (buttonType == TraeteloButtonType.grey) {
      return theme.disabledButtonTextColor;
    }
    if (buttonType == TraeteloButtonType.greyGradient) {
      return theme.darkTextColor;
    }
    if (buttonType == TraeteloButtonType.red) {
      return theme.darkTextColor;
    }
    return Colors.black;
  }
}

enum TraeteloButtonType { gradient, grey, greyGradient, red, color}
