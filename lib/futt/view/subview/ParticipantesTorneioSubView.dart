import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/ParticipanteModel.dart';
import 'package:futt/futt/service/ParticipanteService.dart';
import 'package:flutter/material.dart';

class ParticipantesTorneioSubView extends StatefulWidget {

  int idTorneio;
  ParticipantesTorneioSubView(this.idTorneio);

  @override
  _ParticipantesTorneioSubViewState createState() => _ParticipantesTorneioSubViewState();
}

class _ParticipantesTorneioSubViewState extends State<ParticipantesTorneioSubView> {

  Future<List<ParticipanteModel>> _listaParticipantes() async {
    ParticipanteService resultadoService = ParticipanteService();
    return resultadoService.listaParticipantesDoTorneio(widget.idTorneio, ConstantesConfig.SERVICO_FIXO);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParticipanteModel>>(
      future: _listaParticipantes(),
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

                  List<ParticipanteModel> participantes = snapshot.data;
                  ParticipanteModel participante = participantes[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${participante.nomeFoto}'),
                        radius: 30.0,
                      ),
                      title: Row(
                        children: <Widget>[
                          Text(
                            "${participante.nome}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                            "${participante.pais} - ${participante.cidade}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
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

