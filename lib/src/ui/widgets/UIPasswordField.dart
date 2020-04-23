import 'package:code_brew/code_brew.dart';
import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';
import 'package:code_brew/src/ui/theme/CodeBrewTheme.dart';

class UIPasswordField extends StatefulWidget {
//  final TextEditingController passwordController;
  final textColor;
  final String label;
  final UIAlignment labelAlignment;
  final Border border;
  final EdgeInsetsGeometry padding;
  final Color labelColor;
  final Color hintColor;
  final String hint;

  UIPasswordField({
//    this.passwordController,
    this.textColor,
    this.label,
    this.labelColor,
    this.labelAlignment = UIAlignment.top,
    this.border,
    this.padding,
    this.hintColor,
    this.hint = "",
  });

  @override
  State<StatefulWidget> createState() => _UIPasswordField();
}

class _UIPasswordField extends State<UIPasswordField> {
//  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.textColor;
    Color labelColor = widget.labelColor;
    Color hintColor = widget.hintColor;

    if (textColor == null) {
      textColor = Colors.white;
    }

    if (labelColor == null) {
      labelColor = Colors.white;
    }

    if (hintColor == null) {
      hintColor = Colors.white24;
    }


    final ThemeData theme = Theme.of(context);

    Widget current2 = TextFormField(
      /*controller: passwordController,
      autovalidate: passwordController != null
          ? passwordController.text.isNotEmpty
          : false,*/
      style: CodeBrewTheme.textFieldStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: hintColor),
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
            child: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
                size: 18),
          ),
        ),
      ),
      obscureText: obscurePassword,
      //textAlign: TextAlign.left,
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

    Widget current = TextField(
      style: CodeBrewTheme.textFieldStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: hintColor),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        /*suffix: InkWell(
          onTap: () {
            togglePasswordVisibility();
          },
          child: Container(
            width: 18,
            height: 18,
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
                size: 18),
          ),
        ),*/
      ),

    );
    Widget container;

    if (widget.label != null) {
      Widget label = Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          widget.label,
          style: TextStyle(color: labelColor),
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
      border =
          Border.fromBorderSide(theme.inputDecorationTheme.border.borderSide);
      if (theme.inputDecorationTheme.border.isOutline) {
        OutlineInputBorder outlineInputBorder =
        theme.inputDecorationTheme.border as OutlineInputBorder;
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
