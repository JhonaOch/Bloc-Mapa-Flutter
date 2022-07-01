part of 'widgets.dart';



class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
      // ignore: deprecated_member_use
      final mapaBloc = context.bloc<MapaBloc>();
      // ignore: deprecated_member_use
      final miUbicacion = context.bloc<MiUbicacionBloc>();

    return  Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location),color: Colors.black87,
          onPressed: (){

            final destino= miUbicacion.state.ubicacion;

            mapaBloc.moverCamara(destino!);

          },),

      ),
    );
    
  }
}