import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesEstatisticas.dart';
import 'package:futt/futt/model/RespPerformanceModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/graphics/DonutAutoChart.dart';

class EstatisticasQuantitativas extends StatefulWidget {
  @override
  _EstatisticasQuantitativasState createState() => _EstatisticasQuantitativasState();
}

class _EstatisticasQuantitativasState extends State<EstatisticasQuantitativas> {

  var _valoresQuantitativos;

  Future<List<RespostaModel>> _getValoresQuantitativos() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getQuantitativas(2020, ConstantesEstatisticas.QUANTITATIVOS, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - VITORIAS E DERROTAS
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsVD() {

    final dataVD = [
      new RespPerformanceModel.Grafico("Vitórias", int.parse(_valoresQuantitativos[0])),
      new RespPerformanceModel.Grafico("Derrotas", int.parse(_valoresQuantitativos[1])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'VD',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        data: dataVD,
        //colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) => '${resp.descricao} : ${resp.valor.toString()}',
      ),
    ];
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - TIE BREAKS
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsTIE() {

    final dataTIE = [
      new RespPerformanceModel.Grafico("Tiebreaks vencidos", int.parse(_valoresQuantitativos[2])),
      new RespPerformanceModel.Grafico("Tiebreaks perdidos", int.parse(_valoresQuantitativos[3])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'TIE',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        data: dataTIE,
        colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) => '${resp.descricao} : ${resp.valor.toString()}',
      )
    ];
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - CAPOTE
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsCapote() {

    final dataCapote = [
      new RespPerformanceModel.Grafico("Capotes vencidos", int.parse(_valoresQuantitativos[4])),
      new RespPerformanceModel.Grafico("Capotes perdidos", int.parse(_valoresQuantitativos[5])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'Capotes',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        data: dataCapote,
        //colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) => '${resp.descricao} : ${resp.valor.toString()}',
      )
    ];
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - A2
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsA2() {

    final dataA2 = [
      new RespPerformanceModel.Grafico("Jogos A2 vencidos", int.parse(_valoresQuantitativos[6])),
      new RespPerformanceModel.Grafico("Jogos A2 perdidos", int.parse(_valoresQuantitativos[7])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'A2',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        data: dataA2,
        colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) => '${resp.descricao} : ${resp.valor.toString()}',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>>(
      future: _getValoresQuantitativos(),
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
              _valoresQuantitativos = resultado.resposta.split("#");

              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("QUANTITATIVAS",style: TextStyle(fontWeight: FontWeight.bold),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: _tam,
                            child: DonutAutoChart(_createGraphicsVD(), true),
                          ),
                          Container(
                            height: _tam,
                            child: DonutAutoChart(_createGraphicsTIE(), true),
                          ),
                          Container(
                            height: _tam,
                            child: DonutAutoChart(_createGraphicsCapote(), true),
                          ),
                          Container(
                            height: _tam,
                            child: DonutAutoChart(_createGraphicsA2(), true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
