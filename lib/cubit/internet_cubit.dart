import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import '../constants/enums.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
    final Connectivity connectivity; //instance of connectivityplus
   late StreamSubscription connectivityStreamSubscription; //StreamSubscription used for communicating with two blocs
  InternetCubit({required this.connectivity}) : super(InternetLoading()){ //Starts with the Loading state of internet
    //.listen((connectivityResult) gives a value and we check with wifi or mobile
   monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult>  monitorInternetConnection() {
      //.listen((connectivityResult) gives a value and we check with wifi or mobile
    return connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) { //Listens to connectivityChanged
      if(connectivityResult == ConnectivityResult.wifi){
        emitInternetConnected(ConnectionType.Wifi); //Enum value
      }
      else if(connectivityResult == ConnectivityResult.mobile){
        emitInternetConnected(ConnectionType.Mobile);
      }
      else if(connectivityResult == ConnectivityResult.none){
        emitInternetDisconnected();
      }
    
    });

  }
//Takes the enum type and emits it to the internet state
  void emitInternetConnected(ConnectionType _connectionType) => emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

//Close the subscription for avoiding data leak
@override
  Future<void> close(){
  connectivityStreamSubscription.cancel();
  return super.close();
}




}
