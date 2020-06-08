import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ClassificacaoTorneioModel.dart';
import 'package:futt/futt/model/RankingEntidadeModel.dart';
import 'package:futt/futt/model/TipoTorneioModel.dart';
import 'package:futt/futt/model/TorneioModel.dart';
import 'package:futt/futt/model/utils/GeneroModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/ClassificacaoTorneioService.dart';
import 'package:futt/futt/service/GeneroService.dart';
import 'package:futt/futt/service/PaisService.dart';
import 'package:futt/futt/service/RankingEntidadeService.dart';
import 'package:futt/futt/service/TipoTorneioService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NovoTorneioView extends StatefulWidget {
  @override
  _NovoTorneioViewState createState() => _NovoTorneioViewState();
}

class _NovoTorneioViewState extends State<NovoTorneioView> {

  String _mensagem = "";
  TextEditingController _controllerNome = TextEditingController();
  int _controllerTipoTorneio = 0;
  int _controllerClassificacaoTorneio = 0;
  String _controllerGeneroTorneio = "";
  int _controllerEntidadeTorneio = 0;
  int _controllerRankingEntidadeTorneio = 0;
  String _controllerPaisTorneio = "";
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();
  TextEditingController _controllerDataInicio = TextEditingController();
  TextEditingController _controllerDataFim = TextEditingController();
  TextEditingController _controllerQtdDuplas = TextEditingController();
  TextEditingController _controllerMais = TextEditingController();

  void _cadastrar(BuildContext context) async {
    try {
      String _msg = "";

      _valida();

      //Grava torneios
      TorneioModel torneioModel = TorneioModel.Novo(
          _controllerNome.text, _controllerTipoTorneio, _controllerClassificacaoTorneio, _controllerGeneroTorneio,
          _controllerEntidadeTorneio, _controllerRankingEntidadeTorneio, _controllerPaisTorneio, _controllerCidade.text,
          _controllerLocal.text, _controllerDataInicio.text, _controllerDataFim.text,
          int.parse(_controllerQtdDuplas.text), _controllerMais.text
      );
      //TorneioService torneioService = TorneioService();
      //torneioService.inclui(torneioModel, ConstantesConfig.SERVICO_FIXO);

      var _url = "${ConstantesRest.URL_TORNEIOS}/adiciona";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts";
        _dados = jsonEncode({ 'userId': 200, 'id': 200, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      http.Response response = await http.post(_url,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
          body: _dados
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _msg = "Torneio inserido com sucesso!!!";
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

    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.waiting(context, "Novo torneio", "${_mensagem}");
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }

  void _valida() {
    if (_controllerNome.text == "") {
      throw Exception('Informe o título do torneio.');
    }else if (_controllerTipoTorneio == 0) {
      throw Exception('Informe o tipo de torneio.');
    }else if (_controllerClassificacaoTorneio == 0) {
      throw Exception('Informe a classificação do torneio.');
    }else if (_controllerPaisTorneio == "") {
      throw Exception('Informe o país de onde se realizará o torneio.');
    }else if (_controllerCidade.text == "") {
      throw Exception('Informe a cidade de onde se realizará o torneio.');
    }else if (_controllerDataInicio.text == "") {
      throw Exception('Informe a data de início do torneio.');
    }else if (_controllerDataFim.text == "") {
      throw Exception('Informe a data fim do torneio.');
    }else{
      if (_controllerTipoTorneio == 1) {
        if (_controllerQtdDuplas.text != "16" && _controllerQtdDuplas.text != "32") {
          throw Exception('Qtd de duplas para tipo de torneio: 16 ou 32.');
        }
      }else if (_controllerTipoTorneio == 2) {
        if (_controllerQtdDuplas.text != "4" && _controllerQtdDuplas.text != "8" && _controllerQtdDuplas.text != "16") {
          throw Exception('Qtd de duplas para tipo de torneio: 4, 8 ou 16.');
        }
      }else if (_controllerTipoTorneio == 3) {
        if (_controllerQtdDuplas.text != "0" && _controllerQtdDuplas.text != "") {
          throw Exception('Para torneios em grupo não informe a qtd de duplas.');
        }
      }
    }
  }

  Future<List<TipoTorneioModel>> _listaTipoTorneios() async {
    TipoTorneioService resultadoService = TipoTorneioService();
    return resultadoService.listaTodos(ConstantesConfig.SERVICO_FIXO);
  }

  Future<List<RankingEntidadeModel>> _listaEntidadesDoUsuario() async {
    RankingEntidadeService rankingEntidadeService = RankingEntidadeService();
    return rankingEntidadeService.listaPorUsuario(ConstantesConfig.SERVICO_FIXO);
  }

  Future<List<ClassificacaoTorneioModel>> _listaClassificacaoTorneios() async {
    ClassificacaoTorneioService classificacaoTorneioService = ClassificacaoTorneioService();
    return classificacaoTorneioService.listaTodos(ConstantesConfig.SERVICO_FIXO);
  }

  Future<List<PaisModel>> _listaPaises() async {
    PaisService paisService = PaisService();
    return paisService.listaPaises();
  }

  Future<List<GeneroModel>> _listaGeneros() async {
    GeneroService generoService = GeneroService();
    return generoService.listaGeneros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Cadastro de torneios",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Insira os dados do torneio para cadastrar",
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg'),
                  radius: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Logo do Torneio",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.done_all,
                              color: Colors.black,
                            ),
                            // icon: new Icon(Icons.person),
                            // prefixText: "Nome",
                            // prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                            // labelText: "Informe seu nome",
                            hintText: "Nome do torneio",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.w300,
                              color: Colors.grey[400],
                            ),
                            /* border: OutlineInputBorder(
                              gapPadding: 5,
                            ),*/
                          ),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                          //maxLength: 5,
                          //maxLengthEnforced: true,
                          controller: _controllerNome,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<TipoTorneioModel>(
                          onFind: (String filter) => _listaTipoTorneios(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (TipoTorneioModel data) => _controllerTipoTorneio = data.id,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<ClassificacaoTorneioModel>(
                          showSearchBox: false,
                          onFind: (String filter) => _listaClassificacaoTorneios(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (ClassificacaoTorneioModel data) => _controllerClassificacaoTorneio = data.id,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<GeneroModel>(
                          showSearchBox: false,
                          onFind: (String filter) => _listaGeneros(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (GeneroModel data) => _controllerGeneroTorneio = data.id,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<RankingEntidadeModel>(
                          showSearchBox: false,
                          onFind: (String filter) => _listaEntidadesDoUsuario(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (RankingEntidadeModel data) => _controllerEntidadeTorneio = data.id,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<PaisModel>(
                          showSearchBox: false,
                          onFind: (String filter) => _listaPaises(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (PaisModel data) => _controllerPaisTorneio = data.id,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Cidade",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          /* border: OutlineInputBorder(
                                    gapPadding: 1,
                                  ),*/
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
                        //maxLength: 100,
                        //maxLengthEnforced: true,
                        controller: _controllerCidade,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Local",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          /* border: OutlineInputBorder(
                                    gapPadding: 1,
                                  ),*/
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
                        //maxLength: 100,
                        //maxLengthEnforced: true,
                        controller: _controllerLocal,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Data Início",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                  /* border: OutlineInputBorder(
                                    gapPadding: 1,
                                  ),*/
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                                maxLength: 10,
                                //maxLengthEnforced: true,
                                controller: _controllerDataInicio,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Data fim",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                  /* border: OutlineInputBorder(
                                    gapPadding: 1,
                                  ),*/
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                                maxLength: 10,
                                //maxLengthEnforced: true,
                                controller: _controllerDataFim,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "32, 16, 8 ou 4",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                  /* border: OutlineInputBorder(
                                    gapPadding: 1,
                                  ),*/
                                ),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                                maxLength: 2,
                                //maxLengthEnforced: true,
                                controller: _controllerQtdDuplas,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                width: 1.0,
                              color: Colors.grey[400],
                            )
                        ),
                        child: TextField(
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration.collapsed(
                            hintText: "Observação",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                          controller: _controllerMais,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            _mensagem,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Candal'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.grey[300],
          child: RaisedButton(
            color: Color(0xff086ba4),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "Cadastrar",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () {
              _cadastrar(context);
            },
          ),
        ),
      )
    );
  }

}
