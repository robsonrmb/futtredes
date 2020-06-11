import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/EdicaoRedeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/ParticipantesView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
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

  showModalDesativa(BuildContext context, String title, String description, int idRede){
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
                onPressed: () => _desativa(idRede, false, context),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _desativa(idRede, true, context),
                child: Text("Sim"),
              )
            ],
          );
        }
    );
  }

  _desativa(int idRede, bool resposta, BuildContext context) async {
    if (resposta) {
      _desativando(idRede, context);
      Navigator.pop(context);
      /*
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waiting(context, "Desativa rede", "Rede desativada com sucesso!!!");
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      */

    }else{
      Navigator.pop(context);
    }
  }

  _desativando(int idRede, BuildContext context) async {
    try {
      String _msg = "";
      //RedeService redeService = RedeService();
      //redeService.inclui(redeModel, ConstantesConfig.SERVICO_FIXO);

      var _url = "${ConstantesRest.URL_REDE}/${idRede}/desativa";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      http.Response response = await http.put(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: _dados
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _msg = "Rede desativada!!!";
      }else{
        _msg = "Falha durante o processamento!!!";
      }
      setState(() {
        _mensagem = _msg;
      });

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
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                              image: NetworkImage(ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          //borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          child:
                          ListTile(
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
                            subtitle: Text(
                              "${rede.pais} - ${rede.cidade} - ${rede.local}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.people,
                                        //color: Colors.black,
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ParticipantesView(idRede: rede.id,
                                              nomeRede: rede.nome,
                                              paisRede: rede.pais,
                                              cidadeRede: rede.cidade,
                                              localRede: rede.local,
                                              donoRede: true)
                                      ));
                                    },
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(Icons.delete_forever,),
                                    ),
                                    onTap: (){
                                      showModalDesativa(context, "Desativa rede", "Deseja realmente desativar a rede?", rede.id);
                                    },
                                  ),
                                ]
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => JogosView(idRede: rede.id,
                                  nomeRede: rede.nome,
                                  paisRede: rede.pais,
                                  cidadeRede: rede.cidade,
                                  localRede: rede.local,
                                  donoRede: true),
                            ));
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: Colors.grey[300],
                        child: RaisedButton(
                          color: Color(0xff086ba4),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Atualiza dados da rede",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Candal',
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EdicaoRedeView(redeModel: rede),
                            ));
                          },
                        ),
                      ),
                      Container(
                        height: 15,
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
