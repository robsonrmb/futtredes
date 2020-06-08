import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/AvaliacaoModel.dart';
import 'package:futt/futt/service/AvaliacaoService.dart';
import 'package:futt/futt/view/NovaAvaliacaoView.dart';
import 'package:flutter/material.dart';

class AvaliacoesSubView extends StatefulWidget {

  @override
  _AvaliacoesSubViewState createState() => _AvaliacoesSubViewState();
}

class _AvaliacoesSubViewState extends State<AvaliacoesSubView> {

  Future<List<AvaliacaoModel>> _listaAvaliacoesPendentes() async {
    AvaliacaoService resultadoService = AvaliacaoService();
    return resultadoService.listaRecebidasPendentes(1, ConstantesConfig.SERVICO_FIXO);
  }

  _avaliar(int idAvaliacao) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NovaAvaliacaoView(idAvaliacao)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AvaliacaoModel>>(
      future: _listaAvaliacoesPendentes(),
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

                  List<AvaliacaoModel> avaliacoes = snapshot.data;
                  AvaliacaoModel avaliacao = avaliacoes[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${avaliacao.fotoAvaliado}'),
                        radius: 30.0,
                      ),
                      title: Row(
                        children: <Widget>[
                          Text(
                            "${avaliacao.nomeAvaliado}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(Icons.star_half),
                              onTap: (){
                                _avaliar(avaliacao.id);
                              },
                            ),
                            /*
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
