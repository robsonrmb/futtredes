import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/MensalidadeView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multipart_request/multipart_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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

  File _imagem;
  bool _subindoImagem = false;

  _atualizaRede() async {
    try {
      _mensagem = "";
      if (_controllerNome.text == "") {
        throw Exception('Informe o título do rede.');
      }else if (_controllerPaisRede == "") {
        throw Exception('Informe o país de onde se realizará o rede.');
      }else if (_controllerCidade.text == "") {
        throw Exception('Informe a cidade de onde se realizará o rede.');
      }else if (int.parse(_controllerQtdIntegrantes.text) <= 0 || int.parse(_controllerQtdIntegrantes.text) > 999) {
        throw Exception('Qtd de integrantes incorreto.');
      }

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      RedeModel redeModel = RedeModel.Edita(
        widget.redeModel.id, _controllerNome.text, _controllerPaisRede, _controllerCidade.text,
        _controllerLocal.text, int.parse(_controllerQtdIntegrantes.text), _controllerMais.text
      );

      var _url = "${ConstantesRest.URL_REDE}/atualiza";
      var _dados = redeModel.toJson();

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
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 201) {
        _mensagem = "Rede atualizada com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Atualização de rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);

      }else{
        setState(() {
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
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

  Future<List<PaisModel>> _listaPaises() async {
    UtilService utilService = UtilService();
    return utilService.listaPaises();
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

  Future<RedeModel> _atualizaImagem(int idRede) async {
    RedeService redeService = RedeService();
    return redeService.buscaRedePorId(idRede, ConstantesConfig.SERVICO_FIXO);
  }

  _showModalAtualizaImagem(BuildContext context, String title, String description, int idRede){
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
                  _recuperaImagem("galeria", idRede),
                  Navigator.pop(context),
                },
                child: Text("Galeria"),
              ),
              FlatButton(
                onPressed: () => {
                  _recuperaImagem("camera", idRede),
                  Navigator.pop(context),
                },
                child: Text("Câmera"),
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text("Cancelar"),
              )
            ],
          );
        }
    );
  }

  _recuperaImagem(String origemImagem, int idRede) async {
    File _imagemSelecionada;
    switch (origemImagem) {
      case "camera" :
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria" :
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }
    setState(() {
      _imagem = _imagemSelecionada;
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem(idRede);
      }
    });
  }

  Future<List<RedeModel>> _uploadImagem(int idRede) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);
    var _url = "${ConstantesRest.URL_REDE}/${idRede}/imagem";
    _sendRequest(_url, token);
  }

  void _sendRequest(_url, token) {

    var request = MultipartRequest();

    request.setUrl(_url);
    request.addFile("file", _imagem.path);
    request.addHeaders({
      //'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    });

    Response response = request.send();
    try {
      print(response);
    } on Exception catch (exception) {
      print(exception);
    } catch (error) {
      print(error);
    }

    response.onError = () {
      setState(() {
        _subindoImagem = false;
      });
    };

    response.onComplete = (response) {
      setState(() {
        _subindoImagem = false;
        _atualizaImagem(widget.redeModel.id);
      });
      print("Buscar imagem via http");
    };

    response.progress.listen((int progress) {
      setState(() {
        _subindoImagem = true;
      });
    });

    setState(() {
      _subindoImagem = true;
    });
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
                    "Atualização de dados",
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                ),
                _subindoImagem
                    ? CircularProgressIndicator()
                    : Container(),
                FutureBuilder<RedeModel>(
                  future: _atualizaImagem(widget.redeModel.id),
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

                          RedeModel redeRetorno = snapshot.data;

                          return GestureDetector(
                            child: Container(
                              height: redeRetorno.nomeFoto == "semImagem.png" ? 50 : 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300].withOpacity(0.5),
                                  image: DecorationImage(
                                      image: NetworkImage(ConstantesRest.URL_BASE_AMAZON + redeRetorno.nomeFoto),
                                      fit: BoxFit.fill
                                  ),
                                  //borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[300],
                                  )
                              ),
                            ),
                            onTap: () {
                              _showModalAtualizaImagem(context, "Imagem", "Buscar imagem de qual origem?", widget.redeModel.id);
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
