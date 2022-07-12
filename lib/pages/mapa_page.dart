import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_avanzado_3mapa/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_avanzado_3mapa/widget/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) {
            return crearMapa(state);
          },
        ),

        //TODO: TOGGLE MANUAL
        const Positioned(top: 10, child: SearchBar()),

        const MarcadorManual()
      ]),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [BtnUbicacion(), BtnSeguirUbicacion(), BtnMiRuta()]),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion)
      // ignore: curly_braces_in_flow_control_structures
      return const Center(child: Text('Ubicando ....'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion!));

    final camaraPosition = CameraPosition(target: state.ubicacion!, zoom: 15);

    return BlocBuilder<MapaBloc, MapaState>(builder: (context, _) {
      return GoogleMap(
        initialCameraPosition: camaraPosition,
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapaBloc.initMapa(controller);
        },
        polylines: mapaBloc.state.polylines!.values.toSet(),
        markers: mapaBloc.state.markers!.values.toSet(),
        onCameraMove: (camaraPosition) {
          mapaBloc.add(OnMovioMapa(camaraPosition.target));
        },
        // onCameraIdle: (){

        // },
      );
    });
  }
}
