part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionManual;

  BusquedaState({
    this.seleccionManual = false,
  });

  //Polynines

  BusquedaState copyWiht({
    bool? seleccionManual,
  }) =>
      BusquedaState(seleccionManual: seleccionManual ?? this.seleccionManual);
}
