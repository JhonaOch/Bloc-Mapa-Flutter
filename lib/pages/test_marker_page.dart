import 'package:flutter/material.dart';
import 'package:flutter_avanzado_3mapa/custom_markers/marker_destino.dart';

class TestMarketPage extends StatelessWidget {
  const TestMarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 350,
            height: 150,
            color: Colors.red,
            child: CustomPaint(
                // painter: MarkerInicioPainter(
                //   150
                // ),
                painter: MarkerDestinoPainter(
                    'Mi casa por algun lado del mundo', 2500))),
      ),
    );
  }
}
