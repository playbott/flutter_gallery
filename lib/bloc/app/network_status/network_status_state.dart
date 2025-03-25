import 'package:equatable/equatable.dart';

abstract class NetworkStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class NetworkStatusInitial extends NetworkStatusState {}

class NetworkStatusOnline extends NetworkStatusState {}

class NetworkStatusOffline extends NetworkStatusState {}
