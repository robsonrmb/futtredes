import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/PaisService.dart';
import 'package:futt/futt/view/MensalidadeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResponsaveisRedeView extends StatefulWidget {

  RedeModel redeModel;
  ResponsaveisRedeView({this.redeModel});

  @override
  _ResponsaveisRedeViewState createState() => _ResponsaveisRedeViewState();
}

class _ResponsaveisRedeViewState extends State<ResponsaveisRedeView> {

  String _mensagem = "";
  TextEditingController _controllerResponsavel = TextEditingController();
  TextEditingController _controllerSubResponsavel1 = TextEditingController();
  TextEditingController _controllerSubResponsavel2 = TextEditingController();
  TextEditingController _controllerSubResponsavel3 = TextEditingController();

  String _tituloSub1 = "Subresponsável da rede";
  String _tituloSub2 = "Subresponsável da rede";
  String _tituloSub3 = "Subresponsável da rede";

  _atualizaResponsaveis() async {
    try {
      _mensagem = "";
      if (_controllerResponsavel.text == "") {
        throw Exception('Informe ao menos o responsável principal da rede.');
      }

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      RedeModel redeModel = RedeModel.Responsaveis(
        widget.redeModel.id, _controllerResponsavel.text,
        _controllerSubResponsavel1.text, _controllerSubResponsavel2.text, _controllerSubResponsavel3.text,
      );

      var _url = "${ConstantesRest.URL_REDE}/atualizaresponsaveis";
      var _dados = redeModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Responsáveis da rede atualizada com sucesso!!!";
        });

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);

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

  _atualizaValoresIniciais(RedeModel redeOrigem) {
    _controllerResponsavel.text = redeOrigem.emailResponsavelRede;
    _controllerSubResponsavel1.text = redeOrigem.emailResponsavelJogos1;
    _controllerSubResponsavel2.text = redeOrigem.emailResponsavelJogos2;
    _controllerSubResponsavel3.text = redeOrigem.emailResponsavelJogos3;

    if (redeOrigem.responsavelJogos1 != 0) {
      _tituloSub1 = redeOrigem.nomeResponsavelJogos1;
    }
    if (redeOrigem.responsavelJogos2 != 0) {
      _tituloSub2 = redeOrigem.nomeResponsavelJogos2;
    }
    if (redeOrigem.responsavelJogos3 != 0) {
      _tituloSub3 = redeOrigem.nomeResponsavelJogos3;
    }
  }

  @override
  Widget build(BuildContext context) {

    _atualizaValoresIniciais(widget.redeModel);

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
        title: Text("Responsáveis da rede"),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orangeAccent,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: Text("Informe o email do responsável",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Candal'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Text("Responsável: ROBSON MELO DE BRITO",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Text("Indique até 3 subresponsáveis.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
                      labelText: "Responsável da rede",
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
                    controller: _controllerResponsavel,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Subresponsável da rede",
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
                    controller: _controllerSubResponsavel1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Subresponsável da rede",
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
                    controller: _controllerSubResponsavel2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Subresponsável da rede",
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
                    controller: _controllerSubResponsavel3,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orangeAccent,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text("Os subresponsáveis podem cadastrar:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Text("JOGOS, PLACARES, PARTICIPANTES, ENTRE OUTROS.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
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
      bottomNavigationBar: widget.redeModel.status == 2 ? BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.grey[300],
          child: RaisedButton(
            color: Color(0xff086ba4),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "Atualiza",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () {
              _atualizaResponsaveis();
            },
          ),
        ),
      ) : null,
    );
  }
}
