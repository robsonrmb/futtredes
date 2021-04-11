import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/RespPerformanceModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/graphics/DonutAutoChart.dart';
import 'package:futt/futt/view/graphics/testeBar.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:shimmer/shimmer.dart';

class EstatisticasQuantitativas extends StatefulWidget {
  int idUsuario;
  int idRede;

  EstatisticasQuantitativas(this.idUsuario, this.idRede);

  @override
  _EstatisticasQuantitativasState createState() =>
      _EstatisticasQuantitativasState();
}

class _EstatisticasQuantitativasState extends State<EstatisticasQuantitativas> {
  var _valoresQuantitativos;

  int anoSelect = 0;
  int ano1 = 0;
  int ano2 = 0;
  int ano3 = 0;

  Color colorDefault = Color(0xFF0D47A1);
  Color colorAno1 = Colors.grey[400];
  Color colorAno2 = Colors.grey[400];
  Color colorAno3 = Colors.grey[400];

  Color colorDefaultText = Colors.white;
  Color colorAno1Text = Colors.grey[800];
  Color colorAno2Text = Colors.grey[800];
  Color colorAno3Text = Colors.grey[800];

  Future<List<RespostaModel>> _getValoresQuantitativos() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getQuantitativas(
        widget.idUsuario, widget.idRede, anoSelect, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - VITORIAS E DERROTAS
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsVD() {
    final dataVD = [
      //new RespPerformanceModel.Grafico("Vitórias", int.parse(_valoresQuantitativos[0])),
      //new RespPerformanceModel.Grafico("Derrotas", int.parse(_valoresQuantitativos[1])),
      new RespPerformanceModel.Grafico(
        "Vitórias",
        int.parse(_valoresQuantitativos[0]),
      ),
      new RespPerformanceModel.Grafico(
          "Derrotas", int.parse(_valoresQuantitativos[1])),
      new RespPerformanceModel.Grafico(
          "Jogos A2 vencidos", int.parse(_valoresQuantitativos[4])),
      new RespPerformanceModel.Grafico(
          "Jogos A2 perdidos", int.parse(_valoresQuantitativos[5])),
      new RespPerformanceModel.Grafico(
          "Capotes vencidos", int.parse(_valoresQuantitativos[2])),
      new RespPerformanceModel.Grafico(
          "Capotes perdidos", int.parse(_valoresQuantitativos[3])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'ds',
        colorFn: (_, __) => __ == 0
            ? charts.ColorUtil.fromDartColor(Color(0xff083251))
            : __ == 1
                ? charts.ColorUtil.fromDartColor(Colors.orange[300])
                : __ == 2
                    ? charts.ColorUtil.fromDartColor(Color(0xff083251))
                    : __ == 3
                        ? charts.ColorUtil.fromDartColor(Colors.orange[300])
                        : __ == 4
                            ? charts.ColorUtil.fromDartColor(Color(0xff083251))
                            : charts.ColorUtil.fromDartColor(
                                Colors.orange[300]),

        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn: (RespPerformanceModel resp, _) => resp.valor,
        data: dataVD,
        //colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) =>
            '${resp.valor.toString()}',
      ),
    ];
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - CAPOTE
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsCapote() {
    final dataCapote = [
      new RespPerformanceModel.Grafico(
          "Capotes vencidos", int.parse(_valoresQuantitativos[2])),
      new RespPerformanceModel.Grafico(
          "Capotes perdidos", int.parse(_valoresQuantitativos[3])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'Capotes',
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn: (RespPerformanceModel resp, _) => resp.valor,
        data: dataCapote,
        //colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) =>
            '${resp.descricao} : ${resp.valor.toString()}',
      )
    ];
  }

  /*
   ESTATÍSTICAS QUANTITATIVAS - A2
   */
  List<charts.Series<RespPerformanceModel, String>> _createGraphicsA2() {
    final dataA2 = [
      new RespPerformanceModel.Grafico(
          "Jogos A2 vencidos", int.parse(_valoresQuantitativos[4])),
      new RespPerformanceModel.Grafico(
          "Jogos A2 perdidos", int.parse(_valoresQuantitativos[5])),
    ];

    return [
      new charts.Series<RespPerformanceModel, String>(
        id: 'A2',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (RespPerformanceModel resp, _) => resp.descricao,
        measureFn: (RespPerformanceModel resp, _) => resp.valor,
        data: dataA2,
        //colorFn: (RespPerformanceModel resp, _) => charts.ColorUtil.fromDartColor(Colors.orangeAccent),
        labelAccessorFn: (RespPerformanceModel resp, _) =>
            '${resp.descricao} : ${resp.valor.toString()}',
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    int year = now.year;
    ano1 = year;
    ano2 = year - 1;
    ano3 = year - 2;
    print(year);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>>(
      future: _getValoresQuantitativos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new FadeAnimation(
              1.3,
              new Container(
                margin: const EdgeInsets.only(right: 8, left: 8),
                child: new Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Quantitativas",
                              style: TextStyle(
                                color: AppColors.colorTextTitlesDash,
                                fontSize: 16,
                                fontFamily: FontFamily.fontSpecial,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 150,
                                    decoration: new BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8)),
                                  )),
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Container(
                                    margin: const EdgeInsets.only(left: 32),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'Vitórias'.toUpperCase(),
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(left: 28),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'DERROTAS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(left: 26),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'JOGOS A 2 VENCIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(left: 28),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'JOGOS A 2 PERDIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(left: 26),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'CAPOTES VENCIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(left: 28),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'CAPOTES PERDIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              // Container(
                              //   height: _tam,
                              //   child: DonutAutoChart(_createGraphicsCapote(), true),
                              // ),
                              // Container(
                              //   height: _tam,
                              //   child: DonutAutoChart(_createGraphicsA2(), true),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              horizontal: true,
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              double _tam = 90;
              List<RespostaModel> estatisticas = snapshot.data;
              RespostaModel resultado = estatisticas[0];
              _valoresQuantitativos = resultado.resposta.split("#");

              return new Container(
                margin: const EdgeInsets.only(right: 8, left: 8),
                child: new Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Quantitativas",
                              style: TextStyle(
                                color: AppColors.colorTextTitlesDash,
                                fontSize: 16,
                                fontFamily: FontFamily.fontSpecial,
                              ),
                            ),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildYears('Últimos 3 anos', colorDefaultText, colorDefault, 1),
                              buildYears(ano1.toString(), colorAno1Text, colorAno1, 2),
                              buildYears(ano2.toString(), colorAno2Text, colorAno2, 3),
                              buildYears(ano3.toString(),colorAno3Text, colorAno3, 4),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 150,
                                child: DonutAutoChart(
                                  _createGraphicsVD(),
                                  true,
                                ),
                              ),
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'Vitórias'.toUpperCase(),
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'DERROTAS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'JOGOS A 2 VENCIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'JOGOS A 2 PERDIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'CAPOTES VENCIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    child: new RotatedBox(
                                      quarterTurns: -1,
                                      child: new Text(
                                        'CAPOTES PERDIDOS',
                                        style: new TextStyle(
                                            color:
                                                AppColors.colorTextTitlesDash,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              // Container(
                              //   height: _tam,
                              //   child: DonutAutoChart(_createGraphicsCapote(), true),
                              // ),
                              // Container(
                              //   height: _tam,
                              //   child: DonutAutoChart(_createGraphicsA2(), true),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Sem valores!!!"),
              );
            }
            break;
        }
        return null;
      },
    );
  }

  Widget buildYears(String title, Color colorText, Color color, int index) {
    return new GestureDetector(
      onTap: () {
        selectItemYears(index);
        setState(() {});
      },
      child: new Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: new BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8)),
        child: new Text(
          title,
          style: new TextStyle(color: colorText),
        ),
      ),
    );
  }

  void selectItemYears(int years) {
    switch (years) {
      case 1:
        anoSelect = 0;
        colorDefault =  Color(0xFF0D47A1);
        colorAno1 = Colors.grey[400];
        colorAno2 = Colors.grey[400];
        colorAno3 = Colors.grey[400];

        colorDefaultText = Colors.white;
        colorAno1Text = Colors.grey[800];
        colorAno2Text = Colors.grey[800];
        colorAno3Text = Colors.grey[800];
        break;
      case 2:
        anoSelect = ano1;
        colorDefault = Colors.grey[400];
        colorAno1 =  Color(0xFF0D47A1);
        colorAno2 = Colors.grey[400];
        colorAno3 = Colors.grey[400];
        colorDefaultText = Colors.grey[800];
        colorAno1Text = Colors.white;
        colorAno2Text = Colors.grey[800];
        colorAno3Text = Colors.grey[800];
        break;
      case 3:
        anoSelect = ano2;
        colorDefault =Colors.grey[400];
        colorAno1 = Colors.grey[400];
        colorAno2 =  Color(0xFF0D47A1);
        colorAno3 = Colors.grey[400];
        colorDefaultText = Colors.grey[800];
        colorAno1Text = Colors.grey[800];
        colorAno2Text = Colors.white;
        colorAno3Text = Colors.grey[800];
        break;
      case 4:
        anoSelect = ano3;
        colorDefault = Colors.grey[400];
        colorAno1 = Colors.grey[400];
        colorAno2 = Colors.grey[400];
        colorAno3 =  Color(0xFF0D47A1);
        colorDefaultText = Colors.grey[800];
        colorAno1Text = Colors.grey[800];
        colorAno2Text = Colors.grey[800];
        colorAno3Text =  Colors.white;
        break;
      default:
        break;
    }
  }
}
