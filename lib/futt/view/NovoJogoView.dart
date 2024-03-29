import 'dart:collection';
import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/rendering.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/IntegranteService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/SearchDelegateUsuariosDaRede.dart';
import 'package:futt/futt/view/components/collection.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

class NovoJogoView extends StatefulWidget {
  RedeModel? redeModel;

  NovoJogoView(this.redeModel);

  @override
  _NovoJogoViewState createState() => _NovoJogoViewState();
}

class _NovoJogoViewState extends State<NovoJogoView> {
  String? _mensagem = "";
  TextEditingController _controllerEmailJogador1 = TextEditingController();
  TextEditingController _controllerEmailJogador2 = TextEditingController();
  TextEditingController _controllerEmailJogador3 = TextEditingController();
  TextEditingController _controllerEmailJogador4 = TextEditingController();


  TextEditingController _controllerPontuacao1 = TextEditingController();
  TextEditingController _controllerPontuacao2 = TextEditingController();


  String _resultadoJogador1 = "";
  String _resultadoJogador2 = "";
  String _resultadoJogador3 = "";
  String _resultadoJogador4 = "";
  Future<List<IntegranteModel>>? _integrantes;
  GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key3 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key4 = new GlobalKey();
  List<IntegranteModel>? integrantesList = [];
  String currentText = '';

  Future<List<IntegranteModel>?> _listaIntegrantes() async {
    IntegranteService resultadoService = IntegranteService();
    return resultadoService.listaIntegrantesDaRede(widget.redeModel!.id); //0 para retorno fixo (jogar fora)
  }

  String? _buscaEmailDaLista(String valor, List<IntegranteModel> lista) {
    String? retorno = "";
    for (IntegranteModel _im in lista) {
      if (_im.nome == valor) {
        retorno = _im.email;
        break;
      }
    }
    return retorno;
  }

  _cadastraJogo(BuildContext context, List<IntegranteModel>? integrantes) async {
    circularProgress(context);

    try {
      _mensagem = "";
      if (_controllerEmailJogador1.text == "" ||
          _controllerEmailJogador2.text == "" ||
          _controllerEmailJogador3.text == "" ||
          _controllerEmailJogador4.text == "") {
        _mensagem = 'Informe o email dos jogadores.';
      } else {
        HashMap<String, String> hashMap = new HashMap<String, String>();
        Map<String, String> map = {
          _controllerEmailJogador1.text: '_controllerEmailJogador1.text',
          _controllerEmailJogador2.text: '_controllerEmailJogador2.text',
          _controllerEmailJogador3.text: '_controllerEmailJogador3.text',
          _controllerEmailJogador4.text: '_controllerEmailJogador4.text',
        };
        if (map.length < 4) {
          _resultadoJogador1 = _controllerEmailJogador1.text;
          _resultadoJogador2 = _controllerEmailJogador2.text;
          _resultadoJogador3 = _controllerEmailJogador3.text;
          _resultadoJogador4 = _controllerEmailJogador4.text;
          _mensagem = 'Atleta duplicado. Confira os jogos!!!';
        }
      }

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
        throw Exception(_mensagem);
      }

      String email1Compara = '';
      String email2Compara = '';
      String email3Compara = '';
      String email4Compara = '';

      if (_controllerEmailJogador1.text.contains('(')) {
        email1Compara = _controllerEmailJogador1.text
            .split('(')
            .last;
        email1Compara = email1Compara
            .split(')')
            .first;
      } else {
        email1Compara = _controllerEmailJogador1.text;
      }

      if (_controllerEmailJogador2.text.contains('(')) {
        email2Compara = _controllerEmailJogador2.text
            .split('(')
            .last;
        email2Compara = email2Compara
            .split(')')
            .first;
      } else {
        email2Compara = _controllerEmailJogador2.text;
      }

      if (_controllerEmailJogador3.text.contains('(')) {
        email3Compara = _controllerEmailJogador3.text
            .split('(')
            .last;
        email3Compara = email3Compara
            .split(')')
            .first;
      } else {
        email3Compara = _controllerEmailJogador3.text;
      }

      if (_controllerEmailJogador4.text.contains('(')) {
        email4Compara = _controllerEmailJogador4.text
            .split('(')
            .last;
        email4Compara = email4Compara
            .split(')')
            .first;
      } else {
        email4Compara = _controllerEmailJogador4.text;
      }


      String? email1 = _controllerEmailJogador1.text;
      String? email2 = _controllerEmailJogador2.text;

      String? email3 = _controllerEmailJogador3.text;
      String? email4 = _controllerEmailJogador4.text;

      for (int i = 0; i < integrantesList!.length; i++) {
        if (email1Compara == integrantesList![i].user) {
          email1 = integrantesList![i].email;
        }
        if (email2Compara == integrantesList![i].user) {
          email2 = integrantesList![i].email;
        }
        if (email3Compara == integrantesList![i].user) {
          email3 = integrantesList![i].email;
        }
        if (email4Compara == integrantesList![i].user) {
          email4 = integrantesList![i].email;
        }
      }

      int pontuacao1 = 0;
      int pontuacao2 = 0;


      if(_controllerPontuacao1.text.isNotEmpty){
        pontuacao1 = int.parse(_controllerPontuacao1.text);
      }

      if(_controllerPontuacao2.text.isNotEmpty){
        pontuacao2 = int.parse(_controllerPontuacao2.text);
      }


      JogoRedeModel jogoRedeModel = JogoRedeModel.NovoJogo(
        widget.redeModel!.id,
        pontuacao1,
        pontuacao2,
        email1,
        email2,
        email3,
        email4,
      );

      var _url = "${ConstantesRest.URL_JOGO_REDE}/adicionaporemail";
      var _dados = jogoRedeModel.toJson();

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

      http.Response response = await http.post(Uri.parse(_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados));
      Navigator.pop(context);
      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Jogo incluído com sucesso!!!";
        });

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Jogo", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        ExceptionModel exceptionModel = ExceptionModel.fromJson(dadosJson);
        _mensagem = exceptionModel.msg;
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Jogo", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
      }
    } on Exception catch (exception) {
      print(exception.toString());
        _mensagem = exception.toString();
    } catch (error) {
      setState(() {
        _mensagem = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmailJogador1.text = _resultadoJogador1;
    _controllerEmailJogador2.text = _resultadoJogador2;
    _controllerEmailJogador3.text = _resultadoJogador3;
    _controllerEmailJogador4.text = _resultadoJogador4;

    final maskPoints = MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});
    _controllerPontuacao1.text = "0";
    _controllerPontuacao2.text = "0";

    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    AppColors.colorFundoClaroApp,
                    AppColors.colorFundoEscuroApp
                  ])),
        ),
        title: Text(
          "Cadastro de Jogos",
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.colorTextAppNav,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfff7f7f7),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<IntegranteModel>?>(
            future: _listaIntegrantes(),
            builder: (context, snapshot) {
              List<String> listIntegrantes = [];

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                // color: Colors.black12,
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5)
                            ]),
                        child: Column(
                          children: <Widget>[
                            new Container(
                              height: 5,
                              decoration: new BoxDecoration(
                                //color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                ),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    AppColors.colorEspecialPrimario1,
                                    AppColors.colorEspecialPrimario2
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 20,
                                    width: 100,
                                    decoration: new BoxDecoration(
                                      //shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 16,
                                    width: 89,
                                    decoration: new BoxDecoration(
                                      //shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 16,
                                    width: 89,
                                    decoration: new BoxDecoration(
                                      //shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      rowsLoad('Jogador 1'),
                      rowsLoad('Jogador 2'),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 26),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.deepOrange),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                "X",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: widget.redeModel!.status! < 3
                                        ? (widget.redeModel!.status == 1)
                                        ? Colors.lightBlue
                                        : Colors.deepOrange
                                        : Colors.grey[800]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      rowsLoadExp('Jogador 3'),
                      rowsLoad('Jogador 4'),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            _mensagem!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: FontFamily.fontSpecial,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    List<IntegranteModel> integrantes = snapshot.data!;
                    integrantesList = snapshot.data;
                    List<String?> _integrantes = [];

                    for (IntegranteModel _im in integrantes) {
                      _integrantes.add(_im.nome);
                      if (_im.apelido != null) {
                        listIntegrantes
                            .add('${_im.apelido ?? ""}(${_im.user ?? ""})');
                      } else {
                        listIntegrantes.add(_im.user ?? "");
                      }
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  // color: Colors.black12,
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            children: <Widget>[
                              new Container(
                                height: 5,
                                decoration: new BoxDecoration(
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      AppColors.colorEspecialPrimario1,
                                      AppColors.colorEspecialPrimario2
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                                child: Text(
                                  "${widget.redeModel!.nome}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: FontFamily.fontSpecial,
                                      color: widget.redeModel!.status! < 3
                                          ? (widget.redeModel!.status == 1)
                                          ? Color(0xff093352)
                                          : Color(0xFF0D47A1)
                                          : Colors.grey[800]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1),
                                child: Text(
                                  "${widget.redeModel!.pais} - ${widget.redeModel!
                                      .cidade}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: widget.redeModel!.status! < 3
                                          ? (widget.redeModel!.status == 1)
                                          ? Color(0xff093352)
                                          : Color(0xFF0D47A1)
                                          : Colors.grey[800]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                child: Text(
                                  "${widget.redeModel!.local}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: widget.redeModel!.status! < 3
                                          ? (widget.redeModel!.status == 1)
                                          ? Color(0xff093352)
                                          : Color(0xFF0D47A1)
                                          : Colors.grey[800]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        rows('Jogador 1', '', _controllerEmailJogador1,
                            listIntegrantes, key1),
                        rows('Jogador 2', '', _controllerEmailJogador2,
                            listIntegrantes, key2),
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 26,right: 16),
                                width: 70,
                                height: 45,
                                //padding: EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),

                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        // color: Colors.black12,
                                          color: Colors.black12,
                                          blurRadius: 5)
                                    ]),
                                child:
                                new Row(
                                  children: [
                                    new Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [maskPoints],
                                        controller: _controllerPontuacao1,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          //hintText: hint,
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily:
                                          FontFamily.fontSpecial,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              margin: const EdgeInsets.only(top: 26),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.deepOrange),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  "X",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: widget.redeModel!.status! < 3
                                          ? (widget.redeModel!.status == 1)
                                          ? Colors.lightBlue
                                          : Colors.deepOrange
                                          : Colors.grey[800]),
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 26,left: 16),
                                width: 70,
                                height: 45,
                                //padding: EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),

                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        // color: Colors.black12,
                                          color: Colors.black12,
                                          blurRadius: 5)
                                    ]),
                                child:
                                new Row(
                                  children: [
                                    new Expanded(
                                      child: TextField(
                                        inputFormatters: [maskPoints],
                                        controller: _controllerPontuacao2,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          //hintText: hint,
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily:
                                          FontFamily.fontSpecial,
                                        ),
                                      ),

                                    ),
                                  ],
                                )),
                          ],
                        ),
                        rows('Jogador 3', '', _controllerEmailJogador3,
                            listIntegrantes, key3),
                        rows('Jogador 4', '', _controllerEmailJogador4,
                            listIntegrantes, key4),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //   child: GestureDetector(
                        //     child: TextField(
                        //       keyboardType: TextInputType.text,
                        //       decoration: InputDecoration(
                        //         labelText: "Email do jogador 1 (CLIQUE 2X)",
                        //         labelStyle: TextStyle(
                        //           color: Colors.grey[600],
                        //         ),
                        //         filled: true,
                        //         fillColor: Colors.grey[300],
                        //         border: OutlineInputBorder(
                        //           gapPadding: 10,
                        //         ),
                        //       ),
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           color: Colors.black
                        //       ),
                        //       controller: _controllerEmailJogador1,
                        //     ),
                        //     onDoubleTap: () async {
                        //       String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                        //       valor = _buscaEmailDaLista(valor, integrantes);
                        //       setState(() {
                        //         _resultadoJogador1 = valor;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //   child: GestureDetector(
                        //     child: TextField(
                        //       keyboardType: TextInputType.text,
                        //       decoration: InputDecoration(
                        //         labelText: "Email do jogador 2 (CLIQUE 2X)",
                        //         labelStyle: TextStyle(
                        //           color: Colors.grey[600],
                        //         ),
                        //         filled: true,
                        //         fillColor: Colors.grey[300],
                        //         border: OutlineInputBorder(
                        //           gapPadding: 10,
                        //         ),
                        //       ),
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           color: Colors.black
                        //       ),
                        //       controller: _controllerEmailJogador2,
                        //     ),
                        //     onDoubleTap: () async {
                        //       String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                        //       valor = _buscaEmailDaLista(valor, integrantes);
                        //       setState(() {
                        //         _resultadoJogador2 = valor;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Container(
                        //   height: 40, width: 40,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(50),
                        //   ),
                        //   child: Center(
                        //     child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: <Widget>[
                        //           Text("X",
                        //             style: TextStyle(
                        //                 fontSize: 24,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: widget.redeModel.status < 3 ? (widget.redeModel.status == 1) ? Colors.lightBlue: Colors.green : Colors.grey[800]
                        //             ),
                        //           ),
                        //         ]
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //   child: GestureDetector(
                        //     child: TextField(
                        //       keyboardType: TextInputType.text,
                        //       decoration: InputDecoration(
                        //         labelText: "Email do jogador 3 (CLIQUE 2X)",
                        //         labelStyle: TextStyle(
                        //           color: Colors.grey[600],
                        //         ),
                        //         filled: true,
                        //         fillColor: Colors.grey[300],
                        //         border: OutlineInputBorder(
                        //           gapPadding: 10,
                        //         ),
                        //       ),
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           color: Colors.black
                        //       ),
                        //       controller: _controllerEmailJogador3,
                        //     ),
                        //     onDoubleTap: () async {
                        //       String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                        //       valor = _buscaEmailDaLista(valor, integrantes);
                        //       setState(() {
                        //         _resultadoJogador3 = valor;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //   child: GestureDetector(
                        //     child: TextField(
                        //       keyboardType: TextInputType.text,
                        //       decoration: InputDecoration(
                        //         labelText: "Email do jogador 4 (CLIQUE 2X)",
                        //         labelStyle: TextStyle(
                        //           color: Colors.grey[600],
                        //         ),
                        //         filled: true,
                        //         fillColor: Colors.grey[300],
                        //         border: OutlineInputBorder(
                        //           gapPadding: 10,
                        //         ),
                        //       ),
                        //       style: TextStyle(
                        //           fontSize: 16,
                        //           color: Colors.black
                        //       ),
                        //       controller: _controllerEmailJogador4,
                        //     ),
                        //     onDoubleTap: () async {
                        //       String valor = await showSearch(context: context, delegate: SearchDelegateUsuariosDaRede(_integrantes));
                        //       valor = _buscaEmailDaLista(valor, integrantes);
                        //       setState(() {
                        //         _resultadoJogador4 = valor;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 15),
                        //   child: Center(
                        //     child: Text(
                        //       _mensagem,
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 12,
                        //         fontFamily: FontFamily.fontSpecial,
                        //
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("Sem valores!!!"),
                    );
                  }
                  break;
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 60,
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Color(0xfff7f7f7),
          child: widget.redeModel!.status == 1 || widget.redeModel!.status == 2
              ? ElevatedButton(
            onPressed: () {
              _cadastraJogo(context, integrantesList);
            },

            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.all(0.0),
            ),

            child: Ink(
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
                constraints:
                const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                // min sizes for Material buttons
                alignment: Alignment.center,
                child: Text(
                  "Cadastrar jogo",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.colorTextLogCad,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          // RaisedButton(
          //   color: Color(0xff086ba4),
          //   textColor: Colors.white,
          //   padding: EdgeInsets.all(15),
          //   child: Text(
          //     "Cadastrar jogo",
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontFamily: 'Candal',
          //     ),
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(2),
          //   ),
          //   onPressed: () {
          //     _cadastraJogo();
          //   },
          // )

              : ElevatedButton(


            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.all(15),
            ),
            child: Text(
              "REDE FECHADA OU DESATIVADA",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: FontFamily.fontSpecial,
              ),
            ),

            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget rowsExp(String title,
      String hint,
      TextEditingController controller,
      List<String> integrantes,
      GlobalKey<AutoCompleteTextFieldState<String>> key) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
              //height: 60,
              //width: MediaQuery.of(context).size.width,

              margin: const EdgeInsets.only(top: 8, right: 14, left: 14),
              // padding: const EdgeInsets.only(left: 6),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    //color: Colors.red,
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: new Text(
                      title,
                      style: TextStyle(
                          color: Color(0xff112841),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding:
                    EdgeInsets.only(top: 14, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black12,
                              color: Colors.black12,
                              blurRadius: 5)
                        ]),
                    child: SimpleAutoCompleteTextField(
                      key: key,
                      controller: controller,
                      suggestions: integrantes,
                      minLength: 0,
                      suggestionsAmount: integrantes.length,
                      clearOnSubmit: false,
                      textSubmitted: (sugesstion) {
                        //_view.encontrarIdEspecialidade(sugesstion);
                      },
                      decoration: new InputDecoration.collapsed(
                          hintText: hint,
                          hintStyle: new TextStyle(fontFamily: 'Lato')),
                      textChanged: (text) => currentText = text,
                    ),
                    // TextField(
                    //   controller: controller,
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     hintText: hint,
                    //   ),
                    // ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget rows(String title,
      String hint,
      TextEditingController controller,
      List<String> integrantes,
      GlobalKey<AutoCompleteTextFieldState<String>> key) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
              //height: 60,
              //width: MediaQuery.of(context).size.width,

              margin: const EdgeInsets.only(top: 16, right: 14, left: 14),
              // padding: const EdgeInsets.only(left: 6),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    //color: Colors.red,
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: new Text(
                      title,
                      style: TextStyle(
                          color: Color(0xff112841),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Collection(
                    lista: integrantes,
                    controller: controller,
                    titulo: 'Bucar Jogador',
                    onChange: (value) {
                      controller.text = value!;
                    },
                  )
                  // Container(
                  //     //width: MediaQuery.of(context).size.width/1.2,
                  //     height: 45,
                  //     padding: EdgeInsets.only(left: 16),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.only(
                  //           topRight: Radius.circular(40),
                  //           bottomLeft: Radius.circular(8),
                  //           topLeft: Radius.circular(8),
                  //           bottomRight: Radius.circular(40),
                  //
                  //         ),
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           BoxShadow(
                  //               // color: Colors.black12,
                  //               color: Colors.black12,
                  //               blurRadius: 5)
                  //         ]),
                  //     child:
                  //         // SimpleAutoCompleteTextField(
                  //         //   key: key,
                  //         //   controller: controller,
                  //         //   suggestions: integrantes,minLength: 0,
                  //         //   clearOnSubmit: false,
                  //         //   suggestionsAmount: integrantes.length,
                  //         //   textSubmitted: (sugesstion) {
                  //         //     //_view.encontrarIdEspecialidade(sugesstion);
                  //         //   },
                  //         //   decoration: new InputDecoration.collapsed(
                  //         //       hintText: hint,
                  //         //       hintStyle: new TextStyle(fontFamily: 'Lato')),
                  //         //   textChanged: (text) => currentText = text,
                  //         // ),
                  //         new Row(
                  //       children: [
                  //         new Expanded(
                  //           flex: 85,
                  //           child: TextField(
                  //             controller: controller,
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: hint,
                  //             ),
                  //           ),
                  //         ),
                  //         new Expanded(
                  //           flex: 15,
                  //           child: new GestureDetector(
                  //             onTap: (){
                  //
                  //             },
                  //             child: new Container(
                  //                 height: 40,
                  //                 width: 40,
                  //                 padding: const EdgeInsets.all(8),
                  //                 decoration: new BoxDecoration(
                  //                     gradient: LinearGradient(begin: Alignment.topLeft,
                  //                         end: Alignment.bottomRight,
                  //                         colors: <Color>[
                  //                           AppColors.colorEspecialPrimario1,
                  //                           AppColors.colorEspecialPrimario2,
                  //                         ]),
                  //                     shape: BoxShape.circle
                  //                 ),
                  //                 child: new Center(
                  //                   child: Icon(Icons.search,color: Colors.white,),
                  //                 )
                  //             ),
                  //           )
                  //         ),
                  //       ],
                  //     ))
                ],
              ),
            )),
      ],
    );
  }

  Widget rowsLoadExp(String title) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
              //height: 60,
              //width: MediaQuery.of(context).size.width,

              margin: const EdgeInsets.only(top: 8, right: 14, left: 14),
              // padding: const EdgeInsets.only(left: 6),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    //color: Colors.red,
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: new Text(
                      title,
                      style: TextStyle(
                          color: Color(0xff112841),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding:
                    EdgeInsets.only(top: 14, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black12,
                              color: Colors.black12,
                              blurRadius: 5)
                        ]),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          height: 30,
                          decoration: new BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        )),
                    // TextField(
                    //   controller: controller,
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     hintText: hint,
                    //   ),
                    // ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget rowsLoad(String title) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
              //height: 60,
              //width: MediaQuery.of(context).size.width,

              margin: const EdgeInsets.only(top: 16, right: 14, left: 14),
              // padding: const EdgeInsets.only(left: 6),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    //color: Colors.red,
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: new Text(
                      title,
                      style: TextStyle(
                          color: Color(0xff112841),
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding:
                    EdgeInsets.only(top: 14, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black12,
                              color: Colors.black12,
                              blurRadius: 5)
                        ]),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          height: 30,
                          decoration: new BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        )),
                    // TextField(
                    //   controller: controller,
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     hintText: hint,
                    //   ),
                    // ),
                  )
                ],
              ),
            ))
      ],
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
