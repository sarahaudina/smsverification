import 'package:flutter/painting.dart';

abstract class ThemeO {
  final Color primary;
  final Color primaryAccent;
  final Color primaryLight;

  //Inputs
  final Color inputBackground;
  final Color inputHint;

  //Loading
  final Color loadingBackgroundColor;

  //Buttons
  final Color primaryButton;
  final Color primaryButtonText;
  final Color selectableIconButtonOutline;
  final Color disabledButtonColor;
  final Color redButton;
  final Color greyButton;

  //Text
  final Color defaultText;
  final Color disabledButtonTextColor;
  final TextStyle titleStyle;
  final Color gradientTextColor;

  final Color lightTextColor;
  final Color darkTextColor;

  //Alert dialog
  final Color alertDialogOutline;
  final Color alertDialogOKText;
  final Color alertDialogAcceptText;
  final Color alertDialogSaveDraftText;
  final TextStyle alertDialogTitleTextStyle;
  final TextStyle alertDialogBodyTextStyle;
  final TextStyle alertDialogButtonTextStyle;
  final Color alertDialogTextFieldColor;

  //Loading
  final Color loadingIndicatorColor;

  //Slider
  final Color sliderThumbColor;
  final Color sliderOverlayColor;
  final Color sliderContainerColor;

  //Nav bar
  final Color navBarLineColor;
  final Color navBarItemColor;
  final Color emptyCartColor;
  final Color departmentHeaderNavColor;

  //Gradients
  final LinearGradient primaryButtonGradient;
  final LinearGradient greyGradient;

  const ThemeO({
    this.primary,
    this.primaryAccent,
    this.primaryLight,
    this.inputBackground,
    this.inputHint,
    this.primaryButton,
    this.primaryButtonText,
    this.defaultText,
    this.alertDialogOutline,
    this.alertDialogOKText,
    this.alertDialogAcceptText,
    this.alertDialogSaveDraftText,
    this.alertDialogBodyTextStyle,
    this.alertDialogTitleTextStyle,
    this.alertDialogTextFieldColor,
    this.alertDialogButtonTextStyle,
    this.loadingIndicatorColor,
    this.sliderThumbColor,
    this.sliderOverlayColor,
    this.sliderContainerColor,
    this.navBarLineColor,
    this.titleStyle,
    this.selectableIconButtonOutline,
    this.primaryButtonGradient,
    this.greyGradient,
    this.disabledButtonColor,
    this.greyButton,
    this.redButton,
    this.disabledButtonTextColor,
    this.navBarItemColor,
    this.gradientTextColor,
    this.lightTextColor,
    this.darkTextColor,
    this.emptyCartColor,
    this.departmentHeaderNavColor,
    this.loadingBackgroundColor,
  });
}
