import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ParticipanteModel.dart';
import 'package:futt/futt/service/ParticipanteService.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParticipantesSubView extends StatefulWidget {

  int idRede;
  bool donoRede;
  int inclui;
  ParticipantesSubView(this.idRede, this.donoRede, this.inclui);

  @override
  _ParticipantesSubViewState createState() => _ParticipantesSubViewState();
}

class _ParticipantesSubViewState extends State<ParticipantesSubView> {

  String _mensagem = "";

  Future<List<ParticipanteModel>> _listaParticipantes(int lista) async {
    ParticipanteService resultadoService = ParticipanteService();
    return resultadoService.listaParticipantesDaRede(widget.idRede, ConstantesConfig.SERVICO_FIXO, lista);
  }

  _showModalRemoveParticipante(BuildContext context, int idRede, int idParticipante){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Remove participante da rede"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Deseja realmente remover o participante?"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _remove(context, idRede, idParticipante, false),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _remove(context, idRede, idParticipante, true),
                child: Text("Sim"),
              )
            ],
          );
        }
    );
  }

  _remove(BuildContext context, int idRede, int idParticipante, bool resposta) async {
    if (resposta) {
      _removendo(context, idRede, idParticipante);
      Navigator.pop(context);
      /*
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waiting(context, "Remove participante", "Participante excluído com sucesso!!!");
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      */

    }else{
      Navigator.pop(context);
    }
  }

  _removendo(BuildContext context, int idRede, int idParticipante) async {
    try {
      String _msg = "";
      //RedeService redeService = RedeService();
      //redeService.inclui(redeModel, ConstantesConfig.SERVICO_FIXO);

      var _url = "${ConstantesRest.URL_REDE}/${idRede}/removeintegrante";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      http.Response response = await http.put(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: _dados
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _msg = "Participante excluído!!!";
        _listaParticipantes(1);
      }else{
        _msg = "Falha durante o processamento!!!";
      }
      setState(() {
        _mensagem = _msg;
      });

    } on Exception catch (exception) {
      print(exception.toString());
      setState(() {
        _mensagem = exception.toString();
      });
    } catch (error) {
      setState(() {
        _mensagem = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParticipanteModel>>(
      future: _listaParticipantes(widget.inclui),
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
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                            widget.donoRede ? new GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: (){
                                _showModalRemoveParticipante(context, widget.idRede, participante.idUsuario);
                              },
                            ) : new Padding(
                              padding: EdgeInsets.all(1),
                            ),
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

