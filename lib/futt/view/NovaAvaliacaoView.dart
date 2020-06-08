import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/AvaliacaoModel.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovaAvaliacaoView extends StatefulWidget {

  int idAvaliacao;
  NovaAvaliacaoView(this.idAvaliacao);

  @override
  _NovaAvaliacaoViewState createState() => _NovaAvaliacaoViewState();
}

class _NovaAvaliacaoViewState extends State<NovaAvaliacaoView> {

  double _valorRecepcao = 6.0;
  double _valorLevantada = 6.0;
  double _valorAtaque = 6.0;
  double _valorDefesa = 6.0;
  double _valorPe = 6.0;
  double _valorShark = 6.0;
  double _valorPescoco = 6.0;
  double _valorOmbro = 6.0;

  double _valorConstante = 6.0;
  double _valorVariacao = 6.0;
  double _valorInteligente = 6.0;
  double _valorTatico = 6.0;
  double _valorCompetitivo = 6.0;
  double _valorPreparo = 6.0;

  _confirmaAvaliacao() async {
    try {
      AvaliacaoModel avaliacaoNova = AvaliacaoModel.RespostaStr(widget.idAvaliacao,
          _valorRecepcao.round().toString(), _valorLevantada.round().toString(), _valorAtaque.round().toString(),
          _valorDefesa.round().toString(), _valorShark.round().toString(), _valorPescoco.round().toString(),
          _valorOmbro.round().toString(), _valorPe.round().toString(), _valorConstante.round().toString(),
          _valorVariacao.round().toString(), _valorInteligente.round().toString(), _valorTatico.round().toString(),
          _valorCompetitivo.round().toString(), _valorPreparo.round().toString()
      );
      String valorStr = avaliacaoNova.getStringRespostaStr();

      var _url = "${ConstantesRest.URL_AVALIACOES}/responde";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }
      http.Response response = await http.post(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: _dados
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Navigator.pop(context);

      }else{
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "Falha durante o procedimento");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
      }

    } on Exception catch (exception) {
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waiting(context, "Mensagem", "Falha durante o procedimento");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);

    } catch (error) {
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waiting(context, "Mensagem", "Falha durante o procedimento");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
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
        title: Text("Avalie atleta"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[300],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Como você avalia o atleta abaixo?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Candal'
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg'),
                  radius: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Text(
                    "Anderson Águia",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Avaliações Técnicas",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Candal'
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("Avalie o atleta de acordo com os itens abaixo",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorRecepcao, min: 4, max: 10, divisions: 3,
                            label: _valorRecepcao.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorRecepcao = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("RECEPÇÃO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorLevantada, min: 4, max: 10, divisions: 3,
                            label: _valorLevantada.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorLevantada = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("LEVANTADA",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorAtaque, min: 4, max: 10, divisions: 3,
                            label: _valorAtaque.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorAtaque = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("ATAQUE",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorDefesa, min: 4, max: 10, divisions: 3,
                            label: _valorDefesa.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorDefesa = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("DEFESA",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorShark, min: 4, max: 10, divisions: 3,
                            label: _valorShark.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorShark = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("SHARK",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorPescoco, min: 4, max: 10, divisions: 3,
                            label: _valorPescoco.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorPescoco = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("FINTA DE PESCOÇO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorOmbro, min: 4, max: 10, divisions: 3,
                            label: _valorOmbro.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorOmbro = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("ATAQUE DE OMBRO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorPe, min: 4, max: 10, divisions: 3,
                            label: _valorPe.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorPe = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("PÉ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                  child: Text("Avaliações Táticas",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Candal'
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("Avalie o atleta de acordo com os itens abaixo",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorConstante, min: 4, max: 10, divisions: 3,
                            label: _valorConstante.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorConstante = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("CONSTANTE",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorVariacao, min: 4, max: 10, divisions: 3,
                            label: _valorVariacao.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorVariacao = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("VARIAÇÃO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorInteligente, min: 4, max: 10, divisions: 3,
                            label: _valorInteligente.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorInteligente = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("INTELIGENTE",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorTatico, min: 4, max: 10, divisions: 3,
                            label: _valorTatico.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorTatico = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("TÁTICO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorCompetitivo, min: 4, max: 10, divisions: 3,
                            label: _valorCompetitivo.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorCompetitivo = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("COMPETITIVO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Slider(value: _valorPreparo, min: 4, max: 10, divisions: 3,
                            label: _valorPreparo.toString(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey[300],
                            onChanged: (double novoValor) {
                              setState(() {
                                _valorPreparo = novoValor;
                              });
                            }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("4"), Text("6"),
                            Text("PREPARO FÍSICO",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("8"), Text("10"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 1, 10, 5),
          color: Colors.grey[300],
          child: RaisedButton(
            color: Color(0xff086ba4),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "Confirmar",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () => _confirmaAvaliacao(),
          ),
        ),
      )
    );
  }
}
