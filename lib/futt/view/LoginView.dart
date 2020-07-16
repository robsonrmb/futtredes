import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EmailModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/LoginModel.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String _mensagem = "";
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerEmailParaTrocaDeSenha = TextEditingController();
  TextEditingController _controllerAnoNascimentoParaTrocaDeSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
    _iniciar();
    _controllerEmail.text = "robson.rmb@gmail.com";
    _controllerSenha.text = "123";
    _controllerEmailParaTrocaDeSenha.text = "robson.rmb@gmail.com";
    _controllerAnoNascimentoParaTrocaDeSenha.text = "1978";
  }

  void _iniciar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String email = await prefs.getString(ConstantesConfig.PREFERENCES_EMAIL);
      String senha = await prefs.getString(ConstantesConfig.PREFERENCES_SENHA);

      if (email != null && senha != null && email != "" && senha != "") {
        _mensagem = "";
        LoginModel loginModel = LoginModel(_controllerEmail.text, _controllerSenha.text);

        var _url = "${ConstantesRest.URL_LOGIN}";
        var _dados = loginModel.toJson();

        if (ConstantesConfig.SERVICO_FIXO == true) {
          _url = "https://jsonplaceholder.typicode.com/posts";
          _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
        }

        http.Response response = await http.post(_url,
            headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
            body: jsonEncode(_dados)
        );

        if (response.statusCode == 200) {
          //Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(ConstantesConfig.PREFERENCES_EMAIL, _controllerEmail.text);
          await prefs.setString(ConstantesConfig.PREFERENCES_SENHA, _controllerSenha.text);
          await prefs.setString(ConstantesConfig.PREFERENCES_TOKEN, response.headers['authorization']);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
                (Route<dynamic> route) => false,
          );

        }else{
          setState(() {
            _mensagem = "";
          });
        }
      }
    } on Exception catch (exception) {
      setState(() {
        _mensagem = "";
      });
    } catch (error) {
      setState(() {
        _mensagem = "";
      });
    }
  }

  void _entrar() async {
    try {
      if (_controllerEmail.text != "" && _controllerSenha.text != "") {
        _mensagem = "";
        LoginModel loginModel = LoginModel(_controllerEmail.text, _controllerSenha.text);

        var _url = "${ConstantesRest.URL_LOGIN}";
        var _dados = loginModel.toJson();

        if (ConstantesConfig.SERVICO_FIXO == true) {
          _url = "https://jsonplaceholder.typicode.com/posts";
          _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
        }

        http.Response response = await http.post(_url,
            headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
            body: jsonEncode(_dados)
        );

        if (response.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(ConstantesConfig.PREFERENCES_EMAIL, _controllerEmail.text);
          await prefs.setString(ConstantesConfig.PREFERENCES_SENHA, _controllerSenha.text);
          await prefs.setString(ConstantesConfig.PREFERENCES_TOKEN, response.headers['authorization']);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
                (Route<dynamic> route) => false,
          );

        }else{
          setState(() {
            _mensagem = "Dados incorretos!!!";
          });

          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waiting(context, "Mensagem", "(${response.statusCode}) ${_mensagem}");
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
        }

      }else{
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "Dados incorretos!!!");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        setState(() {
          _mensagem = "Dados incorretos!!!";
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

  void _abrirCadastro() {
    _mensagem = "";
    Navigator.pushNamed(context, "/cadastro");
  }

  _enviaNovaSenha() async {
    try {
      Navigator.pop(context);
      String _msg = "Senha enviada com sucesso!!!";
      if (_controllerEmailParaTrocaDeSenha.text == "" || _controllerAnoNascimentoParaTrocaDeSenha.text == "") {
        _msg = "Dados para solicitação de senha incompletos.";
      }
      EmailModel emailModel = new EmailModel(_controllerEmailParaTrocaDeSenha.text, int.parse(_controllerAnoNascimentoParaTrocaDeSenha.text));
      var _url = "${ConstantesRest.URL_USUARIOS}/novasenha";
      var _dados = emailModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      http.Response response = await http.post(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 204) {
        setState(() {
          _mensagem = _msg;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                  padding: EdgeInsets.only(top: 20),
                  child: Image.asset("images/logoFuttRedes.png", height: 100, width: 75),
                ),
                /*Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                      "Olá!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Candal'
                      ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Faça seu login e participe de uma rede.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Candal'
                    ),
                  ),
                ),*/
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
                            // autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                filled: false,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.email, color: Colors.white,),
                                // icon: new Icon(Icons.email),
                                // prefixText: "E-mail",
                                // prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                                // labelText: "Informe seu e-mail",
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                 fontSize: 16,
                                 color: Colors.white,
                                ),
                                // border: OutlineInputBorder(
                                //    borderRadius: BorderRadius.circular(5),
                                // ),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            //maxLength: 5,
                            //maxLengthEnforced: true,
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
                              prefixIcon: Icon(Icons.lock, color: Colors.white,),
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
                          padding: EdgeInsets.only(bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                child: Text("Esqueci a senha!!!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Candal'
                                  ),
                                ),
                                onTap: () {
                                  return showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext) {
                                        return AlertDialog(
                                          title: Text("Esqueci a senha!!!"),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                TextField(
                                                  keyboardType: TextInputType.emailAddress,
                                                  decoration: InputDecoration(
                                                    hintText: "Email",
                                                  ),
                                                  controller: _controllerEmailParaTrocaDeSenha,
                                                ),
                                                TextField(
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: "Ano de nascimento",
                                                  ),
                                                  maxLength: 4,
                                                  controller: _controllerAnoNascimentoParaTrocaDeSenha,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () => _enviaNovaSenha(),
                                              child: Text("Enviar nova senha"),
                                            ),
                                            FlatButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text("Fechar"),
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                },
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: RaisedButton(
                            color: Color(0xff2c7ce7),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Candal',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onPressed: _entrar,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: RaisedButton(
                            color: Colors.orange,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Quero me cadastrar",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Candal',
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onPressed: _abrirCadastro,
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
