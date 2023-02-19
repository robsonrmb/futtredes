import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/CadastroLoginModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroView extends StatefulWidget {
  @override
  _CadastroViewState createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  String? _mensagem = "";
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNickName = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerSenhaConfirmacao = TextEditingController();
  bool obscureText = true;
  bool obscureTextConfirmar = true;

  void _cadastrar() async {
    DialogFutt dialogFutt = new DialogFutt();
    circularProgress(context);
    try {
      _mensagem = "";
      CadastroLoginModel cadastroLoginModel = CadastroLoginModel();
      cadastroLoginModel.email = _controllerEmail.text;
      cadastroLoginModel.senha = _controllerSenha.text;
      cadastroLoginModel.nome = _controllerNome.text;
      cadastroLoginModel.user = _controllerNickName.text;


      if (_controllerNome.text == "") {
        _mensagem = "Informe seu nome.";
      } else if (_controllerEmail.text == "") {
        _mensagem = "Informe seu username.";
      }else if (_controllerNickName.text == "") {
        _mensagem = "Informe seu email.";
      } else if (_controllerSenha.text == "") {
        _mensagem = "Informe a senha.";
      } else if (_controllerSenhaConfirmacao.text == "") {
        _mensagem = "Confirme a senha.";
      } else if (_controllerSenha.text != _controllerSenhaConfirmacao.text) {
        _mensagem = "Confirmação de senha incorreta.";
      }

      if (_mensagem != "") {
        Navigator.pop(context);
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      var _url = "${ConstantesRest.URL_USUARIOS}";
      var _dados = cadastroLoginModel.toJson();

      http.Response response = await http.post(Uri.parse(_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(_dados));

      if (response.statusCode == 201) {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Concluído", "Cadastro Realizado com sucesso!");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
              (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          String source = Utf8Decoder().convert(response.bodyBytes);
          var dadosJson = json.decode(source);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(dadosJson);
          _mensagem = exceptionModel.msg;
        });
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Erro", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.pop(context);
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
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => LoginView()));
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
                // new Row(
                //   children: [
                //     new IconButton(
                //         icon: Icon(Icons.arrow_back,color: Colors.white,),
                //         onPressed: () {
                //           Navigator.pop(context);
                //         })
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Image.asset("images/logoFuttRedesNovo.png",
                      height: 60, width: 15),
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
                    "Vamos fazer o seu cadastro?",
                    style: TextStyle(
                      color: AppColors.colorTextLogCad,
                      fontSize: 12,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: new Text(
                            'Nome',
                            style: new TextStyle(
                                color: AppColors.colorTextLogCad, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: new Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.person_outline,
                                  color: AppColors.colorIconLogCad,
                                  size: 20,
                                ),
                              ),
                              isDense: true,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 23, maxHeight: 20),
                              hintText: "Digite seu nome",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.colorTextLogCad,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.colorTextLogCad,
                            ),
                            controller: _controllerNome,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 16),
                          child: new Text(
                            'Usuário',
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
                                  Icons.perm_contact_cal,
                                  color: AppColors.colorIconLogCad,
                                  size: 20,
                                ),
                              ),
                              isDense: true,
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 23, maxHeight: 20),
                              hintText: "Digite seu Usuário",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.colorTextLogCad,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.colorTextLogCad,
                            ),
                            controller: _controllerNickName,
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 16),
                          child: new Text(
                            'Email',
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
                              hintText: "Digite seu email",
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
                        new Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: new Text(
                            'Confirmar Senha',
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
                                    obscureTextConfirmar =
                                        !obscureTextConfirmar;
                                  });
                                },
                                child: new Container(
                                  // margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    obscureTextConfirmar
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
                            obscureText: obscureTextConfirmar,
                            controller: _controllerSenhaConfirmacao,
                          ),
                        ),
                        new Container(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: _cadastrar,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.all(0.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[AppColors.colorEspecialPrimario1, AppColors.colorEspecialPrimario2],
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
                                "Cadastrar",
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
                        ElevatedButton(
                          onPressed: _voltar,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.all(0.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[AppColors.colorEspecialSecundario1, AppColors.colorEspecialSecundario2],
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
                              child:  Text(
                                "Já sou cadastrado",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.colorTextLogCad,
                                    fontWeight: FontWeight.bold),
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
