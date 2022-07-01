import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/pages/acceso_gps_page.dart';
import 'package:flutter_avanzado_3mapa/pages/mapa_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helpers/helpers.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context,
            navegarMapaFadeIn(
              context,
              const MapaPage(),
            ));
      }

      //print('========$state');
      super.didChangeAppLifecycleState(state);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }
}

Future checkGpsYLocation(context) async {

await Future.delayed(const Duration(seconds:3));

  //TODO PERMISO GPS
  final permisoGPS = await Permission.location.isGranted;
  final gpsActivo = await Geolocator.isLocationServiceEnabled();
  //TODO GPS ESTA ACTIVO

  if (permisoGPS && gpsActivo) {
    Navigator.pushReplacement(
        context,
        navegarMapaFadeIn(
          context,
          const MapaPage(),
        ));
    return '';
  } else if (permisoGPS) {
    Navigator.pushReplacement(
        context,
        navegarMapaFadeIn(
          context,
          const AccesoGpsPage(),
        ));
    return 'Es necesario el permiso de GPS';
  } else {
    return 'Active el GPS';
  }

  // print('LODIGN PAGE');
}
