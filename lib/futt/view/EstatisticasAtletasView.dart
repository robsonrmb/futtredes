import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:flutter/material.dart';

class EstatisticasAtletasView extends StatefulWidget {

  int idUsuario;
  int idRede;
  String nome;
  String nomeFoto;
  EstatisticasAtletasView(this.idUsuario, this.idRede, this.nome, this.nomeFoto);

  @override
  _EstatisticasAtletasViewState createState() => _EstatisticasAtletasViewState();
}

class _EstatisticasAtletasViewState extends State<EstatisticasAtletasView> {

  @override
  Widget build(BuildContext context) {

    double _tam = 90;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Estatísticas",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        backgroundColor: Color(0xff093352),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: EstatisticasView(widget.idUsuario, widget.idRede, widget.nome, widget.nomeFoto),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
