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
  // final Image image;
  // final UIAlignment imageAlignment;
  final Color color;
  final Color textColor;
  final double borderWidth;


  const UIButton({
    this.type,
    @required this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.iconAlignment = UIAlignment.left,
    this.color,
    this.textColor,
    this.borderWidth = 1.0

  }) : super(onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Color color = this.color;
    Color textColor = this.textColor;

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[icon, current],
          );
          break;
        case UIAlignment.right:
          current = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[current, icon],
          );
          break;
        case UIAlignment.top:
          current = Column(
            children: <Widget>[icon, current],
          );
          break;
        case UIAlignment.bottom:
          current = Column(
            children: <Widget>[current, icon],
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
        );
        break;
      case UIButtonType.flat:
        button = FlatButton(
          onPressed: onPressed,
          child: current,
          textColor: textColor,
          color: color,
          
        );
        break;
      case UIButtonType.outline:
        button = OutlineButton(onPressed: onPressed,
          child: current,
          color: color,
          borderSide: BorderSide(color: color),
          textColor: textColor,);
        break;
    }
    


    return button;
  }
}
