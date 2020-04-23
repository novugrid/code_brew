import 'package:code_brew/src/ui/UICodeBrew.dart';
import 'package:flutter/material.dart';

enum UIButtonType { raised, flat, outline }

class UIButton extends MaterialButton {
  final UIButtonType type;
  final VoidCallback onPressed;
  final Widget child;
  final String text;
  final Widget icon;
  final UIAlignment iconAlignment;
  final double iconSpacing;
  final Color color;
  final Color textColor;
  final double borderWidth;
  final bool fillContainer;
  final double height;
  final EdgeInsets padding;
  final Alignment alignment;

  const UIButton({
    this.type,
    @required this.onPressed,
    this.child,
    this.text,
    this.alignment,
    this.icon,
    this.iconAlignment = UIAlignment.left,
    this.iconSpacing = 0,
    this.color,
    this.textColor,
    this.borderWidth = 1.0,
    this.fillContainer = false,
    this.height,
    this.padding
  }) : super(onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Color color = this.color;
    Color textColor = this.textColor;
    // height = theme.buttonTheme.height;

    if (color == null) {
      color = theme.buttonColor;
    }

    if (textColor == null) {
      textColor = theme.textTheme.button.color;
    }


    Widget current = child;
    if (child == null) {
      current = Text(text ?? "");
    }


    if (icon != null) {
      switch (iconAlignment) {
        case UIAlignment.left:
          current = Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[icon, SizedBox(width: this.iconSpacing,), current],
          );
          break;
        case UIAlignment.right:
          current = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[current, SizedBox(width: this.iconSpacing,), icon],
          );
          break;
        case UIAlignment.top:
          current = Column(
            children: <Widget>[icon, SizedBox(width: this.iconSpacing,), current],
          );
          break;
        case UIAlignment.bottom:
          current = Column(
            children: <Widget>[current, SizedBox(width: this.iconSpacing,), icon],
          );
          break;
      }
    }

    Widget button;
    switch (type) {
      case UIButtonType.raised:
        button = RaisedButton(
          onPressed: onPressed,
          child: current,
          color: color,
          textColor: textColor,
          padding: this.padding,
        );
        break;
      case UIButtonType.flat:
        button = FlatButton(
          onPressed: onPressed,
          child: current,
          textColor: textColor,
          // color: color, // Note: Flat Dont need colors
          padding: this.padding,
        );
        break;
      case UIButtonType.outline:
        button = OutlineButton(onPressed: onPressed,
          child: current,
          color: color,
          borderSide: BorderSide(color: color),
          textColor: textColor,
          padding: this.padding,

        );
        break;
    }

    if (fillContainer || alignment != null) {
      button = Container(
        width: fillContainer ? double.infinity : theme.buttonTheme.minWidth,
        height: height ?? theme.buttonTheme.height,
        alignment: this.alignment,
        child: button,
      );
    }

    return button;
  }
}
