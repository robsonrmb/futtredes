import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/JogoRedeService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogosSubView extends StatefulWidget {

  RedeModel redeModel;
  bool donoRede;
  JogosSubView(this.redeModel, this.donoRede);

  @override
  _JogosSubViewState createState() => _JogosSubViewState();
}

class _JogosSubViewState extends State<JogosSubView> {

  TextEditingController _controllerPontuacao1 = TextEditingController();
  TextEditingController _controllerPontuacao2 = TextEditingController();
  bool _atualizaJogos = false;
  String _mensagem = "";

  Future<List<JogoRedeModel>> _listaJogosDaRede() async {
    JogoRedeService jogoService = JogoRedeService();
    return jogoService.listaPorRede(widget.redeModel.id, ConstantesConfig.SERVICO_FIXO);
  }

  _atualizaPlacar(int idJogo, int idNumeroJogo) async {
    try {
      JogoRedeModel jogoModel = JogoRedeModel.NovoPlacar(idJogo, idNumeroJogo, int.parse(_controllerPontuacao1.text), int.parse(_controllerPontuacao2.text));

      var _url = "${ConstantesRest.URL_JOGO_REDE}/atualizaplacar";
      var _dados = jogoModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 200, 'id': null, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados)
      );
      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Placar atualizado com sucesso!!!";
        });
        Navigator.pop(context);

      }else {
        var _dadosJson = jsonDecode(response.body);
        ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
        setState(() {
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
    /*
    final snackbar = SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text("${_mensagem}",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "",
        onPressed: () {
          // Codigo para desfazer alteração
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
    */
  }

  bool _alteraPlacar(JogoRedeModel jogo) {
    if (widget.donoRede == true &&
        (widget.redeModel.status == 1 || widget.redeModel.status == 2) &&
        (jogo.pontuacao1 == 0 && jogo.pontuacao2 == 0)) {
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JogoRedeModel>>(
      future: _listaJogosDaRede(),
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

                  List<JogoRedeModel> paticipantes = snapshot.data;
                  JogoRedeModel jogo = paticipantes[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${jogo.apelidoFormatadoJogador1}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${jogo.apelidoFormatadoJogador2}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 40, width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${jogo.pontuacao1}",
                                          style: TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey[800]
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                Text(" X "),
                                Container(
                                  height: 40, width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${jogo.pontuacao2}",
                                          style: TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold,
                                              color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey[800]
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "${jogo.apelidoFormatadoJogador3}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${jogo.apelidoFormatadoJogador4}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _alteraPlacar(jogo) ? Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ListTile(
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                _alteraPlacar(jogo) ? new GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.edit,
                                      //color: Colors.black
                                    ),
                                  ),
                                  onTap: (){
                                    _controllerPontuacao1.text = "";
                                    _controllerPontuacao2.text = "";
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: Text("Informe o placar"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          "${jogo.apelidoFormatadoJogador1}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${jogo.apelidoFormatadoJogador2}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 40, width: 40,
                                                          child: TextField(
                                                            keyboardType: TextInputType.number,
                                                            maxLength: 2,
                                                            controller: _controllerPontuacao1,
                                                          ),
                                                        ),
                                                        Text(" X "),
                                                        Container(
                                                          height: 40, width: 40,
                                                          child: TextField(
                                                            keyboardType: TextInputType.number,
                                                            maxLength: 2,
                                                            controller: _controllerPontuacao2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: <Widget>[
                                                        Text(
                                                          "${jogo.apelidoFormatadoJogador3}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${jogo.apelidoFormatadoJogador4}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              /*
                                              TextField(
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Pontuação (${jogo.nomeJogador1}/${jogo.nomeJogador2})",
                                                ),
                                                maxLength: 2,
                                                controller: _controllerPontuacao1,
                                              ),
                                              TextField(
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Pontuação (${jogo.nomeJogador3}/${jogo.nomeJogador4})",
                                                ),
                                                maxLength: 2,
                                                controller: _controllerPontuacao2,
                                              ),
                                              */
                                              RaisedButton(
                                                color: Color(0xff086ba4),
                                                textColor: Colors.white,
                                                padding: EdgeInsets.all(15),
                                                child: Text(
                                                  "Atualiza placar",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Candal',
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                                onPressed: () {
                                                  _atualizaPlacar(jogo.id, jogo.numero);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: RaisedButton(
                                              color: Color(0xff086ba4),
                                              textColor: Colors.white,
                                              padding: EdgeInsets.all(15),
                                              child: Text(
                                                "Fechar",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Candal',
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  },
                                ) : new Padding(
                                  padding: EdgeInsets.all(1),
                                ),
                                _alteraPlacar(jogo) ? new GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.delete_forever,
                                      //color: Colors.black
                                    ),
                                  ),
                                  onTap: (){},
                                ) : new Padding(
                                  padding: EdgeInsets.all(1),
                                ),
                              ]),
                        ),
                      ) : new Padding(
                        padding: EdgeInsets.all(1),
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
