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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EdicaoTorneioView extends StatefulWidget {

  TorneioModel torneioModel;
  EdicaoTorneioView({this.torneioModel});

  @override
  _EdicaoTorneioViewState createState() => _EdicaoTorneioViewState();
}

class _EdicaoTorneioViewState extends State<EdicaoTorneioView> {

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

  _atualizar() async {
    try {
      String _msg = "";

      _valida();

      TorneioModel tm = TorneioModel.Edita(
        widget.torneioModel.id, _controllerNome.text, _controllerTipoTorneio, _controllerClassificacaoTorneio, _controllerGeneroTorneio,
        _controllerEntidadeTorneio, _controllerRankingEntidadeTorneio, _controllerPaisTorneio, _controllerCidade.text,
        _controllerLocal.text, _controllerDataInicio.text, _controllerDataFim.text,
        int.parse(_controllerQtdDuplas.text), _controllerMais.text
      );

      //TorneioService torneioService = TorneioService();
      //torneioService.inclui(torneioModel, ConstantesConfig.SERVICO_FIXO);

      var _url = "${ConstantesRest.URL_TORNEIOS}/atualiza";
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
        _msg = "Torneio atualizado com sucesso!!!";
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
    dialogFutt.waiting(context, "Edição de torneio", "${_mensagem}");
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

  Future<List<RankingEntidadeModel>> _listaRankingEntidadesDoUsuario() async {
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

  String _getDescricaoGenero() {
    String _descricao = "";
    if (widget.torneioModel.genero == "1") {
      _descricao = "Masculino";
    }else if (widget.torneioModel.genero == "2") {
      _descricao = "Feminino";
    }else if (widget.torneioModel.genero == "3") {
      _descricao = "Misto";
    }
    return _descricao;
  }

  _atualizaValoresIniciais(TorneioModel torneioOrigem) {
    _controllerNome.text = torneioOrigem.nome;
    _controllerTipoTorneio = torneioOrigem.idTipoTorneio;
    _controllerClassificacaoTorneio = torneioOrigem.idClassificacao;
    _controllerGeneroTorneio = torneioOrigem.genero;
    _controllerEntidadeTorneio = torneioOrigem.idEntidade;
    _controllerRankingEntidadeTorneio = torneioOrigem.idRankingEntidade;
    _controllerPaisTorneio = torneioOrigem.pais;
    PaisModel _paisModel = PaisModel(torneioOrigem.pais, torneioOrigem.pais);

    _controllerCidade.text = torneioOrigem.cidade;
    _controllerLocal.text = torneioOrigem.local;
    _controllerDataInicio.text = torneioOrigem.dataInicio;
    _controllerDataFim.text = torneioOrigem.dataFim;
    _controllerQtdDuplas.text = torneioOrigem.qtdDuplas.toString();
    _controllerMais.text = torneioOrigem.info;
  }

  @override
  Widget build(BuildContext context) {

    _atualizaValoresIniciais(widget.torneioModel);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Atualização do torneio",
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
                    "Altere os dados do torneio para atualizar",
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
                          selectedItem: TipoTorneioModel.Dropdown(widget.torneioModel.idTipoTorneio, widget.torneioModel.nomeTipoTorneio),
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
                          selectedItem: ClassificacaoTorneioModel.Dropdown(widget.torneioModel.idClassificacao, widget.torneioModel.nomeClassificacao),
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
                          selectedItem: GeneroModel(widget.torneioModel.genero, _getDescricaoGenero()),
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
                          selectedItem: RankingEntidadeModel.Dropdown(widget.torneioModel.idRankingEntidade, widget.torneioModel.descricaoRankingEntidade),
                          showSearchBox: false,
                          onFind: (String filter) => _listaRankingEntidadesDoUsuario(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (RankingEntidadeModel data) => _controllerRankingEntidadeTorneio = data.id,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<PaisModel>(
                          selectedItem: PaisModel(widget.torneioModel.pais, widget.torneioModel.pais),
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
      bottomNavigationBar: widget.torneioModel.status < 40 ? BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.grey[300],
          child: RaisedButton(
            color: Color(0xff086ba4),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "Atualizar",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: _atualizar,
          ),
        ),
      ) : null,
    );
  }
}
