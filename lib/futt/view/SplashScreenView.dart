import 'dart:convert';
import 'package:futt/futt/model/UsuarioAssinanteModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenView extends StatefulWidget {
  @override
  bool splashInicial;

  SplashScreenView({this.splashInicial: false});

  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    verificarUsuario();
  }

  verificarUsuario() async {
    if (widget.splashInicial) {
      pref = await SharedPreferences.getInstance();
      String email = pref.getString(ConstantesConfig.PREFERENCES_EMAIL);
      String senha = pref.getString(ConstantesConfig.PREFERENCES_SENHA);
      if (email != null && senha != null && email != "" && senha != "") {
        LoginModel loginModel = LoginModel(email, senha);

        var _url = "${ConstantesRest.URL_LOGIN}";
        var _dados = loginModel.toJson();

        http.Response response = await http.post(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(_dados));

        if (response.statusCode == 200) {
          //Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
          await pref.setString(ConstantesConfig.PREFERENCES_TOKEN,
              response.headers['authorization']);
          _buscarUsuarioAssinante();
        }
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
              (Route<dynamic> route) => false,
        );
      }
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
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              new Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    height: 130.0,
                    width: 130.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Image.asset("images/logoFuttRedesNovo.png",
                        height: 100, width: 125),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buscarUsuarioAssinante() async {
    UsuarioService usuarioService = UsuarioService();
    UsuarioAssinanteModel usuarioAssinanteModel = await usuarioService.buscaUsuarioAssinante();
    Navigator.pop(context);

    if (usuarioAssinanteModel != null) {
      await pref.setBool(ConstantesConfig.PREFERENCES_ASSINANTE, usuarioAssinanteModel.status??false);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
            (Route<dynamic> route) => false,
      );
    }
    else{
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waitingError(context, "Erro", 'Ocorreu algum erro ao validar seus dados');
      await Future.delayed(Duration(seconds: 4));
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
      );
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

}
