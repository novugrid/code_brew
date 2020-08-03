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
  final double width;
  final EdgeInsets padding;
  final Alignment alignment;
  final double elevation;
  final ShapeBorder shape;
  final BorderSide borderSide;

  const UIButton({
    this.type,
    @required this.onPressed,
    this.child,
    this.text,
    this.alignment = Alignment.center,
    this.icon,
    this.iconAlignment = UIAlignment.left,
    this.iconSpacing = 0,
    this.color,
    this.textColor,
    this.borderWidth = 1.0,
    this.fillContainer = false,
    this.height,
    this.width,
    this.padding,
    this.elevation,
    this.shape,
    this.borderSide,
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
      current = Text(
        text ?? "",
        textAlign: TextAlign.left,
      );
    }

    if (icon != null) {
      switch (iconAlignment) {
        case UIAlignment.left:
          current = Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              SizedBox(
                width: this.iconSpacing,
              ),
              current
            ],
          );
          break;
        case UIAlignment.right:
          current = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              current,
              SizedBox(
                width: this.iconSpacing,
              ),
              icon
            ],
          );
          break;
        case UIAlignment.top:
          current = Column(
            children: <Widget>[
              icon,
              SizedBox(
                width: this.iconSpacing,
              ),
              current
            ],
          );
          break;
        case UIAlignment.bottom:
          current = Column(
            children: <Widget>[
              current,
              SizedBox(
                width: this.iconSpacing,
              ),
              icon
            ],
          );
          break;
      }
    }

    Widget button;
    switch (type) {
      case UIButtonType.raised:
        button = RaisedButton(
          elevation: elevation ?? 6,
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
          padding: this.padding,
          // color: color, // Note: Flat Dont need colors
        );
        break;
      case UIButtonType.outline:
        button = OutlineButton(
          onPressed: onPressed,
          child: current,
          color: color,
          borderSide: this.borderSide ?? BorderSide(color: color, width: 2.0),
          shape: this.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
          textColor: textColor,
          padding: this.padding,
        );
        break;
      default: // this will be a raised UI button
        button = RaisedButton(
          elevation: elevation ?? 6,
          onPressed: onPressed,
          child: current,
          color: color,
          textColor: textColor,
          padding: this.padding,
        );
    }

    /*button = ButtonTheme(
      minWidth: double.infinity,
      child: button,
    );*/

    var width = this.width ?? theme.buttonTheme.minWidth;

    if (fillContainer || alignment != null) {
      color = this.type == UIButtonType.raised && alignment != null
          ? color
          : Colors.transparent;
    }
    if (fillContainer) {
      width = double.infinity;
    }
    button = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width,
        maxWidth: this.width ?? double.infinity,
        minHeight: height ?? theme.buttonTheme.height,
        maxHeight: height ?? double.infinity,
      ),
      child: button,
    );

    if (alignment != null) {
      button = Container(
        alignment: this.alignment,
        // color: color,
        child: button,
      );
    }

    return button;
  }
}
