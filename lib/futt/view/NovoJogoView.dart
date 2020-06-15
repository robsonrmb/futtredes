import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
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

  _cadastraJogo() async {
    try {
      _mensagem = "";
      if (_controllerEmailJogador1.text == "") {
        throw Exception('Informe o email dos jogadores.');
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

    _controllerEmailJogador1.text = "robson.rmb@gmail.com";
    _controllerEmailJogador2.text = "lucas@gmail.com";
    _controllerEmailJogador3.text = "pedro@gmail.com";
    _controllerEmailJogador4.text = "iuca@gmail.com";

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
            child: Column(
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
