import 'package:code_brew/src/ui/UICodeBrew.dart';
import 'package:flutter/material.dart';

enum UIButtonType { raised, flat, outline}

class UIButton extends MaterialButton {
  final UIButtonType type;
  final VoidCallback onPressed;
  final Widget child;
  final String text;
  final Icon icon;
  final UIAlignment iconAlignment;
  final Image image;
  final UIAlignment imageAlignment;

  const UIButton({
    this.type,
    @required this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.iconAlignment = UIAlignment.left,
    this.image,
    this.imageAlignment = UIAlignment.left,
  }): super(onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    Widget current = child;
    if (child == null) {
      current = Text(text ?? "");
    }


    if (icon != null) {
      switch (iconAlignment) {
        case UIAlignment.left:
          current = Row(
            children: <Widget>[icon, current],
          );
          break;
        case UIAlignment.right:
          current = Row(
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
        );
        break;
      case UIButtonType.flat:
        button = FlatButton(
          onPressed: onPressed,
          child: current,
        );
        break;
      case UIButtonType.outline:
        button = OutlineButton(onPressed: onPressed, child: current);
        break;
    }


    return button;
  }
}
