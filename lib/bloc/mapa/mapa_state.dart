part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguriUbicacion;
  final LatLng? ubicacionCentral;
  //Polineas
  final Map<String, Polyline>? polylines;
  final Map<String, Marker>? markers;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = false,
      this.seguriUbicacion = false,
      this.ubicacionCentral,
      Map<String, Polyline>? polylines,
      Map<String, Marker>? markers})
      : polylines = polylines ?? {},
        markers = markers ?? {};

  //Polynines

  MapaState copyWiht(
          {bool? mapaListo,
          bool? dibujarRecorrido,
          bool? seguriUbicacion,
          LatLng? ubicacionCentral,
          Map<String, Polyline>? polylines,
          Map<String, Marker>? markers}) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
        seguriUbicacion: seguriUbicacion ?? this.seguriUbicacion,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
      );
}
