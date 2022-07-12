import 'package:flutter/material.dart';

class MarkerDestinoPainter extends CustomPainter {
  final String descripcion;
  final double metros;

  MarkerDestinoPainter(this.descripcion, this.metros);

  @override
  void paint(Canvas canvas, Size size) {
    const double circuloNegroR = 20;
    const double circuloBlanco = 7;
    Paint paint = Paint();
    paint.color = Colors.black;

    //Dibujar circular negrow

    canvas.drawCircle(
        Offset(circuloNegroR, size.height - circuloNegroR), 20, paint);

    //Circulo bLANCO

    paint.color = Colors.white;

    canvas.drawCircle(Offset(circuloNegroR, size.height - circuloNegroR),
        circuloBlanco, paint);

    //Sombras de
    final Path path = Path();
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    //Caja blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    //Caja negra

    paint.color = Colors.black;
    const cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //Dibujar textos
    double kilometros = metros / 1000;
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;

    TextSpan textSpan = TextSpan(
        style: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
        text: '$kilometros');

    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, const Offset(0, 35));

    //Dibujar Minutos
    textSpan = const TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: 'km');

    final textPainterM = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(
        maxWidth: 70,
      );

    textPainterM.paint(canvas, const Offset(20, 67));

    //Mi ubicacion
    textSpan = TextSpan(
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        text: descripcion);

    final textPainterU = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 2,
        ellipsis: '...')
      ..layout(maxWidth: size.width - 100, minWidth: 70);

    textPainterU.paint(canvas, const Offset(90, 35));
  }

  @override
  bool shouldRepaint(MarkerDestinoPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerDestinoPainter oldDelegate) => false;
}
