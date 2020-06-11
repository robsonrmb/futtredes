import 'package:flutter/material.dart';

class MensalidadeView extends StatefulWidget {
  @override
  _MensalidadeViewState createState() => _MensalidadeViewState();
}

class _MensalidadeViewState extends State<MensalidadeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text("Valores mensais"),
        ),
        body: Container(
          color: Colors.amberAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Tabela com valores mensais.",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                Text(
                  "EM DESENVOLVIMENTO!!!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
