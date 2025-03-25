import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/utils/utils.dart';
import 'network_status_event.dart';
import 'network_status_state.dart';

export 'network_status_event.dart';
export 'network_status_state.dart';

class NetworkStatusBloc extends Bloc<NetworkStatusEvent, NetworkStatusState> {
  final Connectivity connectivity;
  StreamSubscription? _connectivitySubscription;

  NetworkStatusBloc({Connectivity? connectivity})
    : connectivity = connectivity ?? Connectivity(),
      super(NetworkStatusInitial()) {
    on<CheckNetworkStatus>(_onCheckNetworkStatus);
    _connectivitySubscription = this.connectivity.onConnectivityChanged.listen((
      _,
    ) {
      add(CheckNetworkStatus());
    });
    add(CheckNetworkStatus());
  }

  Future<void> _onCheckNetworkStatus(
    CheckNetworkStatus event,
    Emitter<NetworkStatusState> emit,
  ) async {
    final hasInternet = await hasInternetConnection();
    emit(hasInternet ? NetworkStatusOnline() : NetworkStatusOffline());
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
