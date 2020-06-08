import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/ResultadoModel.dart';
import 'package:futt/futt/service/ResultadoService.dart';

class ResultadoTorneioSubView extends StatefulWidget {

  int idTorneio;
  ResultadoTorneioSubView(this.idTorneio);

  @override
  _ResultadoTorneioSubViewState createState() => _ResultadoTorneioSubViewState();
}

class _ResultadoTorneioSubViewState extends State<ResultadoTorneioSubView> {

  Future<List<ResultadoModel>> _listaResultados() async {
    ResultadoService resultadoService = ResultadoService();
    return resultadoService.listaResultadoDoTorneio(widget.idTorneio, ConstantesConfig.SERVICO_FIXO);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ResultadoModel>>(
      future: _listaResultados(),
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

                  List<ResultadoModel> resultados = snapshot.data;
                  ResultadoModel resultado = resultados[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${resultado.fotoJogador1}'),
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
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              " ${resultado.nomeJogador1} e ${resultado.nomeJogador2}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*
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
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "  ${resultado.apelidoJogador1} e ${resultado.apelidoJogador2}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),*/
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage('${resultado.fotoJogador2}'),
                              radius: 30.0,
                            ),
                            /*
                            GestureDetector(
                              child: Icon(Icons.flight_land),
                              onTap: (){},
                            ),
                            GestureDetector(
                              child: Icon(Icons.flight_takeoff),
                              onTap: (){
                                Navigator.pushNamed(context, "/novo_torneio");
                              },
                            ),*/
                          ]),
                    ),
                  );
                },
                /*
                separatorBuilder: (context, index) => Divider(
                  height: 3,
                  color: Colors.amber,
                ),*/
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

