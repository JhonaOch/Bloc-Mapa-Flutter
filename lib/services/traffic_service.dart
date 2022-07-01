

import 'package:dio/dio.dart';
import 'package:flutter_avanzado_3mapa/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService{

  //Singleton instance
  TrafficService._privateContructor();
  static final TrafficService _instance =  TrafficService._privateContructor();
  factory TrafficService(){
    return _instance;
  }

  final _dio = Dio();
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey  = 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja2UxbmcwYXEwMTI4MnF1bDNpOXVtczZ1In0.WU-RLHl90X1vck6KXv1JdQ';


  Future getCoordInicioYFin(LatLng inicio,LatLng destino) async{


    print('INICIO:${inicio} |FIN:${destino} ');
    final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
    final url = '${ this._baseUrlDir }/mapbox/driving/$coordString';

    final resp = await _dio.get(url,
    queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',

    }
    );

   final data = DrivingResponse.fromJson(resp.data);

    return data;


  }



}