 part of 'internet_cubit.dart';




@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {

}

class InternetConnected extends InternetState {
  late final ConnectionType connectionType;
  InternetConnected({required this.connectionType});

}

class InternetDisconnected extends InternetState {

}
