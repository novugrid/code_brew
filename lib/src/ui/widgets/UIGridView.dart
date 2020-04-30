import 'package:flutter/material.dart';

class UIGridView extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final double height;
  final double aspectRatio;
  final double spacing;

  UIGridView({
    @required this.itemBuilder,
    this.itemCount,
    this.height,
    this.aspectRatio = 1,
    this.spacing = 0,
  });

  @override
  State<StatefulWidget> createState() => _UIGridView();
}

class _UIGridView extends State<UIGridView> {
  @override
  Widget build(BuildContext context) {
    Widget current = GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: widget.aspectRatio, // 0.7,
        mainAxisSpacing: widget.spacing,
      ),
      itemBuilder: (ctx, index) {
        return widget.itemBuilder(ctx, index);
      },
    );

    if (widget.height != null) {
      current = Container(
        height: widget.height,
        child: current,
      );
    }

    return current;
  }
}
