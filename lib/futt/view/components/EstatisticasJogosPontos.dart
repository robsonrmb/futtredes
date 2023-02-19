import 'package:flutter/material.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/components/Estatistica.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:shimmer/shimmer.dart';

class EstatisticasJogosPontos extends StatefulWidget {
  int? idUsuario;
  int? idRede;

  EstatisticasJogosPontos(this.idUsuario, this.idRede);

  @override
  _EstatisticasJogosPontosState createState() =>
      _EstatisticasJogosPontosState();
}

class _EstatisticasJogosPontosState extends State<EstatisticasJogosPontos> {
  late var _valoresJogosEPontos;

  Future<List<RespostaModel>?> _getValoresJogosEPontos() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>?> respostas = estatisticaService.getJogosEPontos(
        widget.idUsuario, widget.idRede, 0);
    return respostas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>?>(
      future: _getValoresJogosEPontos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new FadeAnimation(1.4, Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  height: 30,
                ),
                new Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      "JOGOS",
                      style: TextStyle(
                          color:  AppColors.colorTextTitlesDash,
                          fontSize: 16,
                        fontFamily: FontFamily.fontSpecial,
                      ),
                    )),
                new Container(
                  height: 20,
                ),
                new Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Ano",
                    style: TextStyle(
                        color:  AppColors.colorTextTitlesDash,
                        fontSize: 14,
                      fontFamily: FontFamily.fontSpecial,
                    ),
                  ),
                ),
                new Container(
                  height: 10,
                ),
                new Container(
                  height: 170,
                  child: new ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          width: 140,
                          color: Colors.grey.withOpacity(0.5),

                          margin: const EdgeInsets.only(right: 10),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          width: 140,
                          color: Colors.grey.withOpacity(0.5),

                          margin: const EdgeInsets.only(right: 10),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          width: 140,
                          color: Colors.grey.withOpacity(0.5),

                          margin: const EdgeInsets.only(right: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  height: 30,
                ),
                new Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      "PONTOS",
                      style: TextStyle(
                          color:  AppColors.colorTextTitlesDash,
                          fontSize: 16,
                        fontFamily: FontFamily.fontSpecial,
                      ),
                    )),
                new Container(
                  height: 20,
                ),
                new Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Ano",
                      style: TextStyle(
                          color:  AppColors.colorTextTitlesDash,
                          fontSize: 14,
                        fontFamily: FontFamily.fontSpecial,
                      ),
                    )),
                new Container(
                  height: 10,
                ),
                new Container(
                  height: 170,
                  child: new ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          width: 140,
                          color: Colors.grey.withOpacity(0.5),
                          margin: const EdgeInsets.only(right: 10),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          width: 140,
                          color: Colors.grey.withOpacity(0.5),

                          margin: const EdgeInsets.only(right: 10),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          width: 140,
                          color: Colors.grey.withOpacity(0.5),
                          margin: const EdgeInsets.only(right: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                //   decoration: const BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(8.0),
                //       topRight: Radius.circular(8.0),
                //     ),
                //   ),
                //   child: Center(
                //     child: Column(
                //       children: <Widget>[
                //         Padding(
                //           padding: EdgeInsets.all(3),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             new Estatistica().jogosPontos(
                //                 int.parse(_valoresJogosEPontos[0]),
                //                 int.parse(_valoresJogosEPontos[1]),
                //                 0),
                //             Padding(
                //               padding: EdgeInsets.all(3),
                //             ),
                //             new Estatistica().jogosPontos(
                //                 int.parse(_valoresJogosEPontos[2]),
                //                 int.parse(_valoresJogosEPontos[3]),
                //                 1),
                //             Padding(
                //               padding: EdgeInsets.all(3),
                //             ),
                //             new Estatistica().jogosPontos(
                //                 int.parse(_valoresJogosEPontos[4]),
                //                 int.parse(_valoresJogosEPontos[5]),
                //                 2),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

              ],
            ));
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              double _tam = 90;
              List<RespostaModel> estatisticas = snapshot.data!;
              RespostaModel resultado = estatisticas[0];
              _valoresJogosEPontos = resultado.resposta!.split("#");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: 30,
                  ),
                  new Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Text(
                        "JOGOS",
                        style: TextStyle(
                          color:  AppColors.colorTextTitlesDash,
                          fontSize: 16,
                          fontFamily: FontFamily.fontSpecial,
                        ),
                      )),
                  new Container(
                    height: 20,
                  ),
                  new Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Text(
                        "Ano",
                        style: TextStyle(
                          color:  AppColors.colorTextTitlesDash,
                          fontSize: 14,
                          fontFamily: FontFamily.fontSpecial,
                        ),
                      )),
                  new Container(
                    height: 10,
                  ),
                  new Container(
                    height: 170,
                    child: new ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      children: [
                        new Estatistica().jogosPontos(
                            int.parse(_valoresJogosEPontos[0]),
                            int.parse(_valoresJogosEPontos[1]),
                            0,
                            true),
                        new Estatistica().jogosPontos(
                            int.parse(_valoresJogosEPontos[2]),
                            int.parse(_valoresJogosEPontos[3]),
                            1,
                            true),
                        new Estatistica().jogosPontos(
                            int.parse(_valoresJogosEPontos[4]),
                            int.parse(_valoresJogosEPontos[5]),
                            2,
                            true),
                      ],
                    ),
                  ),
                  new Container(
                    height: 30,
                  ),
                  new Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Text(
                        "PONTOS",
                        style: TextStyle(
                          color:  AppColors.colorTextTitlesDash,
                          fontSize: 16,
                          fontFamily: FontFamily.fontSpecial,
                        ),
                      )),
                  new Container(
                    height: 20,
                  ),
                  new Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Ano",
                      style: TextStyle(
                        color:  AppColors.colorTextTitlesDash,
                        fontSize: 14,
                        fontFamily: FontFamily.fontSpecial,
                      ),
                    ),
                  ),
                  new Container(
                    height: 10,
                  ),
                  new Container(
                    height: 170,
                    child: new ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      children: [
                        new Estatistica().jogosPontos(
                            int.parse(_valoresJogosEPontos[6]),
                            int.parse(_valoresJogosEPontos[7]),
                            0,
                            false),
                        new Estatistica().jogosPontos(
                            int.parse(_valoresJogosEPontos[8]),
                            int.parse(_valoresJogosEPontos[9]),
                            1,
                            false),
                        new Estatistica().jogosPontos(
                            int.parse(_valoresJogosEPontos[10]),
                            int.parse(_valoresJogosEPontos[11]),
                            2,
                            false),
                      ],
                    ),
                  ),

                  // Container(
                  //   //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  //   decoration: const BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: const BorderRadius.only(
                  //       topLeft: Radius.circular(8.0),
                  //       topRight: Radius.circular(8.0),
                  //     ),
                  //   ),
                  //   child: Center(
                  //     child: Column(
                  //       children: <Widget>[
                  //         Padding(
                  //           padding: EdgeInsets.all(3),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             new Estatistica().jogosPontos(
                  //                 int.parse(_valoresJogosEPontos[0]),
                  //                 int.parse(_valoresJogosEPontos[1]),
                  //                 0),
                  //             Padding(
                  //               padding: EdgeInsets.all(3),
                  //             ),
                  //             new Estatistica().jogosPontos(
                  //                 int.parse(_valoresJogosEPontos[2]),
                  //                 int.parse(_valoresJogosEPontos[3]),
                  //                 1),
                  //             Padding(
                  //               padding: EdgeInsets.all(3),
                  //             ),
                  //             new Estatistica().jogosPontos(
                  //                 int.parse(_valoresJogosEPontos[4]),
                  //                 int.parse(_valoresJogosEPontos[5]),
                  //                 2),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                ],
              );
            } else {
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
