part of 'helpers.dart';

void calculandoAlerta(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text(
                'Espere por favor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: LinearProgressIndicator(
                color: Color.fromARGB(221, 65, 2, 80),
                backgroundColor: Colors.black12,
              ),
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (context) => const CupertinoAlertDialog(
            title: Text('Espere por favor'),
            content: CupertinoActivityIndicator()));
  }
}
