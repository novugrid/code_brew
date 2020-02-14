import 'package:flutter/material.dart';

class UIDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T initialValue;
  final Widget Function(BuildContext context, T item) builder;
  final Widget Function(BuildContext context, T item) selectedItemBuilder;

  UIDropdown(this.items,
      {@required this.initialValue,
      @required this.builder,
      this.selectedItemBuilder})
      : assert(items != null);

  @override
  _UIDropdownState createState() => _UIDropdownState<T>();
}

class _UIDropdownState<T> extends State<UIDropdown<T>> {
  T dropdownValue;

  // List<T> items;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
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
          child: widget.builder(context, value),
        );
      }).toList(),
    );
  }
}
