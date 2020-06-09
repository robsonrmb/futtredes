import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/EdicaoRedeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/NovoParticipanteView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MinhasRedesSubView extends StatefulWidget {
  @override
  _MinhasRedesSubViewState createState() => _MinhasRedesSubViewState();
}

class _MinhasRedesSubViewState extends State<MinhasRedesSubView> {

  String _mensagem = "";
  bool _atualizaRedes = false;

  int _getIdSubView() {
    return 1;
  }

  Future<List<RedeModel>> _listaMinhasRedes(_atualizaRedes) async {
    RedeService redeService = RedeService();
    return redeService.listaMinhasRedes(ConstantesConfig.SERVICO_FIXO);
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
          _atualizaRedes = true;
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

  _alteraStatus (int idRede) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idRede}/alterastatus";
    var _dados = "";
    _processa(_url, _dados, "Status do rede alterado com sucesso!!!");
  }

  _resetRede (int idRede) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idRede}/reset";
    var _dados = "";
    _processa(_url, _dados, "Rede reiniciado com sucesso!!!");
  }

  _finalizaJogos (int idRede) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idRede}/finalizajogos";
    var _dados = "";
    _processa(_url, _dados, "Status do rede alterado com sucesso!!!");
  }

  _gravaRanking (int idRede) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idRede}/gravaranking";
    var _dados = "";
    _processa(_url, _dados, "Ranking gerado/atualizado com sucesso!!!");
  }

  _finalizaRede (int idRede) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idRede}/finaliza";
    var _dados = "";
    _processa(_url, _dados, "Rede finalizado com sucesso!!!");
  }

  _desativa (int idRede) {
    var _url = "${ConstantesRest.URL_TORNEIOS}/${idRede}/desativa";
    var _dados = "";
    _processa(_url, _dados, "Rede desativado com sucesso!!!");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RedeModel>>(
      future: _listaMinhasRedes(_atualizaRedes),
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

                  List<RedeModel> redes = snapshot.data;
                  RedeModel rede = redes[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('${rede.nomeFoto}'),
                          radius: 20.0,
                        ),
                        title: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "${rede.nome}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          "${rede.getStatusFormatado()}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              rede.status == 20 || rede.status == 30  ? new GestureDetector(
                                child: Icon(Icons.person_add,
                                  //color: Colors.black
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => NovoParticipanteView(rede.id),
                                  ));
                                },
                              ) : new Padding(
                                padding: EdgeInsets.all(1),
                              ),
                              rede.status < 70 ? new GestureDetector(
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
                                  child: Icon(rede.status < 40 ? Icons.edit : Icons.remove_red_eye,
                                    //color: Colors.black
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => EdicaoRedeView(redeModel: rede),
                                  ));
                                },
                              ),
                            ]
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => JogosView(idRede: rede.id, nomeRede: rede.nome, statusRede: rede.status, idSubView: _getIdSubView(), editaPlacar: true),
                        ));
                      },
                      onLongPress: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("${rede.nome}"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  rede.status < 40 ? new Padding(
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
                                        _alteraStatus(rede.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  rede.status == 40 ? new Padding(
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
                                        _resetRede(rede.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  rede.status == 40 ? new Padding(
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
                                        _finalizaJogos(rede.id);
                                      },
                                    ),
                                  ) : new Padding(
                                    padding: EdgeInsets.only(top: 1),
                                  ),
                                  new Padding(
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
                                        _gravaRanking(rede.id);
                                      },
                                    ),
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      color: Color(0xff086ba4),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Finalizar rede",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Candal',
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      onPressed: () {
                                        _finalizaRede(rede.id);
                                      },
                                    ),
                                  ),
                                  rede.status < 60 ? new Padding(
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
                                        _desativa(rede.id);
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
