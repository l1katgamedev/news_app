part of 'network_bloc.dart';

abstract class NetworkState {}

class InitialNetworkState extends NetworkState {}

class ConnectedNetworkState extends NetworkState {
  final String message;

  ConnectedNetworkState(this.message);
}

class ErrorNetworkState extends NetworkState {
  final String message;

  ErrorNetworkState(this.message);
}
