import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_verification/movas/view/page/sms_verification/user_phone_number.dart';
import 'package:sms_verification/movas/view/widget/button/traetelo_button.dart';
import 'package:sms_verification/movas/view/widget/input/traetelo_form_builder_phone_field.dart';

class PhoneConfirmationDialog extends StatefulWidget {
  final UserPhoneNumber phoneNumber;

  PhoneConfirmationDialog({this.phoneNumber});

  @override
  State<StatefulWidget> createState() {
    return _PhoneConfirmationDialogState();
  }
}

class _PhoneConfirmationDialogState extends State<PhoneConfirmationDialog> {
  FocusNode focusNode = FocusNode();
  final TextEditingController inputController = TextEditingController();
  double spacing = 20;
  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2));
  var elementsTextStyle = TextStyle(color: Colors.grey);
  var inputTextStyle = TextStyle(color: Colors.black);
  final GlobalKey<CustomFormBuilderPhoneFieldState> CustomFormBuilderPhoneFieldKey = GlobalKey();

  @override
  void initState() {
    inputController.text = widget.phoneNumber.normalizedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: 330, minHeight: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Cambie el número",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Color(0xff434343), fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomFormBuilderPhoneField(
                key: CustomFormBuilderPhoneFieldKey,
                validateOnChange: true,
                keyboardType: TextInputType.phone,
                controller: inputController,
                focusNode: focusNode,
                onEditingComplete: () {
                  return focusNode.unfocus();
                },
                style: inputTextStyle,
                decoration: InputDecoration(
                  border: outlineInputBorder,
                  disabledBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: elementsTextStyle,
                  labelText: "Número",
                ),
                defaultSelectedCountryIsoCode: widget.phoneNumber.countryIsoCode,
              ),
              SizedBox(
                height: 40,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TraeteloButton.grey(
                          compressed: true,
                          bold: true,
                          text: "Cancelar",
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TraeteloButton.gradient(
                          compressed: true,
                          bold: true,
                          onTap: () {
                            Navigator.of(context).pop(CustomFormBuilderPhoneFieldKey.currentState.userPhoneNumber);
                          },
                          text: "Confirmar",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
