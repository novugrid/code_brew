import 'package:code_brew/code_brew.dart';
import 'package:flutter/material.dart';

class UIDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T initialValue;
  final Widget icon;
  final Widget underline;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final Widget Function(BuildContext context, T item) builder;
  final Widget Function(BuildContext context, T item) selectedItemBuilder;

  UIDropdown(
    this.items, {
    @required this.initialValue,
    @required this.builder,
    this.selectedItemBuilder,
    this.icon,
    this.underline,
    this.padding,
    this.decoration,
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
      icon: widget.icon ?? Icon(Icons.arrow_drop_down),
      iconSize: 20,
      elevation: 16,
      isExpanded: true,
//      isDense: true,
      itemHeight: 56, // Todo: make this reflect from the global theme
      style: CodeBrewTheme.dropDownTheme,
      // dropdownColor: Colors.red, // Todo: Give ability to be adjusted manually
      underline: widget.underline ??
          Container(
//        height: 2,
//        color: Theme.of(context).accentColor,
              ),
      onChanged: (T newValue) {
        setState(() {
          dropdownValue = newValue;
        });
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

    Widget container = Container(
      padding: padding,
      decoration: widget.decoration ?? CodeBrewTheme.dropDownDecoration,
      child: dropDownButton,
    );

    return container;
  }
}
