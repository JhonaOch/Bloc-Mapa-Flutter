import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_avanzado_3mapa/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_avanzado_3mapa/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_avanzado_3mapa/router/routes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class  MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc()),
         BlocProvider(create: (_) => MapaBloc()),
         BlocProvider(create: (_) => BusquedaBloc()),
      
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes:appRouter
      ),
    );
     
  }
}