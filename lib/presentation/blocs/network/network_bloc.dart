import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_event.dart';

part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription? _subscription;

  NetworkBloc() : super(InitialNetworkState()) {
    on<ConnectedNetworkEvent>((event, emit) {
      emit(ConnectedNetworkState('Connected'));
    });

    on<NotConnectedNetworkEvent>((event, emit) {
      emit(ErrorNetworkState('Not connected'));
    });

    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi || event == ConnectivityResult.mobile) {
        add(ConnectedNetworkEvent());
      } else {
        add(NotConnectedNetworkEvent());
      }
    });
  }

  @override
  Future close(){
    _subscription?.cancel();
    return super.close();
  }
}
