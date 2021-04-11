import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/service/EstatisticaService.dart';
import 'package:futt/futt/view/components/Estatistica.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:shimmer/shimmer.dart';

class EstatisticasSequenciais extends StatefulWidget {
  int idUsuario;
  int idRede;

  EstatisticasSequenciais(this.idUsuario, this.idRede);

  @override
  _EstatisticasSequenciaisState createState() =>
      _EstatisticasSequenciaisState();
}

class _EstatisticasSequenciaisState extends State<EstatisticasSequenciais> {
  var _valoresSequenciais;

  Future<List<RespostaModel>> _getValoresSequenciais() {
    EstatisticaService estatisticaService = EstatisticaService();
    Future<List<RespostaModel>> respostas = estatisticaService.getSequenciais(
        widget.idUsuario, widget.idRede, ConstantesConfig.SERVICO_FIXO);
    return respostas;
  }

  Widget _retornaEstatistica(var _vs, int _indice,bool first) {
    return (_vs.length >= _indice + 1 && _vs[_indice] != "")
        ? new Estatistica().resultadoJogo(_vs[_indice],first)
        : new Container(
            padding: EdgeInsets.only(top: 1),
          );
  }

  Widget _retornaEstatisticaVazia(var _vs, int _indice,bool first) {
    return (_vs.length >= _indice + 1 && _vs[_indice] != "")
        ? new Padding(
            padding: EdgeInsets.all(3),
          )
        : new Padding(
            padding: EdgeInsets.only(top: 1),
          );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RespostaModel>>(
      future: _getValoresSequenciais(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new FadeAnimation(
              1.2,
              new Container(
                margin: const EdgeInsets.only(right: 8, left: 8, top: 4),
                child: new Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Últimos jogos",
                                style: TextStyle(
                                  color: AppColors.colorTextTitlesDash,
                                  fontSize: 16,
                                  fontFamily: FontFamily.fontSpecial,
                                ),
                              ),
                              Text(
                                "(Vitórias e Derrotas)",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.colorTextTitlesDash),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3),
                              ),
                              new Container(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 46,
                                        width: 46,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  new Container(
                                    width: 4,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 46,
                                        width: 46,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  new Container(
                                    width: 4,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 46,
                                        width: 46,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  new Container(
                                    width: 4,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 46,
                                        width: 46,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  new Container(
                                    width: 4,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 46,
                                        width: 46,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                  new Container(
                                    width: 4,
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 46,
                                        width: 46,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                ],
                              ),
                              new Container(
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
              _valoresSequenciais = resultado.resposta.split("#");

              if (_valoresSequenciais != "" && _valoresSequenciais[0] != "") {
                return new Container(
                  margin: const EdgeInsets.only(right: 8, left: 8, top: 4),
                  child: new Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Últimos jogos",
                                  style: TextStyle(
                                      color: AppColors.colorTextTitlesDash,
                                      fontSize: 16,
                                    fontFamily: FontFamily.fontSpecial,
                                  ),
                                ),
                                Text(
                                  "(Vitórias e Derrotas)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.colorTextTitlesDash),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3),
                                ),
                                new Container(
                                  height: 14,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _retornaEstatistica(
                                        this._valoresSequenciais, 0,true),
                                    _retornaEstatisticaVazia(
                                        this._valoresSequenciais, 0,true),
                                    new Container(
                                      width: 3,
                                    ),
                                    _retornaEstatistica(
                                        this._valoresSequenciais, 1,false),
                                    _retornaEstatisticaVazia(
                                        this._valoresSequenciais, 1,false),
                                    new Container(
                                      width: 3,
                                    ),
                                    _retornaEstatistica(
                                        this._valoresSequenciais, 2,false),
                                    _retornaEstatisticaVazia(
                                        this._valoresSequenciais, 2,false),
                                    new Container(
                                      width: 3,
                                    ),
                                    _retornaEstatistica(
                                        this._valoresSequenciais, 3,false),
                                    _retornaEstatisticaVazia(
                                        this._valoresSequenciais, 3,false),
                                    new Container(
                                      width: 3,
                                    ),
                                    _retornaEstatistica(
                                        this._valoresSequenciais, 4,false),
                                    _retornaEstatisticaVazia(
                                        this._valoresSequenciais, 4,false),
                                    new Container(
                                      width: 3,
                                    ),
                                    _retornaEstatistica(
                                        this._valoresSequenciais, 5,false),
                                  ],
                                ),
                                new Container(
                                  height: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return new Container(
                  margin: const EdgeInsets.only(right: 8, left: 8, top: 4),
                  child: new Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Últimos jogos",
                                  style: TextStyle(
                                      color: AppColors.colorTextTitlesDash,
                                      fontSize: 16,
                                    fontFamily: FontFamily.fontSpecial,
                                  ),
                                ),
                                new Container(
                                  height: 4,
                                ),
                                Text(
                                  "Sem Valores",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.colorTextTitlesDash),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "ÚLTIMOS JOGOS",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                            ),
                            Text("Sem valores"),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "ÚLTIMOS JOGOS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorTextTitlesDash),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                          ),
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
        return null;
      },
    );
  }
}
