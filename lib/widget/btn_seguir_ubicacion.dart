part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  const BtnSeguirUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
   
    // ignore: deprecated_member_use

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state)=>_crearBoton(context,state)
    );
  }

Widget _crearBoton(BuildContext context,MapaState state){
   final mapaBloc = context.bloc<MapaBloc>();
  return Container(
          margin:const EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(state.seguriUbicacion
                  ? Icons.directions_run
                  : Icons.accessibility_new),
              color: Colors.black87,
              onPressed: () {
                mapaBloc.add(OnSeguirUbicacion());
              },
            ),
          ),
        );

}
}
