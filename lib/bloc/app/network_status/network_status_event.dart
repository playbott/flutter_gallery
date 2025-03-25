import 'package:equatable/equatable.dart';

abstract class NetworkStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckNetworkStatus extends NetworkStatusEvent {}