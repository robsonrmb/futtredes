import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/custom-dialog.dart';

class DialogFutt {
  /*
  Instanciar: DialogFutt dialogFutt = new DialogFutt();
  onPressed: () => dialogFutt.information(context, "", "");
 */
  information(BuildContext context, String title, String description) {
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
        });
  }

  /*
  Instanciar: DialogFutt dialogFutt = new DialogFutt();
  onPressed: () async {
    dialogFutt.waiting(context, "", "");
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
 */
  // waiting(BuildContext context, String title, String description){
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext) {
  //         return AlertDialog(
  //           title: Text(title),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text(description),
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }

  waiting(BuildContext context, String title, String description) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return new WillPopScope(
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: CustomDialog(
                    title: title,
                    description: description,
                    buttonText: null,
                    color: Colors.amber,
                    icon: new Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
              ),
            onWillPop: () => Future.value(false),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  waitingSucess(BuildContext context, String title, String description) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return new WillPopScope(
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: CustomDialog(
                    title: title,
                    buttonText: null,
                    description: description,
                    color: Colors.green,
                    icon: new Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
              ),
            onWillPop: () => Future.value(false),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  waitingError(BuildContext context, String title, String description) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return new WillPopScope(
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: CustomDialog(
                    title: title,
                    description: description,
                    buttonText: null,
                    color: Colors.red,
                    icon: new Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
              ),
            onWillPop: () => Future.value(false),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
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
    } else {
      print("Não");
    }
  }

  confirm(BuildContext context, String title, String description) {
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
        });
  }

  void showAlertDialogActionNoYes(
    BuildContext context,
    String title,
    String description,
    GestureTapCallback action,
  ) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return new WillPopScope(
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: CustomDialog(
                    title: title,
                    encerrar: true,
                    actionYes: action,
                    description: description,
                    buttonText: "OK",
                    color: Colors.amber,
                    icon: new Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
              ),
            onWillPop: () => Future.value(false),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
