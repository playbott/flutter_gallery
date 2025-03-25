import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_event.dart';
import 'message_state.dart';

export 'message_event.dart';
export 'message_state.dart';

GlobalMessageBloc globalMessageBloc = GlobalMessageBloc();

class GlobalMessageBloc extends Bloc<GlobalMessageEvent, GlobalMessageState> {
  GlobalMessageBloc() : super(GlobalMessageStateNoMessage()) {
    on<GlobalMessageEvent>((event, emit) async {
      if (event is GlobalMessageEventShow) {
        emit(
          GlobalMessageStateMessage(
            title: event.title,
            message: event.message,
            retryAction: () {},
            type: event.type,
          ),
        );
      }
    }, transformer: sequential());
  }
}
