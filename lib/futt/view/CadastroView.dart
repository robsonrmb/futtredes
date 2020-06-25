import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/CadastroLoginModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroView extends StatefulWidget {
  @override
  _CadastroViewState createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {

  String _mensagem = "";
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerSenhaConfirmacao = TextEditingController();

  void _cadastrar() async {
    try {
      _mensagem = "";
      CadastroLoginModel cadastroLoginModel = CadastroLoginModel();
      cadastroLoginModel.email = _controllerEmail.text;
      cadastroLoginModel.senha = _controllerSenha.text;
      cadastroLoginModel.nome = _controllerNome.text;

      if (_controllerNome.text == "") {
        _mensagem = "Informe seu nome!!!";

      }else if (_controllerEmail.text == "") {
        _mensagem = "Informe seu email!!!";

      }else if (_controllerSenha.text == "") {
        _mensagem = "Informe a senha!!!";

      }else if (_controllerSenhaConfirmacao.text == "") {
        _mensagem = "Confirme a senha!!!";

      }else if (_controllerSenha.text != _controllerSenhaConfirmacao.text) {
        _mensagem = "Confirme a senha corretamente!!!";
      }

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      var _url = "${ConstantesRest.URL_USUARIOS}";
      var _dados = cadastroLoginModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      http.Response response = await http.post(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 201) {
        Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));

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

  void _voltar() {
    Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
            "Tela de cadastro",
            style: TextStyle(
              color: Colors.white
            ),
        ),
        backgroundColor: Color(0xff086ba4),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/fundo.jpg"),
                fit: BoxFit.fill
            )
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Image.asset("images/logoFuttRedes.png", height: 60, width: 15),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xff086ba4).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            width: 1.0
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                              ),
                              // icon: new Icon(Icons.person),
                              // prefixText: "Nome",
                              // prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                              // labelText: "Informe seu nome",
                              hintText: "Nome",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            //maxLength: 5,
                            //maxLengthEnforced: true,
                            controller: _controllerNome,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            controller: _controllerEmail,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: "Senha",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            obscureText: true,
                            controller: _controllerSenha,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: "Confirmação da senha",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            obscureText: true,
                            controller: _controllerSenhaConfirmacao,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: RaisedButton(
                            color: Color(0xff2c7ce7),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Candal',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            onPressed: _cadastrar,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: RaisedButton(
                            color: Colors.orange,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Já sou cadastrado",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Candal',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            onPressed: _voltar,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Center(
                            child: Text(
                              _mensagem,
                              style: TextStyle(
                                  color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
