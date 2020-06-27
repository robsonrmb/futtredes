import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RankingModel.dart';
import 'package:futt/futt/service/RankingService.dart';
import 'package:futt/futt/view/EstatisticasAtletasView.dart';

class RankingSubView extends StatefulWidget {

  int idRede;
  int ano;
  int tipo;
  RankingSubView(this.idRede, this.ano, this.tipo);

  @override
  _RankingSubViewState createState() => _RankingSubViewState();
}

class _RankingSubViewState extends State<RankingSubView> {

  Future<List<RankingModel>> _listaRanking() async {
    RankingService rankingService = RankingService();
    int ano = widget.ano;
    if (ano == 0) {
      var now = new DateTime.now();
      ano = now.year;
    }
    return rankingService.listaRankingRede(widget.idRede, widget.ano, widget.tipo, ConstantesConfig.SERVICO_FIXO);
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
                        backgroundImage: NetworkImage(ConstantesRest.URL_BASE_AMAZON + resultado.fotoUsuario),
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
                              " ${resultado.getApelidoFormatado()}",
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
                          /*Text(
                            "  ${resultado.getNomeFormatado()}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),*/
                        ],
                      ),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                //color: Color(0xff093352),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  " ${resultado.pontuacao} ",
                                  style: TextStyle(
                                    fontFamily: 'Candal',
                                    color: Color(0xff093352),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Icon(Icons.insert_chart),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => EstatisticasAtletasView(resultado.idUsuario, widget.idRede, resultado.nomeUsuario, resultado.fotoUsuario),
                                ));
                              },
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
