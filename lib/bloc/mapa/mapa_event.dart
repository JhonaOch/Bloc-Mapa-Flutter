part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {

}


class OnMapaListo extends MapaEvent {

}

class OnNuevaUbicacion extends MapaEvent {
  final LatLng ubicacion;

  OnNuevaUbicacion(this.ubicacion);
}


class OnMarcaRecorrido extends MapaEvent {

}

class OnSeguirUbicacion extends MapaEvent {

}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;

  OnMovioMapa(this.centroMapa);


}


class OnCrearRutaInicioDestino extends MapaEvent {
final List<LatLng> rutaCoordenas;
final double distancia;
final double duracion;

  OnCrearRutaInicioDestino(this.rutaCoordenas, this.distancia, this.duracion);



}


