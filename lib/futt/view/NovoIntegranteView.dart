import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovoIntegranteView extends StatefulWidget {

  int idTorneio;
  NovoIntegranteView(this.idTorneio);

  @override
  _NovoIntegranteViewState createState() => _NovoIntegranteViewState();
}

class _NovoIntegranteViewState extends State<NovoIntegranteView> {

  String _mensagem = "";
  int? _idTorneio;
  TextEditingController _controllerEmail = TextEditingController();

  _inserirIntegrante(id) async {

    String _msg = "";
    if (_controllerEmail.text == "") {
      _msg = "Informe o email.";

    }else {
      IntegranteModel integranteModel = IntegranteModel.Novo(
          id, _controllerEmail.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff093352),
          title: Text("Novo integrante",style: TextStyle(   color: Colors.white,
              fontSize: 20),),
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    //labelText: "Informe o e-mail",
                    filled: false,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email),
                    hintText: "Informe o email",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                  ),
                  controller: _controllerEmail,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff086ba4),
                    padding: EdgeInsets.all(15),

                  ),
                  child: Text(
                    "Cadastrar novo integrante",
                    style: TextStyle(
                        fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    _inserirIntegrante(widget.idTorneio);
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(_mensagem,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        )
    );
  }
}
