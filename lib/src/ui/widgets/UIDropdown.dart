import 'package:code_brew/code_brew.dart';
import 'package:flutter/material.dart';

/// [label] this can be a String or a Widget
class UIDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T initialValue;
  final Widget hint;
  final Widget icon;
  final dynamic label;
  final double labelSpacing;
  final Widget underline;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final bool isDense;
  final Widget Function(BuildContext context, T item) builder;
  final Widget Function(BuildContext context, T item) selectedItemBuilder;
  final ValueChanged<T> onChanged;

  UIDropdown(
    this.items, {
    @required this.initialValue,
    @required this.builder,
    this.selectedItemBuilder,
    this.hint,
    this.icon,
    this.label,
    this.labelSpacing = 5.0,
    this.underline,
    this.padding,
    this.decoration,
    this.isDense = false,
    this.onChanged,
  }) : assert(items != null);

  @override
  _UIDropdownState createState() => _UIDropdownState<T>();
}

class _UIDropdownState<T> extends State<UIDropdown<T>> {
  T dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //  get padding
    EdgeInsetsGeometry padding = widget.padding;
    if (widget.padding == null) {
      if (CodeBrewTheme.dropDownPadding != null) {
        padding = CodeBrewTheme.dropDownPadding;
      } else
        padding = theme.inputDecorationTheme.contentPadding;
    }

    // The Dropdown
    Widget dropDownButton = DropdownButton<T>(
      value: dropdownValue,
      hint: widget.hint,
      icon: widget.icon ?? Icon(Icons.arrow_drop_down),
      iconSize: 20,
      elevation: 16,
      isExpanded: true,
      isDense: (widget.label == null) ? widget.isDense : true,
      // Note: Once a labe
      itemHeight: kMinInteractiveDimension,
      // Todo: make this reflect from the global theme
      style: CodeBrewTheme.dropDownTheme,
      // dropdownColor: Colors.red, // Todo: Give ability to be adjusted manually
      underline: widget.underline ??
          Container(
//        height: 2,
//        color: Theme.of(context).accentColor,
              ),
//      onChanged: this.widget.onChanged,
      onChanged: (T newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        this.widget.onChanged(newValue);
      },
      // This should be optional
      selectedItemBuilder: widget.selectedItemBuilder == null
          ? null
          : (BuildContext context) {
              return widget.items.map(
                (item) {
                  return widget.selectedItemBuilder(context, item);
                },
              ).toList();
            },

      items: widget.items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Container(
            // margin: padding,
            child: widget.builder(context, value),
          ),
        );
      }).toList(),
    );

    Widget label;
    if (widget.label != null) {
      if (widget.label is Widget) {
        label = widget.label;
      } else if (widget.label is String) {
        label = Container(
          margin: EdgeInsets.only(bottom: widget.labelSpacing),
          child: Text(
            "${widget.label}",
            style: theme.inputDecorationTheme.labelStyle,
          ),
        );
      } else {
        throw ("Unsupported label type, label must be a widget or a String");
      }
    }

    Widget container = Container(
      padding: padding,
      decoration: widget.decoration ?? CodeBrewTheme.dropDownDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) label,
          dropDownButton,
        ],
      ),
    );

    return container;
  }
}
