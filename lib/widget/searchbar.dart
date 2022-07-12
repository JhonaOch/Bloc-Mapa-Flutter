// ignore_for_file: use_build_context_synchronously

part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(builder: (context, event) {
      if (event.seleccionManual) {
        return Container();
      } else {
        return FadeInDown(child: buildSearchbar(context));
      }
    });
  }

  Widget buildSearchbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          final historial = context.bloc<BusquedaBloc>().state.historial;
          final proximidad = context.bloc<MiUbicacionBloc>().state.ubicacion;
          final result =
              await showSearch(context: context, delegate: SearchDestination(proximidad!,historial));
          retornoBusqueda(context, result!);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
              child: const Text(
                'Donde quieres ir?',
                style: TextStyle(color: Colors.black87),
              ),
            )),
      ),
    );
  }

  Future<void> retornoBusqueda(BuildContext context, SearchResult result)async {
    final busquedaBloc = context.bloc<BusquedaBloc>();
    if (result.cancelo) return;
    if (result.manual!) {
      busquedaBloc.add(OnActivarMarcadorManual());
      return;
    }

    //Calcular la ruta en base al valor:Result

    calculandoAlerta(context);

    final trafficService  = TrafficService();
    // ignore: deprecated_member_use
    final mapaBloc = context.bloc<MapaBloc>();

    // ignore: deprecated_member_use
    final inicio= context.bloc<MiUbicacionBloc>().state.ubicacion;
    final destino= result.position;

    

    final drivingTraffit = await trafficService.getCoordInicioYFin(inicio!, destino!);

    final geometry = drivingTraffit.routes[0].geometry;
    final duracion = drivingTraffit.routes[0].duracion;
    final distancia = drivingTraffit.routes[0].distancia;
     final nombreDestino =result.nombreDestino;

    final points = Poly.Polyline.Decode(encodedString: geometry,precision:6);
    final List<LatLng> rutaCoordenas = points.decodedCoords.map(
      (point) => LatLng(point[0], point[1])
    ).toList();

  
    mapaBloc.add(OnCrearRutaInicioDestino(rutaCoordenas, distancia, duracion,nombreDestino!));

    Navigator.of(context).pop();

    //Agregar al historial
    busquedaBloc.add(OnAgregarHistorial(result));

  }
}
