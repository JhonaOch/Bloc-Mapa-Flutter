import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(const MiUbicacionState());

   late StreamSubscription<Position> _positionSubscription;

  void iniciarSeguimiento() {
   const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 5,
);


    _positionSubscription= Geolocator.getPositionStream(
     locationSettings: locationSettings
    ).listen((Position position) {
      final nuevaUbicacion = LatLng(position.latitude, position.longitude);

     // print(nuevaUbicacion);
     
      add(OnUbicacionCambio(nuevaUbicacion));


    });
  }

  void cancelarSeguimiento() {
    _positionSubscription.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState( MiUbicacionEvent event ) async* {
    
    if ( event is OnUbicacionCambio ) {
     // print(event);
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );
    }
  }
}
