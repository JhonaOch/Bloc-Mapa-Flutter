part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = context.bloc<MapaBloc>();
    final miUbicacion = context.bloc<MiUbicacionBloc>();

    return Container(
      margin:const  EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location),
          color:const Color.fromARGB(221, 65, 2, 80),
          onPressed: () {
            final destino = miUbicacion.state.ubicacion;
            mapaBloc.moverCamara(destino!);
          },
        ),
      ),
    );
  }
}
