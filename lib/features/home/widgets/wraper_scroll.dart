// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WrapperScroll extends StatelessWidget {
  const WrapperScroll({
    super.key,
    required this.children,
    required this.scrollController,
  });
  final List<ScrollWidget> children;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        ...children.map((scrollWidget) {
          if (scrollWidget.isScrollable) {
            return scrollWidget.child;
          } else {
            return SliverToBoxAdapter(child: scrollWidget.child);
          }
        }),
      ],
    );
  }
}

class ScrollWidget {
  ScrollWidget({
    this.isScrollable = false,
    required this.child,
  });
  bool isScrollable;
  Widget child;
}

extension ConvertScrollwidget on Widget {
  ScrollWidget get convertScrollWidget => ScrollWidget(child: this);
}

extension Scrollable on ScrollWidget {
  ScrollWidget get scrollable => ScrollWidget(
        isScrollable: true,
        child: child,
      );
}
