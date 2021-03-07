import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/action/account_info_action.dart';
import 'package:sms_verification/action/sms_verification_action.dart';
import 'package:sms_verification/store/account_info_store.dart';
import 'package:sms_verification/view/page/sms_verification/sms_verification_page.dart';
import 'package:sms_verification/view/page/sms_verification/user_phone_number.dart';
import 'package:sms_verification/view/widget/appbar/generic_appbar.dart';
import 'package:sms_verification/view/widget/button/traetelo_button.dart';
import 'package:sms_verification/view/widget/dialog/snackbar.dart';
import 'package:sms_verification/view/widget/input/traetelo_form_builder_phone_field.dart';
import 'package:sms_verification/view/widget/loading/loading_dialog.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    AccountInfoAction.of(context).fetchAccountInfo().then((value) {
      UserPhoneNumber.fromString(value.phone.principal).then((value) =>
          setState(() => _formBuilderPhoneFieldKey.currentState.updateNumber(value)));
    });

    super.initState();
  }

  var disableResendEmail = false;

  final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>(debugLabel: "profile");

  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.black, width: 3));

  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  final double spacing = 20;

  final GlobalKey<CustomFormBuilderPhoneFieldState> _formBuilderPhoneFieldKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountInfoO>(builder: (context, accountInfo, _) {
      return Scaffold(
        appBar: TraeteloAppBar.largeText2(title: 'Perfil de usuario'),
        body: Column(
          children: [
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormBuilder(
                        key: _fbKey,
                        initialValue: accountInfo.responseMap(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: spacing,
                            ),
                            FormBuilderTextField(
                              focusNode: focusNodes[0],
                              onEditingComplete: () {
                                return focusNodes[1].requestFocus();
                              },
                              attribute: "first_name",
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: outlineInputBorder,
                                  labelText: "Nombre",
                                  hintText: "Ingrese el nombre"),
                              validators: [FormBuilderValidators.required()],
                            ),
                            SizedBox(
                              height: spacing,
                            ),
                            FormBuilderTextField(
                              focusNode: focusNodes[1],
                              onEditingComplete: () {
                                return focusNodes[2].requestFocus();
                              },
                              attribute: "last_name",
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: outlineInputBorder,
                                  labelText: "Apellido",
                                  hintText: "Introduzca el apellido"),
                              validators: [FormBuilderValidators.required()],
                            ),
                            SizedBox(
                              height: spacing,
                            ),
                            FormBuilderRadioGroup(
                              attribute: 'gender',
                              wrapCrossAxisAlignment: WrapCrossAlignment.center,
                              wrapAlignment: WrapAlignment.center,
                              initialValue: accountInfo.response.gender,
                              options: [
                                FormBuilderFieldOption(
                                  child: Text('Hombre'),
                                  value: 'M',
                                ),
                                FormBuilderFieldOption(
                                  child: Text('Mujer'),
                                  value: 'F',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: spacing + 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "Correo Electrónico Verificado",
                                    // style: TextStyle(fontWeight: FontWeight.bold)
                                  ),
                                  SizedBox(
                                    width: spacing * .3,
                                  ),
                                  accountInfo.response.isVerifiedEmail
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: spacing * .3,
                            ),
                            FormBuilderTextField(
                              focusNode: focusNodes[2],
                              onEditingComplete: () {
                                return focusNodes[3].requestFocus();
                              },
                              readOnly: accountInfo.response.isVerifiedEmail,
                              attribute: "email",
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: outlineInputBorder,
                                  labelText: "Correo",
                                  hintText: "Ingrese Correo"),
                              validators: [FormBuilderValidators.email()],
                            ),
                            SizedBox(
                              height: spacing,
                            ),
                            if (!accountInfo.response.isVerifiedEmail)
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (!disableResendEmail) {
                                        // await loadingActionHandler(
                                        //     context,
                                        //     AccountInfoAction.of(context)
                                        //         .resendEmailVerification());

                                        setState(() {
                                          disableResendEmail = true;
                                        });
                                      }
                                    },
                                    child: Text(
                                      disableResendEmail
                                          ? 'El mensaje de verificación ha sido enviado'
                                          : 'Envia un correo electronico de verificación',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          decoration: disableResendEmail
                                              ? TextDecoration.none
                                              : TextDecoration.underline),
                                    ),
                                  ),
                                  SizedBox(
                                    height: spacing * 1.5,
                                  ),
                                ],
                              ),
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "Número verificado",
                                    // style: TextStyle(fontWeight: FontWeight.bold)
                                  ),
                                  SizedBox(
                                    width: spacing * .3,
                                  ),
                                  accountInfo.response.verifiedNumber
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: spacing * .3,
                            ),
                            CustomFormBuilderPhoneField(
                              key: _formBuilderPhoneFieldKey,
                              validateOnChange: true,
                              focusNode: focusNodes[3],
                              initialValue:
                                  accountInfo.response.phone.principal,
                              attribute: "principal",
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                              onEditingComplete: () {
                                return focusNodes[3].unfocus();
                              },
                              defaultSelectedCountryIsoCode: "VE",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: spacing,
                      ),
                      Builder(builder: (context) {
                        return TraeteloButton.gradient(
                          text: 'Actualizar',
                          onTap: () async {
                            focusNodes.forEach((element) {
                              element.unfocus();
                            });
                            if (_fbKey.currentState.saveAndValidate() &&
                                _formBuilderPhoneFieldKey
                                    .currentState.phoneNumberValid) {
                              showLoadingDialog(context);
                              var map = _fbKey.currentState.value;

                              if (_fbKey.currentState.fields["principal"]
                                          .currentState.value ==
                                      accountInfo.response.phone.principal &&
                                  accountInfo.response.verifiedNumber) {
                                // await AccountInfoAction.of(context)
                                //     .updateAccountInfo(map);

                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              } else {
                                try {
                                  final number = _fbKey.currentState
                                      .fields["principal"].currentState.value;
                                  await SmsVerificationAction.of(context)
                                      .verifyNumber(phoneNumber: number);

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SmsVerificationPage(
                                                  phoneNumber:
                                                      _formBuilderPhoneFieldKey
                                                          .currentState
                                                          .userPhoneNumber,
                                                  onComplete:
                                                      (phoneNumber, _) async {
                                                    map["principal"] =
                                                        phoneNumber;
                                                    map["verifiedNumber"] =
                                                        true;
                                                    // await loadingActionHandler(
                                                    //     context,
                                                    //     AccountInfoAction.of(
                                                    //             context)
                                                    //         .updateAccountInfo(
                                                    //             map));
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  })));
                                } catch (e) {
                                  Navigator.pop(context);
                                  if (e is DioError) {
                                    await Future(() {});
                                    showSnackBar(
                                        context,
                                        e?.response?.data?.toString() ??
                                            "Update error");
                                  }
                                }
                              }
                            }
                          },
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
