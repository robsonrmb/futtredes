import 'package:flutter/widgets.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/JogoRedeService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

class JogosSubView extends StatefulWidget {
  RedeModel redeModel;
  bool donoRede;
  bool meusJogos;

  JogosSubView(this.redeModel, this.donoRede, this.meusJogos);

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
    if (widget.meusJogos) {
      return jogoService.listaPorRedeUsuario(
          widget.redeModel.id, ConstantesConfig.SERVICO_FIXO);
    } else {
      return jogoService.listaPorRede(
          widget.redeModel.id, ConstantesConfig.SERVICO_FIXO);
    }
  }

  _atualizaPlacar(int idJogo, int idNumeroJogo) async {
    if(_controllerPontuacao1.text.isNotEmpty && _controllerPontuacao2.text.isNotEmpty){
      circularProgress(context);

      try {
        JogoRedeModel jogoModel = JogoRedeModel.NovoPlacar(
            idJogo,
            idNumeroJogo,
            int.parse(_controllerPontuacao1.text),
            int.parse(_controllerPontuacao2.text));

        var _url = "${ConstantesRest.URL_JOGO_REDE}/atualizaplacar";
        var _dados = jogoModel.toJson();

        if (ConstantesConfig.SERVICO_FIXO == true) {
          _url = "https://jsonplaceholder.typicode.com/posts/1";
          _dados = jsonEncode({
            'userId': 200,
            'id': null,
            'title': 'Título',
            'body': 'Corpo da mensagem'
          });
        }

        final prefs = await SharedPreferences.getInstance();
        String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

        http.Response response = await http.put(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token,
            },
            body: jsonEncode(_dados));
        Navigator.pop(context);

        if (response.statusCode == 201) {
          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingSucess(context, "Placar", "Placar atualizado com sucesso!!!");
          await Future.delayed(Duration(seconds: 2));
          Navigator.pop(context);
          Navigator.pop(context);
          setState(() {
            _mensagem = "Placar atualizado com sucesso!!!";
          });
        } else {
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingError(context, "Placar", "${exceptionModel.msg}");
          await Future.delayed(Duration(seconds: 2));
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
    }else{
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waiting(context, "Placar", "Por favor, informe o placar dos 2 times");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
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

  _removeJogo(int idJogo) async {
    try {
      JogoRedeModel jogoModel = JogoRedeModel.Remove(idJogo);

      var _url = "${ConstantesRest.URL_JOGO_REDE}/remove/${idJogo}";
      var _dados = jogoModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({
          'userId': 200,
          'id': null,
          'title': 'Título',
          'body': 'Corpo da mensagem'
        });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.delete(
        _url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Jogo removido com sucesso!!!";
        });
        Navigator.pop(context);
      } else {
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
  }

  _showModalRemoveJogo(
      BuildContext context, String title, String description, int idJogo) {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.showAlertDialogActionNoYes(context, title, description, () {
      _removeJogo(idJogo);
    });
    // return showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (BuildContext) {
    //       return AlertDialog(
    //         title: Text(title),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               Text(description),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             onPressed: () => {
    //               Navigator.pop(context),
    //             },
    //             child: Text("Não"),
    //           ),
    //           FlatButton(
    //             onPressed: () => _removeJogo(idJogo),
    //             child: Text("Sim"),
    //           )
    //         ],
    //       );
    //     });
  }

  _zeraJogo(int idJogo) async {
    try {
      circularProgress(context);

      JogoRedeModel jogoModel = JogoRedeModel.Remove(idJogo);

      var _url = "${ConstantesRest.URL_JOGO_REDE}/zeraplacar/${idJogo}";
      var _dados = jogoModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({
          'userId': 200,
          'id': null,
          'title': 'Título',
          'body': 'Corpo da mensagem'
        });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(
        _url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      Navigator.pop(context);
      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Placar do jogo zerado com sucesso!!!";
        });
        Navigator.pop(context);
      } else {
        var _dadosJson = jsonDecode(response.body);
        ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Zerar Jogo", "${exceptionModel.msg}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
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
  }

  _showModalZeraJogo(
      BuildContext context, String title, String description, int idJogo) {
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
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _zeraJogo(idJogo),
                child: Text("Sim"),
              )
            ],
          );
        });
  }

  void showZerar(int idJogo) {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.showAlertDialogActionNoYes(context, "Zerar placar do jogo",
        'Deseja realmente zerar o placar do jogo?', () {
      _zeraJogo(idJogo);
    });
  }

  bool _alteraPlacar(JogoRedeModel jogo) {
    if (widget.donoRede == true &&
        (widget.redeModel.status == 1 || widget.redeModel.status == 2) &&
        (jogo.pontuacao1 == 0 && jogo.pontuacao2 == 0)) {
      return true;
    } else {
      return false;
    }
  }

  bool _zeraPlacar(JogoRedeModel jogo) {
    if (widget.donoRede == true &&
        (widget.redeModel.status == 1 || widget.redeModel.status == 2) &&
        (jogo.pontuacao1 != 0 || jogo.pontuacao2 != 0)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final maskPoints = MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});

    return FutureBuilder<List<JogoRedeModel>>(
      future: _listaJogosDaRede(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
              // decoration: BoxDecoration(
              //   color: Colors.grey[300],
              //   borderRadius: BorderRadius.circular(5),
              // ),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return new FadeAnimation(
                    0.5 * index,
                    new Card(
                      elevation: 5,
                      child: new Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: new Row(
                          children: [
                            new Expanded(
                              flex: 4,
                              child: new Column(
                                children: [
                                  new Row(
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            height: 30,
                                            width: 30,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            height: 20,
                                            width: 60,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                    ],
                                  ),
                                  new Row(
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            height: 30,
                                            width: 30,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin: const EdgeInsets.only(
                                                right: 8, top: 8),
                                            height: 20,
                                            width: 60,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            new Expanded(
                              flex: 2,
                              child: new Column(
                                children: [
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            height: 20,
                                            width: 46,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            new Expanded(
                              flex: 4,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            height: 20,
                                            width: 60,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            height: 30,
                                            width: 30,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin: const EdgeInsets.only(
                                                right: 8, top: 8),
                                            height: 20,
                                            width: 60,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                      Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.5),
                                          highlightColor: Colors.white,
                                          child: new Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            height: 30,
                                            width: 30,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontal: true,
                  );
                },
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                // decoration: BoxDecoration(
                //   color: Colors.grey[300],
                //   borderRadius: BorderRadius.circular(5),
                // ),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List<JogoRedeModel> paticipantes = snapshot.data;
                    JogoRedeModel jogo = paticipantes[index];

                    return new GestureDetector(
                      onTap: () {
                        _zeraPlacar(jogo)
                            ? showZerar(jogo.id)
                            // _showModalZeraJogo(
                            //         context,
                            //         "Zerar placar do jogo",
                            //         "Deseja realmente zerar o placar do jogo?",
                            //         jogo.id)
                            : print("");
                      },
                      child: new Card(
                        elevation: 5,
                        color: AppColors.colorCardFundoJogos,
                        child: new Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, top: 20),
                            child: new Column(
                              children: [
                                new Row(
                                  children: [
                                    new Expanded(
                                      flex: 4,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            children: [
                                              Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: jogo.nomeFotoJogador1 != null?new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: new DecorationImage(
                                                          fit: BoxFit.scaleDown,
                                                          image: NetworkImage(
                                                              "${ConstantesRest.URL_BASE_AMAZON}${jogo.nomeFotoJogador1}")),
                                                      border: Border.all(
                                                          color:
                                                              Colors.white)):new BoxDecoration()),
                                              new Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: new Text(
                                                  apelidoOuNome(
                                                      jogo.apelidoFormatadoJogador1,
                                                      jogo.nomeJogador1),
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AppColors
                                                          .colorNameJogadorJogos),
                                                ),
                                              )
                                            ],
                                          ),
                                          new Row(
                                            children: [
                                              Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:jogo.nomeFotoJogador2 != null? new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: new DecorationImage(
                                                          fit: BoxFit.scaleDown,
                                                          image: NetworkImage(
                                                              "${ConstantesRest.URL_BASE_AMAZON}${jogo.nomeFotoJogador2}")),
                                                      border: Border.all(
                                                          color:
                                                              Colors.white)):new BoxDecoration()),
                                              new Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: new Text(
                                                  apelidoOuNome(
                                                      jogo.apelidoFormatadoJogador2,
                                                      jogo.nomeJogador2),
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AppColors
                                                          .colorNameJogadorJogos),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    new Expanded(
                                      flex: 2,
                                      child: new Column(
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${jogo.pontuacao1} X ${jogo.pontuacao2}",
                                                style: TextStyle(
                                                  color: AppColors
                                                      .colorPontuacaoJogos,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      FontFamily.fontSpecial,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    new Expanded(
                                      flex: 4,
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              new Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: new Text(
                                                  apelidoOuNome(
                                                      jogo.apelidoFormatadoJogador3,
                                                      jogo.nomeJogador3),
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AppColors
                                                          .colorNameJogadorJogos),
                                                ),
                                              ),
                                              Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:jogo.nomeFotoJogador3 != null? new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: new DecorationImage(
                                                          fit: BoxFit.scaleDown,
                                                          image: NetworkImage(
                                                              "${ConstantesRest.URL_BASE_AMAZON}${jogo.nomeFotoJogador3}")),
                                                      border: Border.all(
                                                          color:
                                                              Colors.white)):new BoxDecoration()),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              new Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: new Text(
                                                  apelidoOuNome(
                                                      jogo.apelidoFormatadoJogador4,
                                                      jogo.nomeJogador4),
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AppColors
                                                          .colorNameJogadorJogos),
                                                ),
                                              ),
                                              Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: jogo.nomeFotoJogador4 != null?new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: new DecorationImage(
                                                          fit: BoxFit.scaleDown,
                                                          image: NetworkImage(
                                                              "${ConstantesRest.URL_BASE_AMAZON}${jogo.nomeFotoJogador4}")),
                                                      border: Border.all(
                                                          color:
                                                              Colors.white)):new BoxDecoration()),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                _alteraPlacar(jogo)
                                    ? Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: ListTile(
                                          trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _alteraPlacar(jogo)
                                                    ? new Container(
                                                        height: 40,
                                                        width: 40,
                                                        //padding: const EdgeInsets.all(8),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: <Color>[
                                                                widget.redeModel
                                                                            .status <
                                                                        3
                                                                    ? (widget.redeModel.status ==
                                                                            1)
                                                                        ? Color(
                                                                            0xff093352)
                                                                        : AppColors
                                                                            .colorEspecialPrimario1
                                                                    : Colors
                                                                        .grey,
                                                                widget.redeModel
                                                                            .status <
                                                                        3
                                                                    ? (widget.redeModel.status ==
                                                                            1)
                                                                        ? Color(
                                                                            0xff093352)
                                                                        : AppColors
                                                                            .colorEspecialPrimario2
                                                                    : Colors
                                                                        .grey,
                                                              ]),
                                                        ),
                                                        child: GestureDetector(
                                                          child: new Center(
                                                              child: new Container(
                                                                  decoration: new BoxDecoration(
                                                                      //color: Colors.black,
                                                                      shape: BoxShape.circle),
                                                                  child: Icon(
                                                                    Icons.edit,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .white,
                                                                  ))),
                                                          onTap: () {
                                                            _showOpc(context,jogo);
                                                            // _controllerPontuacao1
                                                            //     .text = "";
                                                            // _controllerPontuacao2
                                                            //     .text = "";
                                                            // showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (context) {
                                                            //       return AlertDialog(
                                                            //         shape: RoundedRectangleBorder(
                                                            //             borderRadius:
                                                            //                 BorderRadius.circular(20)),
                                                            //         title: Text(
                                                            //             "Informe o placar"),
                                                            //         content:
                                                            //             SingleChildScrollView(
                                                            //           child:
                                                            //               Column(
                                                            //             crossAxisAlignment:
                                                            //                 CrossAxisAlignment.stretch,
                                                            //             children: <
                                                            //                 Widget>[
                                                            //               Container(
                                                            //                 padding:
                                                            //                     EdgeInsets.all(5),
                                                            //                 decoration:
                                                            //                     BoxDecoration(
                                                            //                   color: Colors.grey[200],
                                                            //                   border: Border.all(
                                                            //                     width: 1.0,
                                                            //                     color: Colors.grey[300],
                                                            //                   ),
                                                            //                       borderRadius: new BorderRadius.circular(8)
                                                            //                 ),
                                                            //                 child:
                                                            //                     Row(
                                                            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            //                   crossAxisAlignment: CrossAxisAlignment.center,
                                                            //                   children: <Widget>[
                                                            //                     Column(
                                                            //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                            //                       children: <Widget>[
                                                            //                         Text(
                                                            //                           "${jogo.apelidoFormatadoJogador1}",
                                                            //                           style: TextStyle(
                                                            //                             fontSize: 14,
                                                            //                             fontWeight: FontWeight.bold,
                                                            //                           ),
                                                            //                         ),
                                                            //                         Text(
                                                            //                           "${jogo.apelidoFormatadoJogador2}",
                                                            //                           style: TextStyle(
                                                            //                             fontSize: 14,
                                                            //                             fontWeight: FontWeight.bold,
                                                            //                           ),
                                                            //                         ),
                                                            //                       ],
                                                            //                     ),
                                                            //                     Row(
                                                            //                       children: <Widget>[
                                                            //                         Container(
                                                            //                           height: 40,
                                                            //                           width: 40,
                                                            //                           margin: const EdgeInsets.only(bottom: 10),
                                                            //                           child: TextField(
                                                            //                             inputFormatters: [maskPoints],
                                                            //                             keyboardType: TextInputType.number,
                                                            //                             controller: _controllerPontuacao1,
                                                            //                             style: TextStyle(
                                                            //                               color: AppColors
                                                            //                                   .colorPontuacaoJogos,
                                                            //                               fontSize: 14,
                                                            //                               fontFamily:
                                                            //                               FontFamily.fontSpecial,
                                                            //                             ),
                                                            //                           ),
                                                            //                         ),
                                                            //                         Text(
                                                            //                           "X",
                                                            //                           style: TextStyle(
                                                            //                             color: AppColors
                                                            //                                 .colorPontuacaoJogos,
                                                            //                             fontSize: 14,
                                                            //                             fontFamily:
                                                            //                             FontFamily.fontSpecial,
                                                            //                           ),
                                                            //                         ),
                                                            //                         Container(
                                                            //                           height: 40,
                                                            //                           width: 40,
                                                            //                           margin: const EdgeInsets.only(bottom: 10),
                                                            //                           child: TextField(
                                                            //                             inputFormatters: [maskPoints],
                                                            //                             keyboardType: TextInputType.number,
                                                            //                             textAlign: TextAlign.right,
                                                            //                             controller: _controllerPontuacao2,
                                                            //                             style: TextStyle(
                                                            //                               color: AppColors
                                                            //                                   .colorPontuacaoJogos,
                                                            //                               fontSize: 14,
                                                            //                               fontFamily:
                                                            //                               FontFamily.fontSpecial,
                                                            //                             ),
                                                            //                           ),
                                                            //                         ),
                                                            //                       ],
                                                            //                     ),
                                                            //                     Column(
                                                            //                       crossAxisAlignment: CrossAxisAlignment.end,
                                                            //                       children: <Widget>[
                                                            //                         Text(
                                                            //                           "${jogo.apelidoFormatadoJogador3}",
                                                            //                           style: TextStyle(
                                                            //                             fontSize: 14,
                                                            //                             fontWeight: FontWeight.bold,
                                                            //                           ),
                                                            //                         ),
                                                            //                         Text(
                                                            //                           "${jogo.apelidoFormatadoJogador4}",
                                                            //                           style: TextStyle(
                                                            //                             fontSize: 14,
                                                            //                             fontWeight: FontWeight.bold,
                                                            //                           ),
                                                            //                         ),
                                                            //                       ],
                                                            //                     ),
                                                            //                   ],
                                                            //                 ),
                                                            //               ),
                                                            //               new Container(height: 20,),
                                                            //               RaisedButton(
                                                            //                 onPressed:
                                                            //                     () {
                                                            //                   _atualizaPlacar(jogo.id, jogo.numero);
                                                            //                 },
                                                            //                 shape:
                                                            //                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                                            //                 padding:
                                                            //                     const EdgeInsets.all(0.0),
                                                            //                 child:
                                                            //                     Ink(
                                                            //                   decoration: BoxDecoration(
                                                            //                     gradient: LinearGradient(
                                                            //                       colors: <Color>[
                                                            //                         AppColors.colorEspecialSecundario1,
                                                            //                         AppColors.colorEspecialSecundario2
                                                            //                       ],
                                                            //                     ),
                                                            //                     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                            //                   ),
                                                            //                   child: Container(
                                                            //                     padding: const EdgeInsets.symmetric(vertical: 12),
                                                            //                     constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                                                            //                     // min sizes for Material buttons
                                                            //                     alignment: Alignment.center,
                                                            //                     child: Text(
                                                            //                       "Atualiza placar",
                                                            //                       style: TextStyle(fontSize: 16, color: AppColors.colorTextLogCad, fontWeight: FontWeight.bold),
                                                            //                     ),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //               // RaisedButton(
                                                            //               //   color: Color(0xff086ba4),
                                                            //               //   textColor:
                                                            //               //   Colors.white,
                                                            //               //   padding:
                                                            //               //   EdgeInsets.all(15),
                                                            //               //   child: Text(
                                                            //               //     "Atualiza placar",
                                                            //               //     style:
                                                            //               //     TextStyle(
                                                            //               //       fontSize:
                                                            //               //       16,
                                                            //               //       fontFamily:
                                                            //               //       'Candal',
                                                            //               //     ),
                                                            //               //   ),
                                                            //               //   shape:
                                                            //               //   RoundedRectangleBorder(
                                                            //               //     borderRadius:
                                                            //               //     BorderRadius.circular(
                                                            //               //         2),
                                                            //               //   ),
                                                            //               //   onPressed:
                                                            //               //       () {
                                                            //               //     _atualizaPlacar(
                                                            //               //         jogo.id,
                                                            //               //         jogo.numero);
                                                            //               //   },
                                                            //               // ),
                                                            //             ],
                                                            //           ),
                                                            //         ),
                                                            //         actions: <
                                                            //             Widget>[
                                                            //           FlatButton(
                                                            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                            //             color: AppColors.colorButtonDialog,
                                                            //             onPressed: (){
                                                            //               Navigator.pop(
                                                            //                   context);
                                                            //             },
                                                            //             child: Text('Fechar',style: new TextStyle(color: Colors.white),),
                                                            //           ),
                                                            //         ],
                                                            //       );
                                                            //     });
                                                          },
                                                        ),
                                                      )
                                                    : new Padding(
                                                        padding:
                                                            EdgeInsets.all(1),
                                                      ),
                                                _alteraPlacar(jogo)
                                                    ? new Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 6),
                                                        height: 40,
                                                        width: 40,
                                                        //padding: const EdgeInsets.all(8),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: <Color>[
                                                                widget.redeModel
                                                                            .status <
                                                                        3
                                                                    ? (widget.redeModel.status ==
                                                                            1)
                                                                        ? Color(
                                                                            0xff093352)
                                                                        : AppColors
                                                                            .colorEspecialPrimario1
                                                                    : Colors
                                                                        .grey,
                                                                widget.redeModel
                                                                            .status <
                                                                        3
                                                                    ? (widget.redeModel.status ==
                                                                            1)
                                                                        ? Color(
                                                                            0xff093352)
                                                                        : AppColors
                                                                            .colorEspecialPrimario2
                                                                    : Colors
                                                                        .grey,
                                                              ]),
                                                        ),
                                                        child: GestureDetector(
                                                          child: new Center(
                                                              child: new Container(
                                                                  decoration: new BoxDecoration(
                                                                      //color: Colors.black,
                                                                      shape: BoxShape.circle),
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_forever,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white,
                                                                  ))),
                                                          onTap: () {
                                                            _showModalRemoveJogo(
                                                                context,
                                                                "Remove jogo",
                                                                "Deseja realmente remover o jogo?",
                                                                jogo.id);
                                                          },
                                                        ),
                                                      )
                                                    : new Padding(
                                                        padding:
                                                            EdgeInsets.all(1),
                                                      ),
                                              ]),
                                        ),
                                      )
                                    : new Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                              ],
                            )),
                      ),
                    );
                    return new Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                              padding: EdgeInsets.all(3),
                              // decoration: BoxDecoration(
                              //   color: Colors.grey[300],
                              //   borderRadius: BorderRadius.circular(5),
                              //   border: Border.all(
                              //     width: 1.0,
                              //     color: Colors.grey[300],
                              //   ),
                              // ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "${jogo.pontuacao1}",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    widget.redeModel.status < 3
                                                        ? (widget.redeModel
                                                                    .status ==
                                                                1)
                                                            ? Color(0xff093352)
                                                            : Colors.blue
                                                        : Colors.grey[800]),
                                          ),
                                        ]),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "X",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              //color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey[800]
                                            ),
                                          ),
                                        ]),
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
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "${jogo.pontuacao2}",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    widget.redeModel.status < 3
                                                        ? (widget.redeModel
                                                                    .status ==
                                                                1)
                                                            ? Color(0xff093352)
                                                            : Colors.blue
                                                        : Colors.grey[800]),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              _zeraPlacar(jogo)
                                  ? _showModalZeraJogo(
                                      context,
                                      "Zerar placar do jogo",
                                      "Deseja realmente zerar o placar do jogo?",
                                      jogo.id)
                                  : print("");
                            },
                          ),
                          _alteraPlacar(jogo)
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: ListTile(
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _alteraPlacar(jogo)
                                              ? new GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Icon(Icons.edit,
                                                        color: widget.redeModel
                                                                    .status <
                                                                3
                                                            ? (widget.redeModel
                                                                        .status ==
                                                                    1)
                                                                ? Color(
                                                                    0xff093352)
                                                                : Colors.blue
                                                            : Colors.grey),
                                                  ),
                                                  onTap: () {
                                                    _controllerPontuacao1.text =
                                                        "";
                                                    _controllerPontuacao2.text =
                                                        "";
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Informe o placar"),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .grey[300],
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
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
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              height: 40,
                                                                              width: 40,
                                                                              child: TextField(
                                                                                keyboardType: TextInputType.number,
                                                                                controller: _controllerPontuacao1,
                                                                              ),
                                                                            ),
                                                                            Text(" X "),
                                                                            Container(
                                                                              height: 40,
                                                                              width: 40,
                                                                              child: TextField(
                                                                                keyboardType: TextInputType.number,
                                                                                controller: _controllerPontuacao2,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: <
                                                                              Widget>[
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
                                                                  RaisedButton(
                                                                    color: Color(
                                                                        0xff086ba4),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            15),
                                                                    child: Text(
                                                                      "Atualiza placar",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'Candal',
                                                                      ),
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      _atualizaPlacar(
                                                                          jogo.id,
                                                                          jogo.numero);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child:
                                                                    RaisedButton(
                                                                  color: Color(
                                                                      0xff086ba4),
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              15),
                                                                  child: Text(
                                                                    "Fechar",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Candal',
                                                                    ),
                                                                  ),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(2),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                )
                                              : new Padding(
                                                  padding: EdgeInsets.all(1),
                                                ),
                                          _alteraPlacar(jogo)
                                              ? new GestureDetector(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Icon(
                                                        Icons.delete_forever,
                                                        color: widget.redeModel
                                                                    .status <
                                                                3
                                                            ? (widget.redeModel
                                                                        .status ==
                                                                    1)
                                                                ? Color(
                                                                    0xff093352)
                                                                : Colors.blue
                                                            : Colors.grey),
                                                  ),
                                                  onTap: () {
                                                    _showModalRemoveJogo(
                                                        context,
                                                        "Remove jogo",
                                                        "Deseja realmente remover o jogo?",
                                                        jogo.id);
                                                  },
                                                )
                                              : new Padding(
                                                  padding: EdgeInsets.all(1),
                                                ),
                                        ]),
                                  ),
                                )
                              : new Padding(
                                  padding: EdgeInsets.all(1),
                                ),
                          Container(
                            height: 5,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text("Sem valores!!!"),
              );
            }
            break;
        }
        return new Container();
      },
    );
  }

  //APELIDO OU PRIMEIRO NOME
  String apelidoOuNome(String apelido, String nome) {
    if (apelido != null && apelido != "") {
      return apelido;
    }
    if(nome != null){
     if (nome.split(' ').length == 1) {
      return nome;
    } else if (nome.split(' ').length > 1) {
      String nomeFormatado = '${nome.split(' ')[0]}';
      return nomeFormatado;
    }
    }else{
      return '';
    }
  }

  _showOpc(BuildContext context,JogoRedeModel jogo){
    final maskPoints = MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});

    _controllerPontuacao1
        .text = "";
    _controllerPontuacao2
        .text = "";

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    child:new Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(bottom: 16,right: 16,left: 16),
                      child: SingleChildScrollView(
                        child:
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                  "Informe o placar",style: new TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                            ),
                            Container(
                              padding:
                              EdgeInsets.all(5),
                              decoration:
                              BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                  borderRadius: new BorderRadius.circular(8)
                              ),
                              child:
                              Row(
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
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: TextField(
                                          inputFormatters: [maskPoints],
                                          keyboardType: TextInputType.number,
                                          controller: _controllerPontuacao1,
                                          style: TextStyle(
                                            color: AppColors
                                                .colorPontuacaoJogos,
                                            fontSize: 14,
                                            fontFamily:
                                            FontFamily.fontSpecial,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "X",
                                        style: TextStyle(
                                          color: AppColors
                                              .colorPontuacaoJogos,
                                          fontSize: 14,
                                          fontFamily:
                                          FontFamily.fontSpecial,
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: TextField(
                                          inputFormatters: [maskPoints],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.right,
                                          controller: _controllerPontuacao2,
                                          style: TextStyle(
                                            color: AppColors
                                                .colorPontuacaoJogos,
                                            fontSize: 14,
                                            fontFamily:
                                            FontFamily.fontSpecial,
                                          ),
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
                            new Container(height: 20,),
                            RaisedButton(
                              onPressed:
                                  () {
                                _atualizaPlacar(jogo.id, jogo.numero);
                              },
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              padding:
                              const EdgeInsets.all(0.0),
                              child:
                              Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      AppColors.colorEspecialSecundario1,
                                      AppColors.colorEspecialSecundario2
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                                  // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Atualiza placar",
                                    style: TextStyle(fontSize: 16, color: AppColors.colorTextLogCad, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ),
                            new Container(height: 30,),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: AppColors.colorButtonDialog,
                                  onPressed: (){
                                    Navigator.pop(
                                        context);
                                  },
                                  child: Text('Fechar',style: new TextStyle(color: Colors.white),),
                                ),
                              ],
                            )

                            // RaisedButton(
                            //   color: Color(0xff086ba4),
                            //   textColor:
                            //   Colors.white,
                            //   padding:
                            //   EdgeInsets.all(15),
                            //   child: Text(
                            //     "Atualiza placar",
                            //     style:
                            //     TextStyle(
                            //       fontSize:
                            //       16,
                            //       fontFamily:
                            //       'Candal',
                            //     ),
                            //   ),
                            //   shape:
                            //   RoundedRectangleBorder(
                            //     borderRadius:
                            //     BorderRadius.circular(
                            //         2),
                            //   ),
                            //   onPressed:
                            //       () {
                            //     _atualizaPlacar(
                            //         jogo.id,
                            //         jogo.numero);
                            //   },
                            // ),
                          ],
                        ),
                      )
                    )
                )
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        context: context,
        pageBuilder: (context, animation1, animation2) {});

  }


// //APELIDO OU O NOME COMPLETO
// String apelidoOuNome(String apelido, String nome) {
//   if (apelido != null && apelido != "") {
//     return apelido;
//   } else if (nome.split(' ').length == 1) {
//     return nome;
//   } else {
//     String nomeFormatado =
//         '${nome.split(' ')[0]} ${nome.split(' ')[nome.split(' ').length - 1]}';
//     return nomeFormatado;
//   }
// }
}
