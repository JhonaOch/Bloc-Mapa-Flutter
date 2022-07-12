part of 'widgets.dart';

class BtnMiRuta extends StatelessWidget {
  const BtnMiRuta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final mapaBloc = context.bloc<MapaBloc>();
    // ignore: deprecated_member_use
   // final miUbicacion = context.bloc<MiUbicacionBloc>();

    return Container(
      margin:const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.more_horiz),
          color: const Color.fromARGB(221, 65, 2, 80),
          onPressed: () {
            mapaBloc.add(OnMarcaRecorrido());
          },
        ),
      ),
    );
  }
}
