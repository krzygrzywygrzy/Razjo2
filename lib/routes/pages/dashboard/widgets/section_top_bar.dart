import 'package:flutter/material.dart';

import '../../../../core/const.dart';

class SectionTopBar extends StatelessWidget {
  const SectionTopBar({
    List<Widget> children,
    MainAxisAlignment alignment,
  })  : _children = children,
        _alignment = alignment;

  final List<Widget> _children;
  final MainAxisAlignment _alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(border: kBottomBorder),
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              _alignment == null ? MainAxisAlignment.start : _alignment,
          children: _children == null ? [] : _children,
        ),
      ),
    );
  }
}
