import 'dart:convert';

// ignore: depend_on_referenced_packages, import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/themes/uber_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';

import '../../helpers/helpers.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  ///Controlador del mapa
  GoogleMapController? _mapController;

  //Polineas

  Polyline _miRuta = const Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.purple);

  Polyline _miDestino = const Polyline(
      polylineId: PolylineId('mi_ruta_destino'),
      width: 4,
      color: Colors.purple);

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

    //Icono InicioDest

    final iconInicio = await getMarkerInicioIcon(event.duracion.toInt());
    // final iconFinal =await getMarkerFinalIcon(event.duracion.toInt());
    final destinoIcon =
        await getMarkerDestinoIcon(event.nombreDestino, event.distancia);

//Marcadores \\ /
    final markerInicio = Marker(
        anchor: const Offset(0.1, 0.95),
        markerId: const MarkerId('inicio'),
        position: event.rutaCoordenas[0],
        icon: iconInicio,
        infoWindow: InfoWindow(
          title: 'Mi ubicacion',
          snippet:
              'Duracion recorrido: ${(event.duracion / 60).floor()} minutos.',
          // anchor: Offset(0.5,0),
          // onTap: (){
          //   print('Infor Windows tap');
          // }
        ));

    double kilometros = event.distancia / 1000;
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;

    final markerFinal = Marker(
        anchor: const Offset(0.1, 0.95),
        markerId: const MarkerId('final'),
        position: event.rutaCoordenas[event.rutaCoordenas.length - 1],
        icon: destinoIcon,
        infoWindow: InfoWindow(
          title: 'Destino',
          snippet: 'Distancia: $kilometros Km.',
          // anchor: Offset(0.5,0),
          // onTap: (){
          //   print('Infor Windows tap');
          // }
        ));

    final newMarkers = {...state.markers!};

    newMarkers['inicio'] = markerInicio;
    newMarkers['final'] = markerFinal;

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
// _mapController!.showMarkerInfoWindow(MarkerId('inicio'));
      _mapController!.showMarkerInfoWindow(const MarkerId('final'));
    });

    yield state.copyWiht(polylines: currentPolylines, markers: newMarkers);
  }
}
