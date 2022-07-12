// ignore_for_file: prefer_const_constructors, deprecated_member_use

part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(builder: (context, state) {
      if (state.seleccionManual) {
        return _BuildMarcadorManual();
      } else {
        return Container();
      }
    });
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
            top: 100,
            left: 20,
            child: FadeInLeft(
              child: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor: Colors.black12,
                  child: IconButton(
                    onPressed: () {
                      context
                          .bloc<BusquedaBloc>()
                          .add(OnDesactivarMarcadorManual());
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: const Color.fromARGB(221, 65, 2, 80),
                    ),
                  )),
            )),
        Center(
          child: Transform.translate(
              offset: Offset(0, -30),
              child: BounceInDown(
                  child:
                      Icon(Icons.location_on, size: 50, color: Colors.purple))),
        ),

        ///TODO Boton de confirmar destino
        ///
        Positioned(
            bottom: 70,
            left: 40,
            child: FadeIn(
              child: MaterialButton(
                onPressed: () {
                  calcularDestino(context);
                },
                minWidth: width - 100,
                // ignore: sort_child_properties_last
                child: Text(
                  'Confirmar destino',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purple,
                shape: StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
              ),
            ))
      ],
    );
  }

  Future<void> calcularDestino(BuildContext context) async {
    calculandoAlerta(context);
    final trafficService = TrafficService();

    final mapaBloc = context.bloc<MapaBloc>();
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    final destino = mapaBloc.state.ubicacionCentral;

    //Obtener la informacion del destino del
    final reverseQueryResponse =
        await trafficService.getCoordenadasInfo(destino!);

    final trafficResponse =
        await trafficService.getCoordInicioYFin(inicio!, destino);

    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final geometry = trafficResponse.routes[0].geometry;
    final nombreDestino = reverseQueryResponse.features![0].text;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    final List<LatLng> rutaCoords =
        points.map((e) => LatLng(e[0], e[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoords, distancia, duracion, nombreDestino!));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    // ignore: use_build_context_synchronously
    context.bloc<BusquedaBloc>().add(OnDesactivarMarcadorManual());
  }
}
