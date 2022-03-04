import 'package:flutter/material.dart';

class ColumnSpacing extends StatelessWidget {
  final List<Widget> items;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const ColumnSpacing(
      {Key? key,
      required this.items,
      this.spacing = 8.0,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisSize = MainAxisSize.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: items
          .map((e) => Column(
                children: [
                  e,
                  SizedBox(
                    height: spacing,
                  )
                ],
              ))
          .toList(),
    );
  }
}
