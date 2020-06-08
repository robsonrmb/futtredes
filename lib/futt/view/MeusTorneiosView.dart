import 'package:futt/futt/view/subview/MeusTorneiosSubView.dart';
import 'package:flutter/material.dart';

class MeusTorneiosView extends StatefulWidget {
  @override
  _MeusTorneiosViewState createState() => _MeusTorneiosViewState();
}

class _MeusTorneiosViewState extends State<MeusTorneiosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        backgroundColor: Color(0xff093352),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Meus torneios"),
      ),
      */
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: MeusTorneiosSubView(),
          )
        ],
      ),
    );
  }
}
