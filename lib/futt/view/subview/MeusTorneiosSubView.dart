import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/TorneioModel.dart';
import 'package:futt/futt/service/TorneioService.dart';
import 'package:futt/futt/view/EdicaoTorneioView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/NovoParticipanteView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MeusTorneiosSubView extends StatefulWidget {
  @override
  _MeusTorneiosSubViewState createState() => _MeusTorneiosSubViewState();
}

class _MeusTorneiosSubViewState extends State<MeusTorneiosSubView> {

  String _mensagem = "";
  bool _atualizaTorneios = false;

  int _getIdSubView() {
    return 1;
  }

  Future<List<TorneioModel>> _listaMeusTorneios(_atualizaTorneios) async {
    TorneioService torneioService = TorneioService();
    return torneioService.listaMeusTorneios(ConstantesConfig.SERVICO_FIXO);
  }

  _processa(var _url, var _dados, String _mensagemDeSucesso) async {
    try {
      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }
      http.Response response = await http.put(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: _dados
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Navigator.pop(context);
        setState(() {
          _atualizaTorneios = true;
        });
        _mensagem = _mensagemDeSucesso;

      }else{
        setState(() {
          _mensagem = "Falha durante o processamento!!!";
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

    final snackbar = SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text("${_mensagem}",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      duration: Duration(seconds: 4),
      action: SnackBarAction(
        label: "",
        onPressed: () {
          // Codigo para desfazer alteração
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  _alteraStatus (int idTorneio) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/alterastatus";
    var _dados = "";
    _processa(_url, _dados, "Status do torneio alterado com sucesso!!!");
  }

  _resetTorneio (int idTorneio) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/reset";
    var _dados = "";
    _processa(_url, _dados, "Torneio reiniciado com sucesso!!!");
  }

  _finalizaJogos (int idTorneio) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/finalizajogos";
    var _dados = "";
    _processa(_url, _dados, "Status do torneio alterado com sucesso!!!");
  }

  _gravaRanking (int idTorneio) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/gravaranking";
    var _dados = "";
    _processa(_url, _dados, "Ranking gerado/atualizado com sucesso!!!");
  }

  _finalizaTorneio (int idTorneio) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/finaliza";
    var _dados = "";
    _processa(_url, _dados, "Torneio finalizado com sucesso!!!");
  }

  _desativa (int idTorneio) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idTorneio}/desativa";
    var _dados = "";
    _processa(_url, _dados, "Torneio desativado com sucesso!!!");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TorneioModel>>(
      future: _listaMeusTorneios(_atualizaTorneios),
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
                      child: ListTile(
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
                          "${torneio.getStatusFormatado()}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              torneio.status == 20 || torneio.status == 30  ? new GestureDetector(
                                child: Icon(Icons.person_add,
                                  //color: Colors.black
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => NovoParticipanteView(torneio.id),
                                  ));
                                },
                              ) : new Padding(
                                padding: EdgeInsets.all(1),
                              ),
                              torneio.status < 70 ? new GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(Icons.monetization_on,
                                    //color: Colors.black
                                  ),
                                ),
                                onTap: (){},
                              ) : new Padding(
                                padding: EdgeInsets.all(1),
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(torneio.status < 40 ? Icons.edit : Icons.remove_red_eye,
                                    //color: Colors.black
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => EdicaoTorneioView(torneioModel: torneio),
                                  ));
                                },
                              ),
                            ]
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => JogosView(idTorneio: torneio.id, nomeTorneio: torneio.nome, statusTorneio: torneio.status, idSubView: _getIdSubView(), editaPlacar: true),
                        ));
                      },
                      onLongPress: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("${torneio.nome}"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  torneio.status < 40 ? new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Alterar status",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _alteraStatus(torneio.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  torneio.status == 40 ? new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Resetar",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _resetTorneio(torneio.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  torneio.status == 40 ? new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Finalizar jogos",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _finalizaJogos(torneio.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  torneio.getStatusJogosFinalizadosComTorneiosAutomaticos() == 51 ? new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Gravar ranking",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _gravaRanking(torneio.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  torneio.getStatusJogosFinalizadosComTorneiosAutomaticos() == 52 ? new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Finalizar torneio",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _finalizaTorneio(torneio.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  torneio.status < 60 ? new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Desativar",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _desativa(torneio.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: RaisedButton(
                                  color: Color(0xff086ba4),
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "Fechar",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Candal',
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
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
