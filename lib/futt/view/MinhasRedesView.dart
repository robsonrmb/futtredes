import 'package:futt/futt/view/subview/MinhasRedesSubView.dart';
import 'package:flutter/material.dart';

class MinhasRedesView extends StatefulWidget {
  @override
  _MinhasRedesViewState createState() => _MinhasRedesViewState();
}

class _MinhasRedesViewState extends State<MinhasRedesView> {
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
            child: MinhasRedesSubView(),
          )
        ],
      ),
    );
  }
}
