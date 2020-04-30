import 'package:flutter/material.dart';

class UIGridView extends StatefulWidget {

  final Widget Function(BuildContext, int) itemBuilder;

  UIGridView({@required this.itemBuilder});

  @override
  State<StatefulWidget> createState() => _UIGridView();
}

class _UIGridView extends State<UIGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemBuilder: (ctx, index) {
        return widget.itemBuilder(ctx, index);
      },
    );
  }
}
