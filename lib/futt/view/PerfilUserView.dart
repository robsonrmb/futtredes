import 'package:flutter/material.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/model/utils/GeneroModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/model/utils/PosicionamentoModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multipart_request/multipart_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PerfilUserView extends StatefulWidget {

  UsuarioModel usuarioModel;
  PerfilUserView({this.usuarioModel});

  @override
  _PerfilUserViewState createState() => _PerfilUserViewState();
}

class _PerfilUserViewState extends State<PerfilUserView> {

  String _mensagem = "";
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerConfirmSenha = TextEditingController();

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerApelido = TextEditingController();
  TextEditingController _controllerDataNascimento = TextEditingController();
  String _controllerPosicionamento = "";
  String _controllerSexo = "";
  String _controllerPais = "";
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();

  PaisModel paisModelSelecionado;
  GeneroModel generoModelSelecionado;
  PosicionamentoModel posicionamentoModelSelecionado;

  File _imagem;
  bool _subindoImagem = false;
  String _nomeImagem = "";

  _salvaNovaSenha() async {
    try {
      if (_controllerSenha.text == "" || _controllerConfirmSenha.text == "" || _controllerSenha.text != _controllerConfirmSenha.text) {
        setState(() {
          _mensagem = "Senha e confirmação da senha devem ser iguais.";
        });
      }else{
        final prefs = await SharedPreferences.getInstance();
        String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);
        String email = await prefs.getString(ConstantesConfig.PREFERENCES_EMAIL);

        UsuarioModel usuarioModel = UsuarioModel.AtualizaSenha(email, _controllerSenha.text, _controllerSenha.text);

        var _url = "${ConstantesRest.URL_USUARIOS}/atualizaSenha";
        var _dados = usuarioModel.toJson();

        http.Response response = await http.put(_url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token,
            },
            body: jsonEncode(_dados)
        );

        if (response.statusCode == 204) {
          setState(() {
            _mensagem = "Senha alterada com sucesso!!!";
          });
          Navigator.pop(context);
        } else {
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          setState(() {
            _mensagem = exceptionModel.msg;
          });
        }
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

  void _atualizar() async {
    try {
      _valida();

      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      DateTime _dataNasc = new DateTime(
          int.parse(_controllerDataNascimento.text.substring(6)),
          int.parse(_controllerDataNascimento.text.substring(3,5)),
          int.parse(_controllerDataNascimento.text.substring(0,2))
      );

      UsuarioModel usuarioModel = UsuarioModel.Atualiza(_controllerNome.text,
          _controllerApelido.text, "_dataNasc", _controllerSexo, _controllerPosicionamento,
          _controllerPais, _controllerCidade.text, _controllerLocal.text);

      var _url = "${ConstantesRest.URL_USUARIOS}";
      var _dados = usuarioModel.toJson();

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados)
      );

      if (response.statusCode == 204) {
        setState(() {
          _mensagem = "Usuário alterado com sucesso!!!";
        });

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Usuário", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);

      }else{
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

  void _valida() {
    if (_controllerNome.text == "") {
      throw Exception('Informe seu nome.');
    }
  }

  Future<List<GeneroModel>> _listaGeneros() async {
    UtilService utilService = UtilService();
    return utilService.listaGeneros();
  }

  Future<List<PosicionamentoModel>> _listaPosicionamentos() async {
    UtilService utilService = UtilService();
    return utilService.listaPosiconamentos();
  }

  Future<List<PaisModel>> _listaPaises() async {
    UtilService utilService = UtilService();
    return utilService.listaPaises();
  }

  Future<UsuarioModel> _atualizaImagem(int idUsuario) async {
    UsuarioService usuarioService = UsuarioService();
    return usuarioService.buscaPorId(idUsuario.toString());
  }

  _showModalIndisponivel() async {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.waiting(context, "Mensagem", "Opção indisponível!!!");
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }

  _showModalAtualizaImagem(BuildContext context, String title, String description, int idUsuario){
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
                  _recuperaImagem("galeria", idUsuario),
                  Navigator.pop(context),
                },
                child: Text("Galeria"),
              ),
              FlatButton(
                onPressed: () => {
                  _recuperaImagem("camera", idUsuario),
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
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera); //, maxHeight: 500, maxWidth: 500
        break;
      case "galeria" :
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery); //, maxHeight: 500, maxWidth: 500
        break;
    }

    _imagem = _imagemSelecionada;
    if (_imagem != null) {
      imageCache.clear();
      setState(() {
        _subindoImagem = true;
      });
      _uploadImagem(idRede);
    }
  }

  Future<UsuarioModel> _uploadImagem(int idUsuario) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);
    var _url = "${ConstantesRest.URL_USUARIOS}/${idUsuario}/foto";
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
      //_atualizaImagem(widget.redeModel.id);
      print("Buscar imagem via http");
      setState(() {
        _subindoImagem = false;
      });
    };

    response.progress.listen((int progress) {
      print("Buscar imagem via http");
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text("Perfil"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorFloatButton,

        child: Icon(Icons.lock_outline,color: AppColors.colorIconFloatButton),
        onPressed: () {
          _mensagem = "";
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Alteração de senha"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nova senha",
                      ),
                      obscureText: true,
                      controller: _controllerSenha,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Confirmação da nova senha",
                      ),
                      obscureText: true,
                      controller: _controllerConfirmSenha,
                    ),
                    Text(_mensagem,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Candal',
                        color: Colors.blue,
                      ),
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
                      "Alterar",
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
                    _salvaNovaSenha();
                  },
                ),
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
      ),
      body: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
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
                            "Atualize seus dados e mantenha sua foto atualizada",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        _subindoImagem
                            ? CircularProgressIndicator()
                            : FutureBuilder<UsuarioModel>(
                          future: _atualizaImagem(widget.usuarioModel.id),
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

                                  UsuarioModel usuarioRetorno = snapshot.data;
                                  _nomeImagem = ConstantesRest.URL_STATIC_USER + usuarioRetorno.nomeFoto;

                                  return GestureDetector(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(_nomeImagem), //usuarioRetorno.nomeFoto == "semImagem.png" ? 50 : 100,
                                      radius: 30.0,
                                    ),
                                    onTap: () {
                                      _showModalIndisponivel();
                                      //_showModalAtualizaImagem(context, "Imagem", "Buscar imagem de qual origem?", widget.usuarioModel.id);
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
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(_nomeImagem),
                            radius: 30.0,
                          ),
                          onTap: () {
                            _showModalIndisponivel();
                            //_showModalAtualizaImagem(context, "Imagem", "Buscar imagem de qual origem?", widget.usuarioModel.id);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            " ", //Foto de perfil
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
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.done_all,
                                      color: Colors.black,
                                    ),
                                    hintText: "Nome",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  controller: _controllerNome,
                                ),
                              ),
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
                                    hintText: "Apelido",
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                  controller: _controllerApelido,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(
                                      Icons.done_all,
                                      color: Colors.black,
                                    ),
                                    hintText: "Data de nascimento",
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
                                  controller: _controllerDataNascimento,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: FindDropdown<PosicionamentoModel>(
                                  showSearchBox: false,
                                  onFind: (String filter) => _listaPosicionamentos(),
                                  searchBoxDecoration: InputDecoration(
                                    hintText: "Search",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (PosicionamentoModel data) => _controllerPosicionamento = data.id,
                                  selectedItem: posicionamentoModelSelecionado,
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
                                  onChanged: (GeneroModel data) => _controllerSexo = data.id,
                                  selectedItem: generoModelSelecionado,
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
                                  onChanged: (PaisModel data) => _controllerPais = data.id,
                                  selectedItem: paisModelSelecionado,
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
                                padding: EdgeInsets.only(top: 10),
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
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  _mensagem,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Candal'
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
            )
          ],
        ),
      ),
    );
  }
}
