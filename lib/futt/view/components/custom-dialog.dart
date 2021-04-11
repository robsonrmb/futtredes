
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final Color color;
  final Icon icon;
  final bool encerrar;
  final GestureTapCallback actionYes;

  CustomDialog(
      {@required this.title,
        @required this.description,
        this.buttonText,
        this.color,
        this.image,
        this.encerrar: false,
        this.actionYes,
        this.icon});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: !encerrar?dialogContent(context):dialogContentEnc(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              buttonText != null?
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText),
                ),
              ):new Container(),
            ],
          ),
        ),
        Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: Container(
              height: 100,
              width: 100,
              decoration: new BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: new Border.all(color: Colors.white, width: 3)),
              child: new Center(
                child: icon,
              ),
            )
          // CircleAvatar(
          //   backgroundColor: color,
          //   radius: Consts.avatarRadius,
          //   child: new Center(
          //     child:icon
          //     //new Icon(Icons.clear,color: Colors.white,size: 70,),
          //   ),
          // ),
        ),
      ],
    );
  }

  dialogContentEnc(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                    color: AppColors.colorButtonDialog,
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text('Não',style: new TextStyle(color: Colors.white),),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                    color: AppColors.colorButtonDialog,
                    onPressed: actionYes,
                    child: Text('Sim',style: new TextStyle(color: Colors.white),),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: Container(
              height: 100,
              width: 100,
              decoration: new BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: new Border.all(color: Colors.white, width: 3)),
              child: new Center(
                child: icon,
              ),
            )
          // CircleAvatar(
          //   backgroundColor: color,
          //   radius: Consts.avatarRadius,
          //   child: new Center(
          //     child:icon
          //     //new Icon(Icons.clear,color: Colors.white,size: 70,),
          //   ),
          // ),
        ),
      ],
    );
  }

}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}