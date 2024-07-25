import 'package:flutter/material.dart';

class ExpandedScrollView extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final Widget? footer;
  final ScrollController? scrollController;

  const ExpandedScrollView({
    Key? key,
    this.child = const SizedBox.shrink(),
    this.header,
    this.footer,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        controller: scrollController,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header ?? Container(),
                Expanded(child: child),
                footer ?? Container(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
