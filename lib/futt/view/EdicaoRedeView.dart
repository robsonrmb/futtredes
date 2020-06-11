import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/PaisService.dart';
import 'package:futt/futt/view/MensalidadeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EdicaoRedeView extends StatefulWidget {

  RedeModel redeModel;
  EdicaoRedeView({this.redeModel});

  @override
  _EdicaoRedeViewState createState() => _EdicaoRedeViewState();
}

class _EdicaoRedeViewState extends State<EdicaoRedeView> {

  String _mensagem = "";
  TextEditingController _controllerNome = TextEditingController();
  String _controllerPaisRede = "";
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();
  TextEditingController _controllerQtdIntegrantes = TextEditingController();
  TextEditingController _controllerMais = TextEditingController();

  _atualizaRede() async {
    try {
      String _msg = "";

      _valida();

      RedeModel tm = RedeModel.Edita(
        widget.redeModel.id, _controllerNome.text, _controllerPaisRede, _controllerCidade.text,
        _controllerLocal.text, int.parse(_controllerQtdIntegrantes.text), _controllerMais.text
      );

      //RedeService redeService = RedeService();
      //redeService.inclui(redeModel, ConstantesConfig.SERVICO_FIXO);

      var _url = "${ConstantesRest.URL_REDE}/atualiza";
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
        _msg = "Rede atualizada com sucesso!!!";
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
    dialogFutt.waiting(context, "Edição de rede", "${_mensagem}");
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }

  void _valida() {
    if (_controllerNome.text == "") {
      throw Exception('Informe o título do rede.');
    }else if (_controllerPaisRede == "") {
      throw Exception('Informe o país de onde se realizará o rede.');
    }else if (_controllerCidade.text == "") {
      throw Exception('Informe a cidade de onde se realizará o rede.');
    }else if (int.parse(_controllerQtdIntegrantes.text) <= 0 || int.parse(_controllerQtdIntegrantes.text) > 999) {
      throw Exception('Qtd de integrantes incorreto.');
    }
  }

  Future<List<PaisModel>> _listaPaises() async {
    PaisService paisService = PaisService();
    return paisService.listaPaises();
  }

  _atualizaValoresIniciais(RedeModel redeOrigem) {
    _controllerNome.text = redeOrigem.nome;
    _controllerPaisRede = redeOrigem.pais;
    PaisModel _paisModel = PaisModel(redeOrigem.pais, redeOrigem.pais);
    _controllerCidade.text = redeOrigem.cidade;
    _controllerLocal.text = redeOrigem.local;
    _controllerQtdIntegrantes.text = redeOrigem.qtdIntegrantes.toString();
    _controllerMais.text = redeOrigem.info;
  }

  @override
  Widget build(BuildContext context) {

    _atualizaValoresIniciais(widget.redeModel);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        backgroundColor: Color(0xff093352),
        textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 20
            )
        ),
        title: Text("Edição de redes"),
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
                    "Altere os dados do rede para atualizar",
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
                    "Imagem da Rede",
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
                            hintText: "Nome da rede",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                            /*prefixIcon: Icon(
                              Icons.done_all,
                              color: Colors.black,
                            ),*/
                            // icon: new Icon(Icons.done_all),
                            // prefixText: "Nome",
                            // prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                            // labelText: "Informe seu nome",
                            /* border: OutlineInputBorder(
                              gapPadding: 5,
                            ),*/
                          ),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                          controller: _controllerNome,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<PaisModel>(
                          showSearchBox: true,
                          selectedItem: PaisModel(widget.redeModel.pais, widget.redeModel.pais),
                          onFind: (String filter) => _listaPaises(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                            icon: new Icon(Icons.monetization_on),
                            labelText: "País",
                          ),
                          onChanged: (PaisModel data) => _controllerPaisRede = data.id,
                          showClearButton: false,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Lisboa",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          // icon: new Icon(Icons.location_city),
                          /* border: OutlineInputBorder(
                                    gapPadding: 1,
                                  ),*/
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
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
                          hintText: "Cascais - Praia dos pescadores",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
                        controller: _controllerLocal,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "20",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          // icon: new Icon(Icons.monetization_on),
                          suffixIcon: Icon(
                            Icons.monetization_on,
                            color: Colors.black,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black
                        ),
                        //maxLength: 3,
                        //maxLengthEnforced: true,
                        controller: _controllerQtdIntegrantes,
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MensalidadeView(),
                          ))
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
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
      bottomNavigationBar: widget.redeModel.status == 2 ? BottomAppBar(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.grey[300],
          child: RaisedButton(
            color: Color(0xff086ba4),
            textColor: Colors.white,
            padding: EdgeInsets.all(15),
            child: Text(
              "Atualiza",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Candal',
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            onPressed: () {
              _atualizaRede();
            },
          ),
        ),
      ) : null,
    );
  }
}
