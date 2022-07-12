import 'package:flutter/material.dart';
class MarkerInicioPainter extends CustomPainter {
  final int minutos;

  MarkerInicioPainter(this.minutos);

  @override
  void paint(Canvas canvas, Size size) {
    final double circuloNegroR = 20;
    final double circuloBlanco = 7;
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
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    //Caja blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 50, 80);
    canvas.drawRect(cajaBlanca, paint);

    //Caja negra

    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //Dibujar textos
    TextSpan textSpan = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        text: '${minutos}');

    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 70, minWidth: 70);

    textPainter.paint(canvas, Offset(40, 35));

    //Dibujar Minutos
    textSpan = TextSpan(
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        text: 'Min');

    final textPainterM = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 70, minWidth: 70);

    textPainterM.paint(canvas, Offset(40, 67));

    //Mi ubicacion
    textSpan = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
        text: 'Mi ubicacion');

    final textPainterU = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: size.width - 130, minWidth: 70);

    textPainterU.paint(canvas, Offset(160, 50));
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}
