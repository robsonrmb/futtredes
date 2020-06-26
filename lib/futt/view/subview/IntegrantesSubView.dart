import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/IntegranteService.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/EstatisticasAtletasView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntegrantesSubView extends StatefulWidget {

  RedeModel redeModel;
  bool donoRede;
  int inclui;
  IntegrantesSubView(this.redeModel, this.donoRede, this.inclui);

  @override
  _IntegrantesSubViewState createState() => _IntegrantesSubViewState();
}

class _IntegrantesSubViewState extends State<IntegrantesSubView> {

  String _mensagem = "";

  Future<List<IntegranteModel>> _listaIntegrantes(int lista) async {
    IntegranteService resultadoService = IntegranteService();
    return resultadoService.listaIntegrantesDaRede(widget.redeModel.id, ConstantesConfig.SERVICO_FIXO, lista);
  }

  _showModalRemoveIntegrante(BuildContext context, int idIntegrante, int idRede){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Remove integrante da rede"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Deseja realmente remover o integrante?"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _remove(context, idRede, idIntegrante, false),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _remove(context, idRede, idIntegrante, true),
                child: Text("Sim"),
              )
            ],
          );
        }
    );
  }

  _remove(BuildContext context, int idRede, int idIntegrante, bool resposta) async {
    if (resposta) {
      _removendo(context, idRede, idIntegrante);
      Navigator.pop(context);

    }else{
      Navigator.pop(context);
    }
  }

  _removendo(BuildContext context, int idRede, int idAtleta) async {
    try {
      IntegranteModel integranteModel = IntegranteModel.Remove(idRede, idAtleta);

      var _url = "${ConstantesRest.URL_REDE}/removeintegrante";
      var _dados = integranteModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({ 'userId': 1, 'id': 200, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.post(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Atleta inserido com sucesso!!!";
        });

      }else{
        setState(() {
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          _mensagem = exceptionModel.msg;
        });
      }

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

  _retorneSubtitulo(String pais, String cidade) {
    if (pais == null && cidade == null) {
      return "";
    } else if (pais != null && cidade != null) {
      return pais + " - " + cidade;
    } else if (pais != null && cidade == null) {
      return pais;
    } else if (pais == null && cidade != null) {
      return cidade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IntegranteModel>>(
      future: _listaIntegrantes(widget.inclui),
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

                  List<IntegranteModel> integrantes = snapshot.data;
                  IntegranteModel integrante = integrantes[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${ConstantesRest.URL_BASE_AMAZON}${integrante.nomeFoto}'),
                        radius: 30.0,
                      ),
                      title: Row(
                        children: <Widget>[
                          Text(
                            "${integrante.nome}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(_retorneSubtitulo(integrante.pais, integrante.cidade),
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
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Icon(Icons.insert_chart),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => EstatisticasAtletasView(integrante.idUsuario, widget.redeModel.id, integrante.nome, integrante.nomeFoto),
                                ));
                              },
                            ),
                            widget.donoRede ? new GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(Icons.delete),
                              ),
                              onTap: (){
                                _showModalRemoveIntegrante(context, integrante.idUsuario, widget.redeModel.id);
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

