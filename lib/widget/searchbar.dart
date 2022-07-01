

// ignore_for_file: use_build_context_synchronously

part of 'widgets.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



return BlocBuilder<BusquedaBloc,BusquedaState>(
  builder: (context,event){
    if(event.seleccionManual){
      return Container();
    }else{
      return FadeInDown(child: buildSearchbar(context));
    }

  });
   
    
  }

  Widget buildSearchbar(BuildContext context){
    final width = MediaQuery.of(context).size.width;

     return SafeArea(
      child: GestureDetector(
        onTap: ()async{
         final result= await showSearch(context: context, delegate: SearchDestination());

          retornoBusqueda(context,result!);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: width,
         // height: 100,
         // color: Colors.red,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:20,vertical:13),
            width: double.infinity,
         
            child: Text('Donde quieres ir?',style: TextStyle(
              color: Colors.black87
            ),),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow:<BoxShadow> [
               BoxShadow( color:Colors.black12,
               blurRadius: 5,
               offset: Offset(0,5)
               )
      
              ]
            ),
          )
        ),
      ),
    );

  }

  void retornoBusqueda(BuildContext context,SearchResult result) {
    final busquedaBloc = context.bloc<BusquedaBloc>();
    if (result.cancelo)return;

    if (result.manual!){

      // ignore: deprecated_member_use
      busquedaBloc.add(OnActivarMarcadorManual());

      return;
    }

  }
}