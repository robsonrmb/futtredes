import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String _mensagem = "";
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  void _iniciar() async {
    final prefs = await SharedPreferences.getInstance();
    String email = await prefs.getString(ConstantesConfig.PREFERENCES_EMAIL);
    String senha = await prefs.getString(ConstantesConfig.PREFERENCES_SENHA);

    if (email != null && senha != null && email != "" && senha != "") {
      // validar dados na base
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
            (Route<dynamic> route) => false,
      );

    }else{
      setState(() {
        _mensagem = "Por favor, informe os dados!!!";
      });
    }
  }

  void _entrar() async {
    if (_controllerEmail.text != "" && _controllerSenha.text != "") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ConstantesConfig.PREFERENCES_EMAIL, _controllerEmail.text);
      await prefs.setString(ConstantesConfig.PREFERENCES_SENHA, _controllerSenha.text);

      //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
        (Route<dynamic> route) => false,
      );

    }else{
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waiting(context, "Mensagem", "Dados incorretos!!!");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);

      setState(() {
        _mensagem = "Dados incorretos!!!";
      });
    }
  }

  void _abrirCadastro() {
    _mensagem = "";
    Navigator.pushNamed(context, "/cadastro");
    /*
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CadastroView())
    );
     */
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
                  child: Image.asset("images/logoFutt.png", height: 100, width: 75),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                      "Olá!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Candal'
                      ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Faça seu login para saber mais sobre os torneios.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Candal'
                    ),
                  ),
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
                            // autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                filled: false,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.email),
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
                              prefixIcon: Icon(Icons.lock),
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
                              Text(
                                "Esqueci a senha!!!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Candal'
                                ),
                              ),
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
                          child: Text(
                            _mensagem,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Candal'
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
