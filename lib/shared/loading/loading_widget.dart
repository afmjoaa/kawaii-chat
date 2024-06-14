import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawaii_chat/shared/widgets/flr_loading_widget.dart';
import 'package:kawaii_chat/shared/widgets/message_widget.dart';
import 'package:kawaii_chat/shared/widgets/overlay_widget.dart';

import 'loading_cubit.dart';
import 'loading_state.dart';

class LoadingWidget extends StatefulWidget {
  final LoadingCubit loadingCubit;
  final Widget child;

  const LoadingWidget(
      {Key? key, required this.loadingCubit, required this.child})
      : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      bloc: widget.loadingCubit,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: widget.child,
              ),
              Visibility(
                visible: state is LoadingStartedState ? true : false,
                child: const OverlayWidget()
              ),
              Visibility(
                visible: state is LoadingStartedState ? true : false,
                child: const FlrLoadingWidget(),
              ),
              Visibility(
                visible: state is LoadingFailedState,
                child: MessageWidget(
                  loadingCubit: widget.loadingCubit,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
