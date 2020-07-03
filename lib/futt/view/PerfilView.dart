import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/view/subview/PerfilSubView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerfilView extends StatefulWidget {
  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {

  String _mensagem = "";
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfirmSenha = TextEditingController();

  _salvaNovaSenha() async {
    try {
      if (_controllerSenha.text == "" || _controllerConfirmSenha.text == "" || _controllerSenha.text != _controllerConfirmSenha.text) {
        setState(() {
          _mensagem = "Senha e confirmação da senha devem ser iguais.";
        });
      }else{
        final prefs = await SharedPreferences.getInstance();
        String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);
        String email = await prefs.getString(ConstantesConfig.PREFERENCES_EMAIL);

        UsuarioModel usuarioModel = UsuarioModel.AtualizaSenha(email, _controllerSenha.text, _controllerSenha.text);

        var _url = "${ConstantesRest.URL_USUARIOS}/atualizaSenha";
        var _dados = usuarioModel.toJson();

        if (ConstantesConfig.SERVICO_FIXO == true) {
          _url = "https://jsonplaceholder.typicode.com/posts";
          _dados = jsonEncode({
            'userId': 1,
            'id': 200,
            'title': 'Título',
            'body': 'Corpo da mensagem'
          });
        }

        http.Response response = await http.put(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token,
            },
            body: jsonEncode(_dados)
        );

        if (response.statusCode == 204) {
          setState(() {
            _mensagem = "Senha alterada com sucesso!!!";
          });
          Navigator.pop(context);
        } else {
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
        title: Text("Perfil"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.lock_outline),
        onPressed: () {
          _mensagem = "";
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Alteração de senha"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nova senha",
                      ),
                      obscureText: true,
                      controller: _controllerSenha,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Confirmação da nova senha",
                      ),
                      obscureText: true,
                      controller: _controllerConfirmSenha,
                    ),
                    Text(_mensagem,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Candal',
                        color: Colors.blue,
                      ),
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
                      "Alterar",
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
                    _salvaNovaSenha();
                  },
                ),
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
      body: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PerfilSubView(),
            )
          ],
        ),
      ),
    );
  }
}
