part of 'mapa_bloc.dart';

@immutable
class MapaState {

  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguriUbicacion;
  final LatLng? ubicacionCentral;
   final Map<String,Polyline>? polylines;

   MapaState({
    this.mapaListo=false,
    this.dibujarRecorrido=false,
    this.seguriUbicacion=false,
    this.ubicacionCentral,
    Map<String,Polyline>? polylines
    }):polylines =polylines?? {};

    //Polynines

   

    MapaState copyWiht({
      bool? mapaListo,
       bool? dibujarRecorrido,
       bool? seguriUbicacion,
       LatLng? ubicacionCentral,
       Map<String,Polyline>? polylines
   
    })=>MapaState(
      mapaListo:mapaListo?? this.mapaListo,
      ubicacionCentral: ubicacionCentral?? this.ubicacionCentral,
      seguriUbicacion: seguriUbicacion?? this.seguriUbicacion,
      polylines: polylines?? this.polylines,
      dibujarRecorrido: dibujarRecorrido?? this.dibujarRecorrido,


    );
  
}
