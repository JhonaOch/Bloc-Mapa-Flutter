import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  const AccesoGpsPage({Key? key}) : super(key: key);

  @override
  State<AccesoGpsPage> createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
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
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    } else if (state == AppLifecycleState.inactive) {
      // print('inactive');
    } else if (state == AppLifecycleState.paused) {
      // print('paused');
    } else if (state == AppLifecycleState.detached) {
      // print('detached');
    }

    //print('========$state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Es necesario el GPS para continuar'),
          ),
          MaterialButton(
              // ignore: sort_child_properties_last
              child: const Text(
                'Solicitar acceso ',
                style: TextStyle(color: Colors.white),
              ),
              color: const Color.fromARGB(255, 75, 2, 96),
              shape: const StadiumBorder(),
              elevation: 1,
              onPressed: () async {
                //TODO VERIFICAR PERMISO

                final status = await Permission.location.request();

                accesoGPS(status);
              })
        ],
      ),
    );
  }

  void accesoGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        // TODO: OTORGO EL Permission
        Navigator.pushReplacementNamed(context, 'mapa');

        break;

      case PermissionStatus.limited:
        // TODO: Handle this case.
        break;

      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.denied:
        openAppSettings();
    }
  }
}
