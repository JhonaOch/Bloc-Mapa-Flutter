import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  // ignore: overridden_fields
  final String? searchFieldLabel;

  SearchDestination():searchFieldLabel ='Buscar...';

  @override
  List<Widget>? buildActions(Object context) {
    return [
      IconButton(onPressed: () {
        //DATOS INGRESADOS
        query='';
      }, 
      icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    //TODO Boton izquierdo
    return IconButton(
        onPressed: () {
   
          close(context,SearchResult(cancelo: true));

        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Buil Leading');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children:[
         ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Amazonas"),
          onTap: (){
            print("object");
          close(context,SearchResult(cancelo: false,manual :true));
          
          },

         ),

         ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Amazonas2"),

         ),

         ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Amazonas3"),

         ),


      ]
     
    );
  }
}
