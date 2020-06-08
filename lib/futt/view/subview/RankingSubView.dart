import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/RankingModel.dart';
import 'package:futt/futt/service/RankingService.dart';

class RankingSubView extends StatefulWidget {

  int ano;
  int idRankingEntidade;
  int anoDefault;
  int idRankingEntidadeDefault;
  RankingSubView(this.ano, this.idRankingEntidade, this.anoDefault, this.idRankingEntidadeDefault);

  @override
  _RankingSubViewState createState() => _RankingSubViewState();
}

class _RankingSubViewState extends State<RankingSubView> {

  Future<List<RankingModel>> _listaRanking() async {
    if (widget.ano == 0 || widget.idRankingEntidade == 0) {
      RankingService rankingService = RankingService();
      return rankingService.listaRanking(
          widget.anoDefault, widget.idRankingEntidadeDefault,
          ConstantesConfig.SERVICO_FIXO);
    }else{
      RankingService rankingService = RankingService();
      return rankingService.listaRanking(
          widget.ano, widget.idRankingEntidade,
          ConstantesConfig.SERVICO_FIXO);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RankingModel>>(
      future: _listaRanking(),
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {

                  List<RankingModel> ranking = snapshot.data;
                  RankingModel resultado = ranking[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${resultado.fotoUsuario}'),
                        radius: 30.0,
                      ),
                      title: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff093352),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                " ${index+1} ",
                                style: TextStyle(
                                  fontFamily: 'Candal',
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              " ${resultado.nomeUsuario}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                " ${index+1} ",
                                style: TextStyle(
                                  fontFamily: 'Candal',
                                  color: Colors.grey[300],
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "  ${resultado.apelidoUsuario}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff093352),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  " ${resultado.pontuacao} ",
                                  style: TextStyle(
                                    fontFamily: 'Candal',
                                    color: Colors.orange,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  );
                },
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
