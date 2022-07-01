import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/themes/uber_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  ///Controlador del mapa
  GoogleMapController? _mapController;

  //Polineas

  Polyline _miRuta = const Polyline(
      polylineId: PolylineId('mi_ruta'), width: 3, color: Colors.transparent);

  Polyline _miDestino = const Polyline(
      polylineId: PolylineId('mi_ruta_destino'),
      width: 3,
      color: Colors.black);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      _mapController = controller;

      //TODOD Cambiar el estilo del mapa
      _mapController!.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if (event is OnMapaListo) {
      //print("MAPA LIST");
      yield state.copyWiht(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      yield* _onNuevaUbicacion(event);
    } else if (event is OnMarcaRecorrido) {
      yield* _onMarcaRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      yield* _onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      yield state.copyWiht(ubicacionCentral: event.centroMapa);
    } else if (event is OnCrearRutaInicioDestino) {
      yield* _onCrearRutaInicioDestino(event);
    }
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    if (state.seguriUbicacion) {
      moverCamara(event.ubicacion);
    }

    final List<LatLng> points = [..._miRuta.points, event.ubicacion];
    _miRuta = _miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines!['mi_ruta'] = _miRuta;

    yield state.copyWiht(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcaRecorrido(OnMarcaRecorrido event) async* {
    if (!state.dibujarRecorrido) {
      _miRuta = _miRuta.copyWith(colorParam: Colors.black87);
    } else {
      _miRuta = _miRuta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines!['mi_ruta'] = _miRuta;

    yield state.copyWiht(
        dibujarRecorrido: !state.dibujarRecorrido, polylines: currentPolylines);
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    if (!state.seguriUbicacion) {
      moverCamara(_miRuta.points[_miRuta.points.length - 1]);
    }

    yield state.copyWiht(seguriUbicacion: !state.seguriUbicacion);
  }

  Stream<MapaState> _onCrearRutaInicioDestino(
      OnCrearRutaInicioDestino event) async* {
    _miDestino = _miDestino.copyWith(pointsParam: event.rutaCoordenas);

    final currentPolylines = state.polylines;
    currentPolylines!['mi_ruta_destino'] = _miDestino;

    yield state.copyWiht(polylines: currentPolylines
        //TODO MArcadoress

        );
  }
}
