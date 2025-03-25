import 'package:flutter/widgets.dart';
import 'package:photo_gallery/bloc/bloc.dart';
import 'package:toastification/toastification.dart';

import '../../core/enums/enums.dart';

class ToastWrapper extends StatefulWidget {
  const ToastWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<ToastWrapper> createState() => _ToastWrapperState();
}

class _ToastWrapperState extends State<ToastWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalMessageBloc, GlobalMessageState>(
      bloc: globalMessageBloc,
      listener: (blocContext, state) async {
        if (state is GlobalMessageStateMessage) {
          ToastificationType type = ToastificationType.info;
          switch (state.type) {
            case NotificationType.info:
              type = ToastificationType.info;
              break;
            case NotificationType.warning:
              type = ToastificationType.warning;
              break;
            case NotificationType.success:
              type = ToastificationType.success;
              break;
            case NotificationType.error:
              type = ToastificationType.error;
              break;
          }
          toastification.show(
            context: context,
            type: type,
            title: Text(state.title),
            description: Text(state.message),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      },
      child: widget.child,
    );
  }
}
