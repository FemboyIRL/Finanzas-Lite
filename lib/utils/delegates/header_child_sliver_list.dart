import 'package:flutter/material.dart';

class HeaderChildSliverList extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minSize;
  final double maxSize;

  HeaderChildSliverList({
    required this.child,
    this.minSize = 70,
    this.maxSize = 70,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxSize;

  @override
  double get minExtent => minSize;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
