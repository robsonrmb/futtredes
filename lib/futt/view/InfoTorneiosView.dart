import 'package:flutter/material.dart';

class InfoTorneiosView extends StatefulWidget {
  @override
  _InfoTorneiosViewState createState() => _InfoTorneiosViewState();
}

class _InfoTorneiosViewState extends State<InfoTorneiosView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Conteúdo de como gerenciar os torneios.",
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
            RaisedButton(
              color: Color(0xff086ba4),
              textColor: Colors.white,
              padding: EdgeInsets.all(15),
              child: Text(
                "Cadastrar novo torneio",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Candal',
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/novo_torneio");
              },
            ),
          ],
        ),
      ),
    );
  }
}
