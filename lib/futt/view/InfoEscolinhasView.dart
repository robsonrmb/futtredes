import 'package:flutter/material.dart';

class InfoEscolinhasView extends StatefulWidget {
  @override
  _InfoEscolinhasViewState createState() => _InfoEscolinhasViewState();
}

class _InfoEscolinhasViewState extends State<InfoEscolinhasView> {
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
              "Conteúdo de como gerenciar as escolinhas.",
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
    );
  }
}
