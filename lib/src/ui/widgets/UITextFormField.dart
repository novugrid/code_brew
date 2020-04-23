import 'package:code_brew/src/ui/UICodeBrew.dart';
import 'package:code_brew/src/ui/theme/CodeBrewTheme.dart';
import 'package:flutter/material.dart';


class UITextFormField extends StatefulWidget {
  final String hint;
  final String label;
  final UIAlignment labelAlignment;
  final Border border;
  final EdgeInsetsGeometry padding;
  final Color labelColor;
  final Color hintColor;


  UITextFormField({this.hint = "",
    this.label,
    this.labelAlignment = UIAlignment.top,
    this.border,
    this.padding,
    this.labelColor,
    this.hintColor

  });

  @override
  State<StatefulWidget> createState() => _UITextFormField();
}

class _UITextFormField extends State<UITextFormField> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Color hintColor = widget.hintColor;
    if (hintColor == null) {
      hintColor = Colors.white24;
    }

    Widget current = TextFormField(
      style: CodeBrewTheme.textFieldStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: hintColor),
        border: InputBorder
            .none, // TODO(Lekan): Add improvements to this in version 1.2
        contentPadding: EdgeInsets.zero,
      ),
    );
    Widget container;
    if (widget.label != null) {
      Color labelColor = widget.labelColor;
      if (labelColor == null) {
        labelColor = Colors.white;
      }
      Widget label = Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            widget.label, style: TextStyle(color: labelColor),));
      switch (widget.labelAlignment) {
        case UIAlignment.left:
          container = Row(
            children: <Widget>[label, current],
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
}
