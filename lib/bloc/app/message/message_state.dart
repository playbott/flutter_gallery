import 'package:photo_gallery/core/enums/enums.dart';

class GlobalMessageStateNoMessage extends GlobalMessageState {}

class GlobalMessageStateMessage extends GlobalMessageState {
  GlobalMessageStateMessage({
    required this.title,
    required this.message,
    required this.retryAction,
    required this.type,
  });

  final String title;
  final String message;
  final void Function() retryAction;
  final NotificationType type;
}

class GlobalMessageState {}
