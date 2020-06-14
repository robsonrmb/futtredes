import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/EdicaoRedeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/IntegrantesView.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/ResponsaveisRedeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MinhasRedesSubView extends StatefulWidget {
  @override
  _MinhasRedesSubViewState createState() => _MinhasRedesSubViewState();
}

class _MinhasRedesSubViewState extends State<MinhasRedesSubView> {

  String _mensagem = "";

  Future<List<RedeModel>> _listaMinhasRedes() async {
    RedeService redeService = RedeService();
    return redeService.listaMinhasRedes(ConstantesConfig.SERVICO_FIXO);
  }

  _showModalAtivaDesativa(BuildContext context, String title, String description, int idRede, String acao){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _realizaAcao(idRede, false, context, acao),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _realizaAcao(idRede, true, context, acao),
                child: Text("Sim"),
              )
            ],
          );
        }
    );
  }

  _realizaAcao(int idRede, bool resposta, BuildContext context, acao) async {
    if (resposta) {
      if (acao == "D") {
        _desativando(idRede, context);
      }else{
        _ativando(idRede, context);
      }
      Navigator.pop(context);

    }else{
      Navigator.pop(context);
    }
  }

  _ativando(int idRede, BuildContext context) async {
    try {
      var _url = "${ConstantesRest.URL_REDE}/${idRede}/desativa";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: _dados,
      );

      if (response.statusCode == 201) {
        _mensagem = "Rede desativada com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);

      }else{
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Rede", "(${response.statusCode}) Falha no processamento!!!");
        await Future.delayed(Duration(seconds: 3));
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

  _desativando(int idRede, BuildContext context) async {
    try {
      var _url = "${ConstantesRest.URL_REDE}/${idRede}/desativa";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: _dados,
      );

      if (response.statusCode == 201) {
        _mensagem = "Rede desativada com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);

      }else{
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Rede", "(${response.statusCode}) Falha no processamento!!!");
        await Future.delayed(Duration(seconds: 3));
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

  _getSubTitulo(int status, String data) {
    if (status == 1) {
      return "EM APROVAÇÃO";
    }else if (status == 2) {
      return data;
    }else if (status == 3) {
      return "Rede fechada.";
    }else if (status == 4) {
      return "DESATIVADA";
    }else{
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RedeModel>>(
      future: _listaMinhasRedes(),
      builder: (context, snapshot) {
        switch( snapshot.connectionState ) {
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
            if( snapshot.hasData ) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {

                  List<RedeModel> redes = snapshot.data;
                  RedeModel rede = redes[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300].withOpacity(0.5),
                          image: DecorationImage(
                              image: NetworkImage(ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto),
                              fit: BoxFit.fill
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          //borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "${rede.nome}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(_getSubTitulo(rede.status, rede.disponibilidade),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: rede.status < 3 ? (rede.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey
                              ),
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Icon(Icons.play_circle_outline,
                                          color: rede.status < 3 ? (rede.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => JogosView(redeModel: rede, donoRede: true),
                                      ));
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(Icons.people,
                                          color: rede.status < 3 ? (rede.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => IntegrantesView(redeModel: rede, donoRede: true)
                                      ));
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(Icons.smartphone,
                                        color: rede.status < 3 ? (rede.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ResponsaveisRedeView(redeModel: rede,)
                                      ));
                                    },
                                  ),
                                  (rede.status == 1 || rede.status == 2) ? GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Icon(Icons.delete_forever,
                                        color: rede.status == 1 ? Colors.lightBlue : Colors.green,),
                                    ),
                                    onTap: (){
                                      _showModalAtivaDesativa(context, "Desativa rede", "Deseja realmente desativar a rede?", rede.id, "D");
                                    },
                                  ) : new Padding(
                                    padding: EdgeInsets.all(1),
                                  ),
                                  (rede.status == 3 || rede.status == 4) ? GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.done,),
                                    ),
                                    onTap: (){
                                      _showModalAtivaDesativa(context, "Ativa rede", "Deseja reativar a rede?", rede.id, "A");
                                    },
                                  ) : new Padding(
                                    padding: EdgeInsets.all(1),
                                  ),
                                ]
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EdicaoRedeView(redeModel: rede),
                            ));
                          },
                        ),
                      ),
                      Container(
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              );
            }else{
              return Center(
                child: Text("Sem valores!!!"),
              );
            }
            break;
        }
      },
    );
  }
}
