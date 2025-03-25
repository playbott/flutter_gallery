import 'package:photo_gallery/core/enums/notification_type.dart';

class GlobalMessageEventShow extends GlobalMessageEvent {
  GlobalMessageEventShow({
    required this.title,
    required this.message,
    this.retryAction,
    required this.type,
  });

  final String title;
  final String message;
  final void Function()? retryAction;
  final NotificationType type;
}

class GlobalMessageEvent {}
