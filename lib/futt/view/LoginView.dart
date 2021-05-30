import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EmailModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/LoginModel.dart';
import 'package:futt/futt/model/UsuarioAssinanteModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  @override
  bool exibeLogin;

  LoginView({this.exibeLogin});

  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _mensagem = "";
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerEmailParaTrocaDeSenha =
      TextEditingController();
  TextEditingController _controllerAnoNascimentoParaTrocaDeSenha =
      TextEditingController();

  SharedPreferences prefs;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    inicializarShared();
    // _iniciar(widget.exibeLogin);
  }

  void inicializarShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _iniciar(bool exibeLogin) async {
    try {
      if (exibeLogin) {
        _controllerEmail.text = "";
        _controllerSenha.text = "";
      } else {
        String email =
            await prefs.getString(ConstantesConfig.PREFERENCES_EMAIL);
        String senha =
            await prefs.getString(ConstantesConfig.PREFERENCES_SENHA);

        if (email != null && senha != null && email != "" && senha != "") {
          _mensagem = "";
          LoginModel loginModel = LoginModel(email, senha);

          var _url = "${ConstantesRest.URL_LOGIN}";
          var _dados = loginModel.toJson();

          if (ConstantesConfig.SERVICO_FIXO == true) {
            _url = "https://jsonplaceholder.typicode.com/posts";
            _dados = jsonEncode({
              'userId': 200,
              'id': null,
              'title': 'Título',
              'body': 'Corpo da mensagem'
            });
          }

          http.Response response = await http.post(_url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(_dados));

          if (response.statusCode == 200) {
            //Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
            await prefs.setString(
                ConstantesConfig.PREFERENCES_EMAIL, _controllerEmail.text);
            await prefs.setString(
                ConstantesConfig.PREFERENCES_SENHA, _controllerSenha.text);
            await prefs.setString(ConstantesConfig.PREFERENCES_TOKEN,
                response.headers['authorization']);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              (Route<dynamic> route) => false,
            );
          } else {
            setState(() {
              _mensagem = "";
              _controllerEmail.text = ""; //robson.rmb@gmail.com
              _controllerSenha.text = ""; //123
              _controllerEmailParaTrocaDeSenha.text = ""; //robson.rmb@gmail.com
              _controllerAnoNascimentoParaTrocaDeSenha.text = ""; //1978
            });
          }
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

  void _entrar(BuildContext context) async {
    try {
      if (_controllerEmail.text != "" && _controllerSenha.text != "") {
        circularProgress(context);
        _mensagem = "";
        LoginModel loginModel =
            LoginModel(_controllerEmail.text, _controllerSenha.text);

        var _url = "${ConstantesRest.URL_LOGIN}";
        var _dados = loginModel.toJson();

        if (ConstantesConfig.SERVICO_FIXO == true) {
          _url = "https://jsonplaceholder.typicode.com/posts";
          _dados = jsonEncode({
            'userId': 200,
            'id': null,
            'title': 'Título',
            'body': 'Corpo da mensagem'
          });
        }

        http.Response response = await http.post(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(_dados));

        if (response.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              ConstantesConfig.PREFERENCES_EMAIL, _controllerEmail.text);
          await prefs.setString(
              ConstantesConfig.PREFERENCES_SENHA, _controllerSenha.text);
          await prefs.setString(ConstantesConfig.PREFERENCES_TOKEN,
              response.headers['authorization']);

          _buscarUsuarioAssinante();
        } else {
          Navigator.pop(context);
          setState(() {
            _mensagem = "Dados incorretos.";
          });

          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waiting(
              context, "Mensagem", "${_mensagem}");
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
        }
      } else {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "Dados incorretos!!!");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        setState(() {
          _mensagem = "Dados incorretos.";
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
      String _msg = "Senha enviada com sucesso.";
      if (_controllerEmailParaTrocaDeSenha.text == "" ||
          _controllerAnoNascimentoParaTrocaDeSenha.text == "") {
        _msg = "Dados para solicitação de senha incompletos.";
      }
      EmailModel emailModel = new EmailModel(
          _controllerEmailParaTrocaDeSenha.text,
          int.parse(_controllerAnoNascimentoParaTrocaDeSenha.text));
      var _url = "${ConstantesRest.URL_USUARIOS}/novasenha";
      var _dados = emailModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({
          'userId': 200,
          'id': null,
          'title': 'Título',
          'body': 'Corpo da mensagem'
        });
      }

      http.Response response = await http.post(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(_dados));

      if (response.statusCode == 204) {
        setState(() {
          _mensagem = _msg;
        });
      } else {
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
                image: AssetImage("images/fundo.jpg"), fit: BoxFit.fill)),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Image.asset("images/logoFuttRedesNovo.png",
                      height: 100, width: 75),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 20, top: 16),
                  child: Text(
                    "Olá!",
                    style: TextStyle(
                      color: AppColors.colorTextLogCad,
                      fontSize: 26,
                      fontFamily: FontFamily.fontSpecial,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20),
                  child: Text(
                    "Faça seu login para saber mais sobre as redes.",
                    style: TextStyle(
                      color: AppColors.colorTextLogCad,
                      fontSize: 12,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: new Text(
                            'Email ou Usuário',
                            style: new TextStyle(
                                color: AppColors.colorTextLogCad, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: new Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.colorIconLogCad,
                                  size: 20,
                                ),
                              ),
                              isDense: true,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 23, maxHeight: 20),
                              hintText: "Digite seu email ou usuário",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.colorTextLogCad,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.colorTextLogCad,
                            ),
                            controller: _controllerEmail,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: new Text(
                            'Senha',
                            style: new TextStyle(
                                color: AppColors.colorTextLogCad, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 20),
                              isDense: true,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 23, maxHeight: 10),
                              filled: false,
                              fillColor: AppColors.colorTextLogCad,
                              prefixIcon: new Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColors.colorIconLogCad,
                                  size: 20,
                                ),
                              ),
                              suffixIcon: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                child: new Container(
                                  // margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.colorIconLogCad,
                                    size: 20,
                                  ),
                                ),
                              ),
                              hintText: "Digite sua senha",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.colorTextLogCad,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.colorTextLogCad,
                            ),
                            obscureText: obscureText,
                            controller: _controllerSenha,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 40, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  child: Text(
                                    "Esqueci a senha",
                                    style: TextStyle(
                                      color: AppColors.colorTextLogCad,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    return showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            title: Text("Esqueci a senha!!!"),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  TextField(
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    decoration: InputDecoration(
                                                      hintText: "Email",
                                                    ),
                                                    controller:
                                                        _controllerEmailParaTrocaDeSenha,
                                                  ),
                                                  TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Ano de nascimento",
                                                    ),
                                                    maxLength: 4,
                                                    controller:
                                                        _controllerAnoNascimentoParaTrocaDeSenha,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                                                color: AppColors.colorButtonDialog,
                                                onPressed: () =>
                                                    _enviaNovaSenha(),
                                                child:
                                                Text("Enviar nova senha"),
                                              ),
                                              FlatButton(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                                                color: AppColors.colorButtonDialog,
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Fechar"),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                )
                              ],
                            )),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 5),
                        //   child: RaisedButton(
                        //     color: Color(0xff2c7ce7),
                        //     textColor: Colors.white,
                        //     padding: EdgeInsets.all(15),
                        //     child: Text(
                        //       "Entrar",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         fontFamily: 'Candal',
                        //       ),
                        //     ),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     onPressed: _entrar,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 5),
                        //   child: RaisedButton(
                        //     color: Colors.orange,
                        //     textColor: Colors.white,
                        //     padding: EdgeInsets.all(15),
                        //     child: Text(
                        //       "Quero me cadastrar",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         fontFamily: 'Candal',
                        //       ),
                        //     ),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     onPressed: _abrirCadastro,
                        //   ),
                        // ),
                        RaisedButton(
                          onPressed: () {
                            _entrar(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppColors.colorEspecialPrimario1,
                                  AppColors.colorEspecialPrimario2
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              constraints: const BoxConstraints(
                                  minWidth: 88.0, minHeight: 36.0),
                              // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: Text(
                                "Entrar",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.colorTextLogCad,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        new Container(
                          height: 4,
                        ),
                        RaisedButton(
                          onPressed: _abrirCadastro,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppColors.colorEspecialSecundario1,
                                  AppColors.colorEspecialSecundario2
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              constraints: const BoxConstraints(
                                  minWidth: 88.0, minHeight: 36.0),
                              // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: Text(
                                "Quero me cadastrar",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.colorTextLogCad,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 14),
                          alignment: Alignment.center,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ainda não é assinante? ",
                                style: TextStyle(
                                  color: AppColors.colorTextLogCad,
                                  fontSize: 14,
                                ),
                              ),
                              new GestureDetector(
                                onTap: (){
                                  launchURL();
                                },
                                child:
                                new Container(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  color: Colors.transparent,
                                  child:
                                  new Text(
                                    'Assine aqui.',
                                    style: TextStyle(
                                      color: AppColors.colorTextLogCad,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        // Padding(
                        //   padding: EdgeInsets.only(top: 15),
                        //   child: Center(
                        //     child: Text(
                        //       _mensagem,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontFamily: 'Candal'),
                        //     ),
                        //   ),
                        // ),
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

  void _buscarUsuarioAssinante() async {
    UsuarioService usuarioService = UsuarioService();
    UsuarioAssinanteModel usuarioAssinanteModel =
        await usuarioService.buscaUsuarioAssinante();
    Navigator.pop(context);

    if (usuarioAssinanteModel != null) {
      await prefs.setBool(ConstantesConfig.PREFERENCES_ASSINANTE,
          usuarioAssinanteModel.status ?? false);
      await prefs.setBool(ConstantesConfig.PREFERENCES_ASSINANTE,
          usuarioAssinanteModel.status ?? false);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
        (Route<dynamic> route) => false,
      );
    } else {
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waitingError(
          context, "Erro", 'Ocorreu algum erro ao validar seus dados');
      await Future.delayed(Duration(seconds: 4));
      Navigator.pop(context);
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext) {
      //       return AlertDialog(
      //         title: Text('Erro'),
      //         content: SingleChildScrollView(
      //           child: ListBody(
      //             children: <Widget>[
      //               Text('Ocorreu algum erro ao validar seus dados'),
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      // );
    }
  }

  launchURL() async {
    const url = 'http://www.futtapp.com.br';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void circularProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext bc) {
          return Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )
              ],
            ),
          );
        });
  }
}
