// ignore: depend_on_referenced_packages, import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:flutter_avanzado_3mapa/models/search_result.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if (event is OnActivarMarcadorManual) {
      yield state.copyWiht(seleccionManual: true);
    } else if (event is OnDesactivarMarcadorManual) {
      yield state.copyWiht(seleccionManual: false);
    } else if (event is OnAgregarHistorial) {
      final existe = state.historial
          .where((result) => result.nombreDestino == event.result.descripcion)
          .length;

      if (existe == 0) {
        final newHistorial = [...state.historial, event.result];
        yield state.copyWiht(historial: newHistorial);
      }
    }
  }
}
