import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/core_dimens.dart';

import 'expanded_scroll_view.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? background;
  final Widget? footer;
  final bool allowBack;
  final VoidCallback? onScrollEnd;

  const BaseScaffold({
    required this.title,
    required this.children,
    this.actions,
    this.background,
    this.footer,
    this.allowBack = true,
    this.onScrollEnd
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BaseScaffoldCubit(),
      child: _Content(
        title: title,
        children: children,
        actions: actions,
        background: background,
        footer: footer,
        allowBack: allowBack,
        onScrollEnd: onScrollEnd
      ),
    );
  }
}

class _Content extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? background;
  final Widget? footer;
  final bool? allowBack;
  final VoidCallback? onScrollEnd;

  const _Content({
    required this.title,
    required this.children,
    this.actions,
    this.background,
    this.footer,
    this.allowBack = true,
    this.onScrollEnd
  });

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      context
          .read<BaseScaffoldCubit>()
          .onOffsetChanged(_scrollController.offset);
      if (_scrollController.position.maxScrollExtent == _scrollController.offset && widget.onScrollEnd != null) {
        print('CABOU A LISTA AI');
        widget.onScrollEnd!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('rodei');
        

        //() async => false
        if(widget.allowBack != true)
          return false;
        
        return true;
      },
      child: Stack(
        children: [
          Container(color: Theme.of(context).scaffoldBackgroundColor),
          if (widget.background != null) widget.background!,
          Scaffold(
            backgroundColor: Colors.transparent,
            
            appBar: AppBar(
              automaticallyImplyLeading: widget.allowBack!,
              actions: widget.actions,
              title: BlocBuilder<BaseScaffoldCubit, BaseScaffoldState>(
                buildWhen: (previous, current) =>
                    previous.topTitleOpacity != current.topTitleOpacity,
                builder: (context, state) {
                  return AnimatedOpacity(
                    opacity: state.topTitleOpacity,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.title,
                      style: Theme.of(context)
                          .appBarTheme
                          .toolbarTextStyle
                          ?.copyWith(fontSize: 20.0),
                    ),
                  );
                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ExpandedScrollView(
                    scrollController: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Title(title: widget.title),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kMarginDefault,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: widget.children,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.footer != null) widget.footer!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: kMarginDefault),
          Expanded(
            child: BlocBuilder<BaseScaffoldCubit, BaseScaffoldState>(
              buildWhen: (previous, current) =>
                  previous.bottomTitleOpacity != current.bottomTitleOpacity,
              builder: (context, state) {
                return Opacity(
                  opacity: state.bottomTitleOpacity,
                  child: Text(
                    title,
                    style: Theme.of(context).appBarTheme.toolbarTextStyle,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: kMarginDefault),
        ],
      ),
    );
  }
}


// ##############################################################
// ##############################################################
// ##############################################################

class BaseScaffoldState extends Equatable {
  final double offset;

  const BaseScaffoldState({required this.offset});

  double get topTitleOpacity => offset >= kToolbarHeight * 0.7 ? 1.0 : 0.0;

  double get bottomTitleOpacity =>
      1 - (max(0, min(offset, kToolbarHeight)) / kToolbarHeight);

  @override
  List<Object> get props => [offset];
}


class BaseScaffoldCubit extends Cubit<BaseScaffoldState> {
  BaseScaffoldCubit() : super(const BaseScaffoldState(offset: 0.0));

  void onOffsetChanged(double offset) {
    emit(BaseScaffoldState(offset: offset));
  }
}
