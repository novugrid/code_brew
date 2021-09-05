import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/ui/theme/CodeBrewTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_validator/the_validator.dart';

class UIPasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final textColor;
  final String label;
  final UIAlignment labelAlignment;
  final Border border;
  final EdgeInsetsGeometry padding;
  final TextStyle labelStyle;
  final Color hintColor;
  final String hint;
  final FormFieldValidator<String> validator;
  final VoidCallback onEditingComplete;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;

  UIPasswordField({
    this.passwordController,
    this.textColor,
    this.label,
    this.labelStyle,
    this.labelAlignment = UIAlignment.top,
    this.border,
    this.padding,
    this.hintColor,
    this.hint = "",
    this.validator,
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<StatefulWidget> createState() => _UIPasswordField();
}

class _UIPasswordField extends State<UIPasswordField> {
//  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    Widget container;
    Color textColor = widget.textColor;
    // Color labelColor = widget.labelColor;
    Color hintColor = widget.hintColor;

    if (textColor == null) {
      textColor = Colors.white;
    }

    if (hintColor == null) {
      hintColor = Colors.white24;
    }

    final ThemeData theme = Theme.of(context);

    Widget current = TextFormField(
      controller: widget.passwordController,
      autovalidate: widget.passwordController != null ? widget.passwordController.text.isNotEmpty : false,
      style: CodeBrewTheme.textFieldStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        // hintStyle: TextStyle(color: hintColor),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        // errorText: passwordFieldError,
        suffixStyle: TextStyle(),
        errorStyle: TextStyle(fontSize: 10),
        suffix: InkWell(
          onTap: () {
            togglePasswordVisibility();
          },
          child: Container(
            width: 18,
            height: 18,
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white, size: 18),
          ),
        ),
      ),
      obscureText: obscurePassword,
      //textAlign: TextAlign.left,
      inputFormatters: widget.inputFormatters ?? [],
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator ??
          FieldValidator.password(
              minLength: 8,
              shouldContainNumber: true,
              shouldContainCapitalLetter: true,
              shouldContainSpecialChars: true,
              errorMessage: "Password must match the required format",
              onNumberNotPresent: () {
                return "Password must contain number";
              },
              onSpecialCharsNotPresent: () {
                return "Password must contain special characters";
              },
              onCapitalLetterNotPresent: () {
                return "Password must contain capital letters";
              }),
      onChanged: (val) {},
      onEditingComplete: widget.onEditingComplete ?? () {},
    );

    if (widget.label != null) {
      TextStyle labelStyle = widget.labelStyle;
      if (labelStyle == null) {
        labelStyle = theme.inputDecorationTheme.labelStyle;
      }
      Widget label = Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          widget.label,
          style: labelStyle,
        ),
      );

      switch (widget.labelAlignment) {
        case UIAlignment.left:
          container = Row(
            children: [label, current],
          );
          break;
        case UIAlignment.right:
          container = Row(
            children: <Widget>[current, label],
          );
          break;
        case UIAlignment.top:
          container = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[label, current],
          );
          break;
        case UIAlignment.bottom:
          container = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[current, label],
          );
          break;
      }
    } else {
      container = Container(
        child: current,
      );
    }

    //  get Border
    Border border = Border();
    BorderRadius borderRadius = BorderRadius.zero;
    if (widget.border == null) {
      border = Border.fromBorderSide(theme.inputDecorationTheme.border.borderSide);
      if (theme.inputDecorationTheme.border.isOutline) {
        OutlineInputBorder outlineInputBorder = theme.inputDecorationTheme.border as OutlineInputBorder;
        borderRadius = outlineInputBorder.borderRadius;
      }
    } else {
      border = widget.border;
    }

    //  get padding
    EdgeInsetsGeometry padding = widget.padding;
    if (widget.padding == null) {
      padding = theme.inputDecorationTheme.contentPadding;
    }

    container = Container(
      padding: padding,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: theme.inputDecorationTheme.fillColor,
      ),
      child: container,
    );
    return container;
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}
