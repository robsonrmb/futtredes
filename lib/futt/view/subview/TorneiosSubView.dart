import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/TorneioModel.dart';
import 'package:futt/futt/service/TorneioService.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/ParticipantesView.dart';
import 'package:futt/futt/view/ResultadosView.dart';

class TorneiosSubView extends StatefulWidget {

  int indiceDeBusca;
  String nomeFiltro;
  String paisFiltro;
  String cidadeFiltro;
  String dataFiltro;
  TorneiosSubView(this.indiceDeBusca, this.nomeFiltro, this.paisFiltro, this.cidadeFiltro, this.dataFiltro);

  @override
  _TorneiosSubViewState createState() => _TorneiosSubViewState();
}

class _TorneiosSubViewState extends State<TorneiosSubView> {

  int _getIdSubView() {
    return 1;
  }

  Future<List<TorneioModel>> _listaTorneios() async {
    if (widget.indiceDeBusca == 0 || (widget.nomeFiltro == "" && widget.paisFiltro == "" && widget.cidadeFiltro == "" && widget.dataFiltro == "")) {
      TorneioService torneioService = TorneioService();
      return torneioService.listaTodos(ConstantesConfig.SERVICO_FIXO);
    }else{
      TorneioModel torneioModel = TorneioModel.Filtro(
        widget.nomeFiltro, widget.paisFiltro, widget.cidadeFiltro, widget.dataFiltro); //parametro cidade = local

      TorneioService torneioService = TorneioService();
      return torneioService.listaPorFiltros(torneioModel, ConstantesConfig.SERVICO_FIXO);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TorneioModel>>(
      future: _listaTorneios(),
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

                  List<TorneioModel> torneios = snapshot.data;
                  TorneioModel torneio = torneios[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      child:
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('${torneio.logoTorneio}'),
                            radius: 20.0,
                          ),
                          title: Row(
                            children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "${torneio.nome}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          subtitle: Text(
                            "${torneio.dataInicio}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                torneio.status >= 60 ? new GestureDetector(
                                  child: Icon(Icons.filter_1,
                                    //color: Colors.black
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ResultadosView(idTorneio: torneio.id,
                                                                                   nomeTorneio: torneio.nome,
                                                                                   paisTorneio: torneio.pais,
                                                                                   cidadeTorneio: torneio.cidade,
                                                                                   dataTorneio: torneio.dataInicio)
                                    ));
                                  },
                                ) : new Padding(
                                  padding: EdgeInsets.all(1),
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(Icons.people,
                                      //color: Colors.black,
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ParticipantesView(idTorneio: torneio.id,
                                          nomeTorneio: torneio.nome,
                                          paisTorneio: torneio.pais,
                                          cidadeTorneio: torneio.cidade,
                                          dataTorneio: torneio.dataInicio,
                                          statusTorneio: torneio.status,)
                                    ));
                                  },
                                ),
                              ]
                          ),
                        ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => JogosView(idTorneio: torneio.id, nomeTorneio: torneio.nome, idSubView: _getIdSubView(), editaPlacar: false),
                        ));
                      },
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
