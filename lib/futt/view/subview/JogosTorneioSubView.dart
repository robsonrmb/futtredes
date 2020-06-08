import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/JogoModel.dart';
import 'package:futt/futt/model/TorneioModel.dart';
import 'package:futt/futt/service/JogoService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogosTorneioSubView extends StatefulWidget {

  int idTorneio;
  int idFase;
  bool editaPlacar;
  JogosTorneioSubView(this.idTorneio, this.idFase, this.editaPlacar);

  @override
  _JogosTorneioSubViewState createState() => _JogosTorneioSubViewState();
}

class _JogosTorneioSubViewState extends State<JogosTorneioSubView> {

  TextEditingController _controllerPontuacao1 = TextEditingController();
  TextEditingController _controllerPontuacao2 = TextEditingController();
  bool _atualizaJogos = false;
  String _mensagem = "";

  Future<List<JogoModel>> _listaJogos(_atualizaJogos) async {
    JogoService jogoService = JogoService();
    return jogoService.listaPorTorneios(widget.idTorneio, widget.idFase, _atualizaJogos, ConstantesConfig.SERVICO_FIXO);
  }

  _atualizaPlacar(int idJogo, int idNumeroJogo) async {
    try {
      JogoModel jogoModel = JogoModel.NovoPlacar(idJogo, idNumeroJogo, int.parse(_controllerPontuacao1.text), int.parse(_controllerPontuacao2.text));

      var _url = "${ConstantesRest.URL_JOGO}/atualizaplacar";
      var _dados = jogoModel.toJsonNovoPlacar();

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
          _atualizaJogos = true;
        });

        _mensagem = "Placar atualizado com sucesso!!!";

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
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "",
        onPressed: () {
          // Codigo para desfazer alteração
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  _informaCampeoes(int idTorneio, int idJogo, int numeroJogo, int idFase,
                   int idJogador1, int idJogador2, int idJogador3, int idJogador4,
                   int pontuacao1, int pontuacao2) async {

    try {
      TorneioModel tm;
      var _url = "";
      if (idFase == 13) { //terceiro lugar
        tm = TorneioModel.Terceiro(idJogador1, idJogador2);
        if (pontuacao2 > pontuacao1) {
          tm = TorneioModel.Terceiro(idJogador3, idJogador4);
        }
        _url = "${ConstantesRest.URL_TORNEIOS}/informaterceirolugar";

      }else{ //campeão
        tm = TorneioModel.Campeoes(idJogador1, idJogador2, idJogador3, idJogador4);
        if (pontuacao2 > pontuacao1) {
          tm = TorneioModel.Campeoes(idJogador3, idJogador4, idJogador1, idJogador2);
        }
        _url = "${ConstantesRest.URL_TORNEIOS}/informacampeoes";
      }
      //enviar dados.
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      http.Response response = await http.post(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: _dados
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (idFase == 13) { //terceiro lugar
          _mensagem = "Gravaçao de 3º lugar com sucesso!!!";
        }else{
          _mensagem = "Gravação do 1º e 2º lugar com sucesso!!!";
        }

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
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "",
        onPressed: () {
          // Codigo para desfazer alteração
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JogoModel>>(
      future: _listaJogos(_atualizaJogos),
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

                  List<JogoModel> paticipantes = snapshot.data;
                  JogoModel jogo = paticipantes[index];

                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: Container(
                        height: 40, width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff093352),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${jogo.pontuacao1}",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ]
                        ),
                      ),
                      title: Row(
                        children: <Widget>[
                          Text(
                            "${jogo.nomeJogador1} e ${jogo.nomeJogador2}",
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
                            "${jogo.nomeJogador3} e ${jogo.nomeJogador4}",
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
                            Container(
                              height: 40, width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff093352),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${jogo.pontuacao2}",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                            widget.editaPlacar == true ? new GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(Icons.edit,
                                  //color: Colors.black
                                ),
                              ),
                              onTap: (){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Informe o placar"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Pontuação (${jogo.nomeJogador1}/${jogo.nomeJogador2})",
                                            ),
                                            maxLength: 2,
                                            controller: _controllerPontuacao1,
                                          ),
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Pontuação (${jogo.nomeJogador3}/${jogo.nomeJogador4})",
                                            ),
                                            maxLength: 2,
                                            controller: _controllerPontuacao2,
                                          ),
                                          RaisedButton(
                                            color: Color(0xff086ba4),
                                            textColor: Colors.white,
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              "Atualiza placar",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Candal',
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            onPressed: () {
                                              _atualizaPlacar(jogo.id, jogo.numero);
                                            },
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
                            ) : new Padding(
                                padding: EdgeInsets.all(1),
                            ),
                            (widget.editaPlacar == true && (widget.idFase == 13 || widget.idFase == 14)) ? new GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.star,
                                  //color: Colors.black
                                ),
                              ),
                              onTap: (){
                                _informaCampeoes(widget.idTorneio, jogo.id, jogo.numero, widget.idFase,
                                                 jogo.idJogador1, jogo.idJogador2, jogo.idJogador3, jogo.idJogador4,
                                                 jogo.pontuacao1, jogo.pontuacao2);
                              },
                            ) : new Padding(
                              padding: EdgeInsets.all(1),
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
