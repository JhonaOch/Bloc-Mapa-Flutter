import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/pages/acceso_gps_page.dart';
import 'package:flutter_avanzado_3mapa/pages/loading_page.dart';
import 'package:flutter_avanzado_3mapa/pages/mapa_page.dart';
import 'package:flutter_avanzado_3mapa/pages/test_marker_page.dart';

final Map<String, WidgetBuilder> appRouter = {
  'gps': (BuildContext context) => const AccesoGpsPage(),
  'loading': (BuildContext context) => const LoadingPage(),
  'mapa': (BuildContext context) => const MapaPage(),
  'marker': (BuildContext context) => const TestMarketPage(),
};
