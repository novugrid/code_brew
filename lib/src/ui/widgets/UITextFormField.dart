import 'package:code_brew/src/ui/UICodeBrew.dart';
import 'package:code_brew/src/ui/theme/CodeBrewTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UITextFormField extends StatefulWidget {
  final String hint;
  final String label;
  final double labelSpacing;
  final UIAlignment labelAlignment;
  final Border border;
  final EdgeInsetsGeometry padding;
  final TextStyle labelStyle;
  final Color hintColor;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final int maxLines;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;

  UITextFormField({
    this.controller,
    this.hint = "",
    this.label,
    this.labelSpacing = 5.0,
    this.labelAlignment = UIAlignment.top,
    this.border,
    this.padding,
    this.labelStyle,
    this.hintColor,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.inputFormatters,
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
      controller: widget.controller,
      style: CodeBrewTheme.textFieldStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        // hintStyle: TextStyle(color: hintColor),
        border: InputBorder
            .none, // TODO(Lekan): Add improvements to this in version 1.2
        contentPadding: EdgeInsets.zero,

        // isDense: true,

      ),
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters ?? [],
      textInputAction: TextInputAction.done,
    );

    Widget container;
    if (widget.label != null) {
      TextStyle labelStyle = widget.labelStyle;
      if (labelStyle == null) {
        labelStyle = theme.inputDecorationTheme.labelStyle;
      }

      Widget label = Container(
        margin: EdgeInsets.only(bottom: widget.labelSpacing),
        child: Text(
          widget.label,
          style: labelStyle,
        ),
      );

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
