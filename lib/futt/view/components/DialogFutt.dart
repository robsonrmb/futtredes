import 'package:flutter/material.dart';

class DialogFutt {

  /*
  Instanciar: DialogFutt dialogFutt = new DialogFutt();
  onPressed: () => dialogFutt.information(context, "", "");
 */
  information(BuildContext context, String title, String description){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        );
      }
    );
  }

  /*
  Instanciar: DialogFutt dialogFutt = new DialogFutt();
  onPressed: () async {
    dialogFutt.waiting(context, "", "");
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
 */
  waiting(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
          );
        }
    );
  }

  /*
  Instanciar: DialogFutt dialogFutt = new DialogFutt();
  onPressed: () async {
    dialogFutt.confirm(context, "", "");
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
 */
  _confirm(bool resposta, BuildContext context) {
    if (resposta) {
      print("Sim...");
    }else{
      print("Não");
    }
  }

  confirm(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _confirm(false, context),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _confirm(true, context),
                child: Text("Sim"),
              )
            ],
          );
        }
    );
  }
}