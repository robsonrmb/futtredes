import 'package:futt/futt/view/subview/AvaliacoesSubView.dart';
import 'package:flutter/material.dart';

class AvaliacoesView extends StatefulWidget {
  @override
  _AvaliacoesViewState createState() => _AvaliacoesViewState();
}

class _AvaliacoesViewState extends State<AvaliacoesView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff093352),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Avaliações"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Text("Avalie os atletas",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Candal'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text("Atletas que enfrentou em torneios anteriores.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: AvaliacoesSubView(),
          )
        ],
      ),
    );
  }
}
