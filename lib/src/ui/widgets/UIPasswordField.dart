import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';

class UIPasswordField extends StatefulWidget {

  final TextEditingController passwordController;

  UIPasswordField({this.passwordController});

  @override
  State<StatefulWidget> createState() => _UIPasswordField();

}

class _UIPasswordField extends State<UIPasswordField> {

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      autovalidate: widget.passwordController.text.isNotEmpty,
      decoration: InputDecoration(
        hintText: "Password",
        // errorText: passwordFieldError,
        suffixIcon: InkWell(
          onTap: () {
            togglePasswordVisibility();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
                obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: 18),
          ),
        ),
      ),
      obscureText: obscurePassword,
      textAlign: TextAlign.center,
      validator: FieldValidator.password(
          minLength: 8,
          shouldContainNumber: true,
          shouldContainCapitalLetter: true,
          shouldContainSpecialChars: true,
          errorMessage: "Password must match the required format",
          isNumberNotPresent: () {
            return "Password must contain number";
          },
          isSpecialCharsNotPresent: () {
            return "Password must contain special characters";
          },
          isCapitalLetterNotPresent: () {
            return "Password must contain capital letters";
          }),
      onChanged: (val) {},
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

}
