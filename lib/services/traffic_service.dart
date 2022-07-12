import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_avanzado_3mapa/helpers/debouncer.dart';
import 'package:flutter_avanzado_3mapa/models/reverseQueryResponse.dart';
import 'package:flutter_avanzado_3mapa/models/search_response.dart';
import 'package:flutter_avanzado_3mapa/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  //Singleton instance
  TrafficService._privateContructor();
  static final TrafficService _instance = TrafficService._privateContructor();
  factory TrafficService() {
    return _instance;
  }

  final debouncer =
      Debouncer<String>(duration: const Duration(milliseconds: 400));

  final StreamController<SearchResponse> _sugerenciasStreamController =
      StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream =>
      _sugerenciasStreamController.stream;

  final _dio = Dio();
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja2UxbmcwYXEwMTI4MnF1bDNpOXVtczZ1In0.WU-RLHl90X1vck6KXv1JdQ';
  Future getCoordInicioYFin(LatLng inicio, LatLng destino) async {
    print('INICIO:$inicio |FIN:$destino ');
    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '$_baseUrlDir/mapbox/driving/$coordString';

    final resp = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }

  Future<SearchResponse> getResultadosPorQuery(
      String busqueda, LatLng proximidad) async {
    print('Buscando!!!!!');

    final url = '$_baseUrlGeo/mapbox.places/$busqueda.json';

    try {
      final resp = await _dio.get(url, queryParameters: {
        'access_token': _apiKey,
        'autocomplete': 'true',
        'proximity': '${proximidad.longitude},${proximidad.latitude}',
        'language': 'es',
      });

      final searchResponse = searchResponseFromJson(resp.data);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await getResultadosPorQuery(value, proximidad);
      _sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(const Duration(milliseconds: 201))
        .then((_) => timer.cancel());
  }

  Future getCoordenadasInfo(LatLng destinoCoords) async {
    final url =
        '$_baseUrlGeo/mapbox.places/${destinoCoords.longitude},${destinoCoords.latitude}.json';

    final resp = await _dio.get(url, queryParameters: {
      'access_token': _apiKey,
      'language': 'es',
    });

    final data = ReverseQueryResponse.fromJson(resp.data);
    return data;
  }
}
