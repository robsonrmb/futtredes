import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/view/components/EstatisticasJogosPontos.dart';
import 'package:futt/futt/view/components/EstatisticasQuantitativas.dart';
import 'package:futt/futt/view/components/EstatisticasSequenciais.dart';
import 'package:flutter/material.dart';

class EstatisticasView extends StatefulWidget {

  int idUsuario;
  int idRede;
  String nome;
  String nomeFoto;
  EstatisticasView(this.idUsuario, this.idRede, this.nome, this.nomeFoto);

  @override
  _EstatisticasViewState createState() => _EstatisticasViewState();
}

class _EstatisticasViewState extends State<EstatisticasView> {

  @override
  Widget build(BuildContext context) {

    double _tam = 90;

    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Confire suas estatísticas",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Candal'
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('${ConstantesRest.URL_BASE_AMAZON}${widget.nomeFoto}'),
                  radius: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(widget.nome,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Veja as estatísticas de outros atletas",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Candal'
                    ),
                  ),
                ),
                EstatisticasSequenciais(widget.idUsuario, widget.idRede),
                Padding(padding: EdgeInsets.all(3),),
                EstatisticasJogosPontos(widget.idUsuario, widget.idRede),
                Padding(padding: EdgeInsets.all(3),),
                EstatisticasQuantitativas(widget.idUsuario, widget.idRede),
              ],
            ),
          ),
      ),
    );
  }
}
