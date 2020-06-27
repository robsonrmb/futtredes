import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesEstatisticas.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/components/Estatistica.dart';

class EstatisticasJogosPontos extends StatefulWidget {

  int idUsuario;
  int idRede;
  EstatisticasJogosPontos(this.idUsuario, this.idRede);

  @override
  _EstatisticasJogosPontosState createState() => _EstatisticasJogosPontosState();
}

class _EstatisticasJogosPontosState extends State<EstatisticasJogosPontos> {

  var _valoresJogosEPontos;

  Future<List<RespostaModel>> _getValoresJogosEPontos() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getJogosEPontos(widget.idUsuario, widget.idRede, 0, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>>(
      future: _getValoresJogosEPontos(),
      builder: (context, snapshot) {
        switch( snapshot.connectionState ) {
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
            if( snapshot.hasData ) {

              double _tam = 90;
              List<RespostaModel> estatisticas = snapshot.data;
              RespostaModel resultado = estatisticas[0];
              _valoresJogosEPontos = resultado.resposta.split("#");

              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text("JOGOS",style: TextStyle(fontWeight: FontWeight.bold),),
                          Padding(padding: EdgeInsets.all(3),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Estatistica().jogosPontos(int.parse(_valoresJogosEPontos[0]), int.parse(_valoresJogosEPontos[1]), 0),
                              Padding(padding: EdgeInsets.all(3),),
                              new Estatistica().jogosPontos(int.parse(_valoresJogosEPontos[2]), int.parse(_valoresJogosEPontos[3]), 1),
                              Padding(padding: EdgeInsets.all(3),),
                              new Estatistica().jogosPontos(int.parse(_valoresJogosEPontos[4]), int.parse(_valoresJogosEPontos[5]), 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3),),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text("PONTOS",style: TextStyle(fontWeight: FontWeight.bold),),
                          Padding(padding: EdgeInsets.all(3),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Estatistica().jogosPontos(int.parse(_valoresJogosEPontos[6]), int.parse(_valoresJogosEPontos[7]), 0),
                              Padding(padding: EdgeInsets.all(3),),
                              new Estatistica().jogosPontos(int.parse(_valoresJogosEPontos[8]), int.parse(_valoresJogosEPontos[9]), 1),
                              Padding(padding: EdgeInsets.all(3),),
                              new Estatistica().jogosPontos(int.parse(_valoresJogosEPontos[10]), int.parse(_valoresJogosEPontos[11]), 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else{
              return Center(
                child: Text("Sem valores!!!"),
              );
            }
            break;
        }
      },
    );
  }
}
