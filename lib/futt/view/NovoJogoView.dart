import 'dart:collection';

import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/IntegranteService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/SearchDelegateUsuariosDaRede.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovoJogoView extends StatefulWidget {

  RedeModel redeModel;
  NovoJogoView(this.redeModel);

  @override
  _NovoJogoViewState createState() => _NovoJogoViewState();
}

class _NovoJogoViewState extends State<NovoJogoView> {

  String _mensagem = "";
  TextEditingController _controllerEmailJogador1 = TextEditingController();
  TextEditingController _controllerEmailJogador2 = TextEditingController();
  TextEditingController _controllerEmailJogador3 = TextEditingController();
  TextEditingController _controllerEmailJogador4 = TextEditingController();
  String _resultadoJogador1 = "";
  String _resultadoJogador2 = "";
  String _resultadoJogador3 = "";
  String _resultadoJogador4 = "";
  Future<List<IntegranteModel>> _integrantes;

  Future<List<IntegranteModel>> _listaIntegrantes() async {
    IntegranteService resultadoService = IntegranteService();
    return resultadoService.listaIntegrantesDaRede(widget.redeModel.id, ConstantesConfig.SERVICO_FIXO, 0); //0 para retorno fixo (jogar fora)
  }

  String _buscaEmailDaLista(String valor, List<IntegranteModel> lista) {
    String retorno = "";
    for (IntegranteModel _im in lista) {
      if (_im.nome == valor) {
        retorno = _im.email;
        break;
      }
    }
    return retorno;
  }

  _cadastraJogo() async {
    try {
      _mensagem = "";
      if (_controllerEmailJogador1.text == "") {
        _mensagem = 'Informe o email dos jogadores.';
      }
      HashMap<String, String> hashMap = new HashMap<String, String>();
      Map<String, String> map = {
        _controllerEmailJogador1.text: '_controllerEmailJogador1.text',
        _controllerEmailJogador2.text: '_controllerEmailJogador2.text',
        _controllerEmailJogador3.text: '_controllerEmailJogador3.text',
        _controllerEmailJogador4.text: '_controllerEmailJogador4.text',
      };
      if (map.length < 4) {
        _resultadoJogador1 = _controllerEmailJogador1.text;
        _resultadoJogador2 = _controllerEmailJogador2.text;
        _resultadoJogador3 = _controllerEmailJogador3.text;
        _resultadoJogador4 = _controllerEmailJogador4.text;
        _mensagem = 'Atleta duplicado. Confira os jogos!!!';
      }

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      JogoRedeModel jogoRedeModel = JogoRedeModel.NovoJogo(
        widget.redeModel.id, 0, 0, _controllerEmailJogador1.text,
        _controllerEmailJogador2.text, _controllerEmailJogador3.text, _controllerEmailJogador4.text,
      );

      var _url = "${ConstantesRest.URL_JOGO_REDE}/adicionaporemail";
      var _dados = jogoRedeModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
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
          _mensagem = "Jogo incluído com sucesso!!!";
        });

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Jogo", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);

      }else{
        var _dadosJson = jsonDecode(response.body);
        ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
        setState(() {
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

  @override
  Widget build(BuildContext context) {

    _controllerEmailJogador1.text = _resultadoJogador1;
    _controllerEmailJogador2.text = _resultadoJogador2;
    _controllerEmailJogador3.text = _resultadoJogador3;
    _controllerEmailJogador4.text = _resultadoJogador4;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        backgroundColor: Color(0xff093352),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Cadastro de jogos"),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<IntegranteModel>>(
                future: _listaIntegrantes(),
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

                        List<IntegranteModel> integrantes = snapshot.data;
                        List<String> _integrantes = List();

                        for (IntegranteModel _im in integrantes) {
                          _integrantes.add(_im.nome);
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              decoration: BoxDecoration(
                                /*image: DecorationImage(
                                        image: NetworkImage('${ConstantesRest.URL_BASE_AMAZON}semImagem.png'),
                                        fit: BoxFit.cover
                                    ),*/
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[400],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                                    child: Text("${widget.redeModel.nome}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Candal',
                                          color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xff1D691D) : Colors.grey[800]
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 1),
                                    child: Text("${widget.redeModel.pais} - ${widget.redeModel.cidade}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xff1D691D) : Colors.grey[800]
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                    child: Text("${widget.redeModel.local}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Color(0xff093352): Color(0xff1D691D) : Colors.grey[800]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: GestureDetector(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Email do jogador 1",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    border: OutlineInputBorder(
                                      gapPadding: 10,
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  controller: _controllerEmailJogador1,
                                ),
                                onDoubleTap: () async {
                                  String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                                  valor = _buscaEmailDaLista(valor, integrantes);
                                  setState(() {
                                    _resultadoJogador1 = valor;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: GestureDetector(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Email do jogador 2",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    border: OutlineInputBorder(
                                      gapPadding: 10,
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  controller: _controllerEmailJogador2,
                                ),
                                onDoubleTap: () async {
                                  String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                                  valor = _buscaEmailDaLista(valor, integrantes);
                                  setState(() {
                                    _resultadoJogador2 = valor;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 40, width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("X",
                                        style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey[800]
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: GestureDetector(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Email do jogador 3",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    border: OutlineInputBorder(
                                      gapPadding: 10,
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  controller: _controllerEmailJogador3,
                                ),
                                onDoubleTap: () async {
                                  String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                                  valor = _buscaEmailDaLista(valor, integrantes);
                                  setState(() {
                                    _resultadoJogador3 = valor;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: GestureDetector(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Email do jogador 4",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    border: OutlineInputBorder(
                                      gapPadding: 10,
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  controller: _controllerEmailJogador4,
                                ),
                                onDoubleTap: () async {
                                  String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                                  valor = _buscaEmailDaLista(valor, integrantes);
                                  setState(() {
                                    _resultadoJogador4 = valor;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Center(
                                child: Text(
                                  _mensagem,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Candal'
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }else{
                        return Center(
                          child: Text("Sem valores!!!"),
                        );
                      }
                      break;
                  }
                },
              ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.grey[300],
          child: widget.redeModel.status == 1 || widget.redeModel.status == 2 ? RaisedButton(
            color: Color(0xff086ba4),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "Cadastrar jogo",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () {
              _cadastraJogo();
            },
          ) : RaisedButton(
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "REDE FECHADA OU DESATIVADA",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
