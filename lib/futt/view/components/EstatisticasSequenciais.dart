import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/components/Estatistica.dart';

class EstatisticasSequenciais extends StatefulWidget {

  int idUsuario;
  int idRede;
  EstatisticasSequenciais(this.idUsuario, this.idRede);

  @override
  _EstatisticasSequenciaisState createState() => _EstatisticasSequenciaisState();
}

class _EstatisticasSequenciaisState extends State<EstatisticasSequenciais> {

  var _valoresSequenciais;

  Future<List<RespostaModel>> _getValoresSequenciais() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getSequenciais(widget.idUsuario, widget.idRede, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  Widget _retornaEstatistica(var _vs, int _indice) {
    return (_vs.length >= _indice+1 && _vs[_indice] != "")
        ? new Estatistica().resultadoJogo(_vs[_indice])
        : new Container(padding: EdgeInsets.only(top: 1),);
  }

  Widget _retornaEstatisticaVazia(var _vs, int _indice) {
    return (_vs.length >= _indice+1 && _vs[_indice] != "")
        ? new Padding(padding: EdgeInsets.all(3),)
        : new Padding(padding: EdgeInsets.only(top: 1),);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>>(
      future: _getValoresSequenciais(),
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
              _valoresSequenciais = resultado.resposta.split("#");

              if (_valoresSequenciais != "" && _valoresSequenciais[0] != "") {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text("ÚLTIMOS JOGOS", style: TextStyle(
                                fontWeight: FontWeight.bold),),
                            Padding(padding: EdgeInsets.all(3),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _retornaEstatistica(this._valoresSequenciais, 0),
                                _retornaEstatisticaVazia(this._valoresSequenciais, 0),
                                _retornaEstatistica(this._valoresSequenciais, 1),
                                _retornaEstatisticaVazia(this._valoresSequenciais, 1),
                                _retornaEstatistica(this._valoresSequenciais, 2),
                                _retornaEstatisticaVazia(this._valoresSequenciais, 2),
                                _retornaEstatistica(this._valoresSequenciais, 3),
                                _retornaEstatisticaVazia(this._valoresSequenciais, 3),
                                _retornaEstatistica(this._valoresSequenciais, 4),
                                _retornaEstatisticaVazia(this._valoresSequenciais, 4),
                                _retornaEstatistica(this._valoresSequenciais, 5),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }else{
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text("ÚLTIMOS JOGOS",style: TextStyle(fontWeight: FontWeight.bold),),
                            Padding(padding: EdgeInsets.all(3),),
                            Text("Sem valores"),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
          }else{
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("ÚLTIMOS JOGOS",style: TextStyle(fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.all(3),),
                        Text("Sem valores"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          break;
        }
      },
    );
  }
}
