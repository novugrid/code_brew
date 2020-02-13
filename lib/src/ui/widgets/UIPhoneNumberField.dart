import 'package:code_brew/src/uiservices/NumberOnlyTextInputFormatter.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_validator/the_validator.dart';

class UIPhoneNumberField extends FormField<String> {
  // final ValueChanged<int> onCountryCodeChanged;

  UIPhoneNumberField({
    FormFieldSetter onSaved,
    FormFieldValidator<String> validator,
    String initialValue = "",
    String initialPhoneCode,
    bool autoValidate = false,
    void Function(CountryCode) onCountryCodeChanged,
    void Function(String) onChanged,
  }) : super(

            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autoValidate,
            builder: (FormFieldState<String> state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: state.hasError ? Border.all(color: Colors.red) : null,
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: <Widget>[
                    CountryCodePicker(
                      onChanged: onCountryCodeChanged,
                      initialSelection: initialPhoneCode ?? 'NG',
                      // : initialPhoneCode,
                      favorite: ['+234'],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      textStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontFamily: "SourceSansPro"),
                      alignLeft: false,
                      padding: EdgeInsets.only(right: 10.0, left: 15.0, bottom: 3.0),
                      searchDecoration: InputDecoration(
                        hintText: "Search Country",
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: initialValue,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                        ),
                        textAlign: TextAlign.start,
                        // validator: FieldValidator.required(message: "Phone number must not be empty"),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(16),
                          NumberOnlyTextInputFormatter()
                        ],
                        onChanged: (val) {
                          // notify the main body of new values
                          onChanged(val);
                          state.didChange(val);
                        },
                      ),
                    ),
                  ],
                ),
              );
            });

// @override
// State<StatefulWidget> createState() => _PoPhoneNumberFieldState();

}

/*class _PoPhoneNumberFieldState extends State<PoPhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (formState) {

      },
      validator:
          FieldValidator.required(message: "Phone number must not be empty"),
    );
  }
}*/


