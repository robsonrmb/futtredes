import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/RespPerformanceModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/graphics/HorizontalGroupBarChart.dart';

class EstatisticasTaticas extends StatefulWidget {
  @override
  _EstatisticasTaticasState createState() => _EstatisticasTaticasState();
}

class _EstatisticasTaticasState extends State<EstatisticasTaticas> {

  var _valoresPerformanceTaticas;

  Future<List<RespostaModel>> _getValoresPerformanceTaticas() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getPerformanceTatica(0, 2020, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  List<charts.Series<RespPerformanceModel, String>> _createGraphicsPerformanceTaticas() {

    final dataRuim = [
      new RespPerformanceModel.Grafico("Constante", int.parse(_valoresPerformanceTaticas[0])),
      new RespPerformanceModel.Grafico("Variação", int.parse(_valoresPerformanceTaticas[1])),
      new RespPerformanceModel.Grafico("Inteligente", int.parse(_valoresPerformanceTaticas[2])),
      new RespPerformanceModel.Grafico("Tático", int.parse(_valoresPerformanceTaticas[3])),
      new RespPerformanceModel.Grafico("Competitivo", int.parse(_valoresPerformanceTaticas[4])),
      new RespPerformanceModel.Grafico("Preparo", int.parse(_valoresPerformanceTaticas[5])),
    ];
    final dataRegular = [
      new RespPerformanceModel.Grafico("Constante", int.parse(_valoresPerformanceTaticas[6])),
      new RespPerformanceModel.Grafico("Variação", int.parse(_valoresPerformanceTaticas[7])),
      new RespPerformanceModel.Grafico("Inteligente", int.parse(_valoresPerformanceTaticas[8])),
      new RespPerformanceModel.Grafico("Tático", int.parse(_valoresPerformanceTaticas[9])),
      new RespPerformanceModel.Grafico("Competitivo", int.parse(_valoresPerformanceTaticas[10])),
      new RespPerformanceModel.Grafico("Preparo", int.parse(_valoresPerformanceTaticas[11])),
    ];
    final dataBom = [
      new RespPerformanceModel.Grafico("Constante", int.parse(_valoresPerformanceTaticas[12])),
      new RespPerformanceModel.Grafico("Variação", int.parse(_valoresPerformanceTaticas[13])),
      new RespPerformanceModel.Grafico("Inteligente", int.parse(_valoresPerformanceTaticas[14])),
      new RespPerformanceModel.Grafico("Tático", int.parse(_valoresPerformanceTaticas[15])),
      new RespPerformanceModel.Grafico("Competitivo", int.parse(_valoresPerformanceTaticas[16])),
      new RespPerformanceModel.Grafico("Preparo", int.parse(_valoresPerformanceTaticas[17])),
    ];
    final dataOtimo = [
      new RespPerformanceModel.Grafico("Constante", int.parse(_valoresPerformanceTaticas[18])),
      new RespPerformanceModel.Grafico("Variação", int.parse(_valoresPerformanceTaticas[19])),
      new RespPerformanceModel.Grafico("Inteligente", int.parse(_valoresPerformanceTaticas[20])),
      new RespPerformanceModel.Grafico("Tático", int.parse(_valoresPerformanceTaticas[21])),
      new RespPerformanceModel.Grafico("Competitivo", int.parse(_valoresPerformanceTaticas[22])),
      new RespPerformanceModel.Grafico("Preparo", int.parse(_valoresPerformanceTaticas[23])),
    ];
    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'Ruim',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Color(0xfffde0d2)),
        data: dataRuim,
      ),
      new charts.Series<RespPerformanceModel, String>(
        id: 'Regular',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn: (RespPerformanceModel resp, _) => resp.valor,
        colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        data: dataRegular,
      ),
      new charts.Series<RespPerformanceModel, String>(
        id: 'Bom',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Color(0xff89d5ff)),
        data: dataBom,
      ),
      new charts.Series<RespPerformanceModel, String>(
        id: 'Ótimo',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
        data: dataOtimo,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>>(
      future: _getValoresPerformanceTaticas(),
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
              _valoresPerformanceTaticas = resultado.resposta.split("#");

              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("AVALIAÇÕES TÁTICAS",style: TextStyle(fontWeight: FontWeight.bold),),
                      Container(
                        height: 230,
                        child: HorizontalGroupBarChart(_createGraphicsPerformanceTaticas(), true),
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
