import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_avanzado_3mapa/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_avanzado_3mapa/services/traffic_service.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_avanzado_3mapa/search/search_destination.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe, library_prefixes
import 'package:polyline/polyline.dart 'as Poly;

import '../bloc/mapa/mapa_bloc.dart';
import '../helpers/helpers.dart';
import '../models/search_result.dart';

part 'btn_ubicacion.dart';
part 'btn_mi_ruta.dart';
part 'btn_seguir_ubicacion.dart';
part 'searchbar.dart';
part 'marcador_manual.dart';