import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/models/search_response.dart';
import 'package:flutter_avanzado_3mapa/models/search_result.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  // ignore: overridden_fields
  final String? searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng? proximidad;
  final List<SearchResult>? historial;

  SearchDestination(this.proximidad, this.historial)
      : searchFieldLabel = 'Buscar...',
        _trafficService = TrafficService();

  @override
  List<Widget>? buildActions(Object context) {
    return [
      IconButton(
          onPressed: () {
            //DATOS INGRESADOS
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //TODO Boton izquierdo
    return IconButton(
        onPressed: () {
          close(context, SearchResult(cancelo: true));
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // ignore: prefer_is_empty
    if (query.length == 0) {
      return ListView(children: [
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text("Colocar ubicacion manualmente."),
          onTap: () {
            close(context, SearchResult(cancelo: false, manual: true));
          },
        ),
        ...historial!
            .map((result) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(result.nombreDestino!),
                subtitle: Text(result.descripcion!),
                onTap: () {
                  close(context, result);
                }))
            .toList()
      ]);
    }

    return _construirResultadosSugerencias();
  }

  Widget _construirResultadosSugerencias() {
    // ignore: unrelated_type_equality_checks
    if (query == 0) {
      return Container();
    }
    _trafficService.getSugerenciasPorQuery(query.trim(), proximidad!);
    return StreamBuilder(
      stream: _trafficService.sugerenciasStream,
      builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final lugares = snapshot.data!.features;
        // ignore: prefer_is_empty
        if (lugares!.length == 0) {
          return ListTile(
            title: Text('No hay resultados con $query'),
          );
        }
        return ListView.separated(
            itemCount: lugares.length,
            separatorBuilder: (_, i) => const Divider(),
            itemBuilder: (_, i) {
              final lugar = lugares[i];
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(lugar.textEs),
                subtitle: Text(lugar.placeNameEs),
                onTap: () {
                  close(
                      context,
                      SearchResult(
                          cancelo: false,
                          manual: false,
                          position: LatLng(lugar.center[1], lugar.center[0]),
                          nombreDestino: lugar.textEs,
                          descripcion: lugar.placeNameEs));
                },
              );
            });
      },
    );
  }
}
