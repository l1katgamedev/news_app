part of 'network_bloc.dart';

abstract class NetworkEvent {}

class ConnectedNetworkEvent extends NetworkEvent {}

class NotConnectedNetworkEvent extends NetworkEvent {}
