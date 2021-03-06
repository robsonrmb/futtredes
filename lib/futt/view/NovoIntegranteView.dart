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
  int _idTorneio;
  TextEditingController _controllerEmail = TextEditingController();

  _inserirIntegrante(id) async {

    String _msg = "";
    if (_controllerEmail.text == "") {
      _msg = "Informe o email.";

    }else {
      try {
        IntegranteModel integranteModel = IntegranteModel.Novo(id, _controllerEmail.text);
        //TorneioService torneioService = TorneioService();
        //torneioService.adicionaIntegrante(integranteModel, ConstantesConfig.SERVICO_FIXO);

        http.Response response = await http.post(
            "https://jsonplaceholder.typicode.com/posts",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "userId": 200,
              "id": null,
              "title": "Título",
              "body": "Corpo da mensagem"
            })
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (_mensagem == "Integrante inserido com sucesso!!!") {
            _mensagem = "Novo integrante inserido com sucesso!!!";
          }else{
            _mensagem = "Integrante inserido com sucesso!!!";
          }
          _msg = _mensagem;
          setState(() {
            _controllerEmail.text = "";
            _idTorneio = id;
          });
          //Navigator.pop(context);

        } else {
          _msg = "Falha durante o processamento!!!";
        }

      } on Exception catch (exception) {
        print(exception.toString());
        setState(() {
          _msg = "Falha durante o processamento!!!";
        });
      } catch (error) {
        setState(() {
          _msg = "Falha durante o processamento!!!";
        });
      }
    }
    setState(() {
      _mensagem = _msg;
    });
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
          title: Text("Novo integrante"),
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
                RaisedButton(
                  color: Color(0xff086ba4),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Cadastrar novo integrante",
                    style: TextStyle(
                        fontSize: 20
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
