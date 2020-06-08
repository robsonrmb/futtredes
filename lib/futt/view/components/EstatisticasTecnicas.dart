import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/RespPerformanceModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/graphics/HorizontalGroupBarChart.dart';

class EstatisticasTecnicas extends StatefulWidget {
  @override
  _EstatisticasTecnicasState createState() => _EstatisticasTecnicasState();
}

class _EstatisticasTecnicasState extends State<EstatisticasTecnicas> {

  var _valoresPerformanceTecnicas;

  /*
  @override
  void initState() {
    _valoresPerformanceTecnicas = _getValoresPerformanceTecnicos();
    super.initState();
  }
  */

  Future<List<RespostaModel>> _getValoresPerformanceTecnicos() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getPerformanceTecnica(0, 2020, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  List<charts.Series<RespPerformanceModel, String>> _createGraphicsPerformanceTecnicas() {

    final dataRuim = [
      new RespPerformanceModel.Grafico("Recepção", int.parse(_valoresPerformanceTecnicas[0])),
      new RespPerformanceModel.Grafico("Levantada", int.parse(_valoresPerformanceTecnicas[1])),
      new RespPerformanceModel.Grafico("Ataque", int.parse(_valoresPerformanceTecnicas[2])),
      new RespPerformanceModel.Grafico("Defesa", int.parse(_valoresPerformanceTecnicas[3])),
      new RespPerformanceModel.Grafico("Shark", int.parse(_valoresPerformanceTecnicas[4])),
      new RespPerformanceModel.Grafico("Pescoço", int.parse(_valoresPerformanceTecnicas[5])),
      new RespPerformanceModel.Grafico("Ombro", int.parse(_valoresPerformanceTecnicas[6])),
      new RespPerformanceModel.Grafico("Pé", int.parse(_valoresPerformanceTecnicas[7])),
    ];
    final dataRegular = [
      new RespPerformanceModel.Grafico("Recepção", int.parse(_valoresPerformanceTecnicas[8])),
      new RespPerformanceModel.Grafico("Levantada", int.parse(_valoresPerformanceTecnicas[9])),
      new RespPerformanceModel.Grafico("Ataque", int.parse(_valoresPerformanceTecnicas[10])),
      new RespPerformanceModel.Grafico("Defesa", int.parse(_valoresPerformanceTecnicas[11])),
      new RespPerformanceModel.Grafico("Shark", int.parse(_valoresPerformanceTecnicas[12])),
      new RespPerformanceModel.Grafico("Pescoço", int.parse(_valoresPerformanceTecnicas[13])),
      new RespPerformanceModel.Grafico("Ombro", int.parse(_valoresPerformanceTecnicas[14])),
      new RespPerformanceModel.Grafico("Pé", int.parse(_valoresPerformanceTecnicas[15])),
    ];
    final dataBom = [
      new RespPerformanceModel.Grafico("Recepção", int.parse(_valoresPerformanceTecnicas[16])),
      new RespPerformanceModel.Grafico("Levantada", int.parse(_valoresPerformanceTecnicas[17])),
      new RespPerformanceModel.Grafico("Ataque", int.parse(_valoresPerformanceTecnicas[18])),
      new RespPerformanceModel.Grafico("Defesa", int.parse(_valoresPerformanceTecnicas[19])),
      new RespPerformanceModel.Grafico("Shark", int.parse(_valoresPerformanceTecnicas[20])),
      new RespPerformanceModel.Grafico("Pescoço", int.parse(_valoresPerformanceTecnicas[21])),
      new RespPerformanceModel.Grafico("Ombro", int.parse(_valoresPerformanceTecnicas[22])),
      new RespPerformanceModel.Grafico("Pé", int.parse(_valoresPerformanceTecnicas[23])),
    ];
    final dataOtimo = [
      new RespPerformanceModel.Grafico("Recepção", int.parse(_valoresPerformanceTecnicas[24])),
      new RespPerformanceModel.Grafico("Levantada", int.parse(_valoresPerformanceTecnicas[25])),
      new RespPerformanceModel.Grafico("Ataque", int.parse(_valoresPerformanceTecnicas[26])),
      new RespPerformanceModel.Grafico("Defesa", int.parse(_valoresPerformanceTecnicas[27])),
      new RespPerformanceModel.Grafico("Shark", int.parse(_valoresPerformanceTecnicas[28])),
      new RespPerformanceModel.Grafico("Pescoço", int.parse(_valoresPerformanceTecnicas[29])),
      new RespPerformanceModel.Grafico("Ombro", int.parse(_valoresPerformanceTecnicas[30])),
      new RespPerformanceModel.Grafico("Pé", int.parse(_valoresPerformanceTecnicas[31])),
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
        measureFn:  (RespPerformanceModel resp, _) => resp.valor,
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
      future: _getValoresPerformanceTecnicos(),
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
              _valoresPerformanceTecnicas = resultado.resposta.split("#");

              return Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("AVALIAÇÕES TÉCNICAS",style: TextStyle(fontWeight: FontWeight.bold),),
                      Container(
                        height: 300,
                        child: HorizontalGroupBarChart(_createGraphicsPerformanceTecnicas(), true),
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
