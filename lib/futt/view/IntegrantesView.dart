import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/view/subview/IntegrantesSubView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntegrantesView extends StatefulWidget {

  RedeModel redeModel;
  bool donoRede;
  IntegrantesView({this.redeModel, this.donoRede});

  @override
  _IntegrantesViewState createState() => _IntegrantesViewState();
}

class _IntegrantesViewState extends State<IntegrantesView> {

  int _inclui = 0;
  String _mensagem = "";
  TextEditingController _controllerEmail = TextEditingController();

  _adicionaIntegrante() async {
    try {
      if (_controllerEmail.text == "") {
        setState(() {
          _mensagem = "Informe o email do atleta.";
        });
      }else{
        IntegranteModel integranteModel = IntegranteModel.Novo(widget.redeModel.id, _controllerEmail.text);

        var _url = "${ConstantesRest.URL_REDE}/adicionaintegrante";
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
          Navigator.pop(context);

        }else{
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          setState(() {
            _mensagem = exceptionModel.msg;
          });
        }
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff093352),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Integrantes"),
      ),
      floatingActionButton: widget.donoRede && (widget.redeModel.status == 1 || widget.redeModel.status == 2) ? FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _mensagem = "";
          _controllerEmail.text = "";
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Adicione um atleta"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      controller: _controllerEmail,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(_mensagem),
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
                      "Incluir",
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
                    _adicionaIntegrante();
                  },
                ),
              ],
            );
          });
        },
      ) : null,
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
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
            Expanded(
              child: IntegrantesSubView(widget.redeModel, widget.donoRede, _inclui),
            )
          ],
        ),
      ),
    );
  }
}
