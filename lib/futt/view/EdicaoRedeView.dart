import 'dart:ui';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multipart_request/multipart_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:shimmer/shimmer.dart';

class EdicaoRedeView extends StatefulWidget {
  RedeModel redeModel;
  String imageRede;
  String nomeHero;

  EdicaoRedeView({this.redeModel, this.imageRede, this.nomeHero});

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
  String _nomeImagem = "";
  bool selecao = false;

  bool trocouFoto = false;

  File imagemSelecionada;

  _showModalIndisponivel() async {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.waiting(context, "Mensagem", "Opção indisponível!!!");
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }

  _atualizaRede() async {
    try {
      circularProgress(context);
      _mensagem = "";
      if (_controllerNome.text == "") {
        Navigator.pop(context);

        throw Exception('Informe o título do rede.');
      } else if (_controllerPaisRede == "") {
        Navigator.pop(context);

        throw Exception('Informe o país de onde se realizará o rede.');
      } else if (_controllerCidade.text == "") {
        Navigator.pop(context);

        throw Exception('Informe a cidade de onde se realizará o rede.');
      } else if (int.parse(_controllerQtdIntegrantes.text) <= 0 ||
          int.parse(_controllerQtdIntegrantes.text) > 999) {
        Navigator.pop(context);

        throw Exception('Qtd de integrantes incorreto.');
      }



      if (_mensagem != "") {
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      RedeModel redeModel = RedeModel.Edita(
          widget.redeModel.id,
          _controllerNome.text,
          _controllerPaisRede,
          _controllerCidade.text,
          _controllerLocal.text,
          int.parse(_controllerQtdIntegrantes.text),
          _controllerMais.text);

      var _url = "${ConstantesRest.URL_REDE}/atualiza";
      var _dados = redeModel.toJson();

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({
          'userId': 1,
          'id': 1,
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

      if(trocouFoto){
        await _uploadImagem();
      }

      if (response.statusCode == 201) {
        _mensagem = "Rede atualizada com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Atualização de rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);

      } else {
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
    return redeService.buscaRedePorId(
        idRede, false); //ConstantesConfig.SERVICO_FIXO
  }

  _showModalAtualizaImagem(
      BuildContext context, String title, String description, int idUsuario) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.only(top: 0, right: 16, bottom: 16, left: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    new IconButton(
                        icon: new Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
                RaisedButton(
                  onPressed: () {
                    _recuperaImagem("camera", idUsuario);
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          AppColors.colorEspecialSecundario2,
                          AppColors.colorEspecialSecundario1
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        constraints: const BoxConstraints(
                            minWidth: 88.0, minHeight: 36.0),
                        // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.colorIconPerfil,
                            ),
                            new Container(
                              width: 10,
                            ),
                            Text(
                              "Câmera",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.colorTextPerfil,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
                new Container(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    _recuperaImagem("galeria", idUsuario);
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          AppColors.colorEspecialPrimario2,
                          AppColors.colorEspecialPrimario1
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        constraints: const BoxConstraints(
                            minWidth: 88.0, minHeight: 36.0),
                        // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Icon(
                              Icons.image_search_outlined,
                              color: AppColors.colorIconPerfil,
                            ),
                            new Container(
                              width: 10,
                            ),
                            Text(
                              "Galeria",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.colorTextPerfil,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _recuperaImagem(String origemImagem, int idRede) async {
    selecao = true;
    setState(() {});
    File _imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        _imagemSelecionada = await ImagePicker.pickImage(imageQuality: 50,
            source: ImageSource.camera); //, maxHeight: 500, maxWidth: 500
        break;
      case "galeria":
        _imagemSelecionada = await ImagePicker.pickImage(
            source: ImageSource.gallery,imageQuality: 50); //, maxHeight: 500, maxWidth: 500
        break;
    }

    if (_imagemSelecionada != null) {
      _cropImage(_imagemSelecionada);
    }
    selecao = false;

    _imagem = _imagemSelecionada;
    //  trocouImagem = true;

    setState(() {});
    // if (_imagem != null) {
    //   imageCache.clear();
    //   setState(() {
    //     _subindoImagem = true;
    //   });
    //   _uploadImagem(idRede);
    // }
  }

  Future<List<RedeModel>> _uploadImagem() async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);
    var _url = "${ConstantesRest.URL_REDE}/${widget.redeModel.id}/imagem";
    var request = MultipartRequest();

    request.setUrl(_url);
    request.addFile("file", imagemSelecionada.path);
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
      /*setState(() {
        _subindoImagem = true;
      });*/
    });

    /*setState(() {
      _subindoImagem = true;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    _atualizaValoresIniciais(widget.redeModel);

    return selecao
        ? Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/fundo.jpg"), fit: BoxFit.fill)),
              child: new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          child: new CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          height: 130.0,
                          width: 130.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Image.asset("images/logoFuttRedesNovo.png",
                              height: 100, width: 125),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
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
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)),
              title: Text(
                "Edição de redes",
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorTextAppNav,
                ),
              ),
              centerTitle: true,
            ),
            // appBar: AppBar(
            //   iconTheme: IconThemeData(
            //     color: Colors.white,
            //     opacity: 1,
            //   ),
            //   backgroundColor: Color(0xff093352),
            //   textTheme: TextTheme(
            //       title: TextStyle(
            //           color: Colors.white,
            //           fontSize: 20
            //       )
            //   ),
            //   title: Text("Edição de redes"),
            // ),
            body: Container(
              color: Color(0xfff7f7f7),
              child: Center(
                child: SingleChildScrollView(
                  //padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.only(bottom: 5),
                      //   child: Text(
                      //     "Atualização de dados",
                      //     style: TextStyle(
                      //         fontSize: 12
                      //     ),
                      //   ),
                      // ),
                      imagemSelecionada == null
                          ? GestureDetector(
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300].withOpacity(0.5),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.imageRede),
                                      fit: BoxFit.fill),
                                  //borderRadius: BorderRadius.circular(5.0),
                                  // border: Border.all(
                                  //   width: 1.0,
                                  //   color: Colors.grey[300],
                                  // )
                                ),
                              ),
                              onTap: () {
                                //_showModalIndisponivel();
                                _showModalAtualizaImagem(
                                    context,
                                    "Imagem",
                                    "Buscar imagem de qual origem?",
                                    widget.redeModel.id);
                              },
                            )
                          : new GestureDetector(
                              onTap: () {
                                _showModalAtualizaImagem(
                                    context,
                                    "Imagem",
                                    "Buscar imagem de qual origem?",
                                    widget.redeModel.id);
                              },
                              child: new Container(
                                height: 140,
                                decoration: new BoxDecoration(
                                  //color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: new FileImage(imagemSelecionada),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                      // _subindoImagem
                      //     ? CircularProgressIndicator()
                      //     : FutureBuilder<RedeModel>(
                      //         future: _atualizaImagem(widget.redeModel.id),
                      //         builder: (context, snapshot) {
                      //           switch (snapshot.connectionState) {
                      //             case ConnectionState.none:
                      //             case ConnectionState.waiting:
                      //               return Shimmer.fromColors(
                      //                   baseColor: Colors.grey.withOpacity(0.5),
                      //                   highlightColor: Colors.white,
                      //                   child: new Container(
                      //                     height: 140,
                      //                     width: double.infinity,
                      //                     decoration: new BoxDecoration(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                     ),
                      //                   ));
                      //               break;
                      //             case ConnectionState.active:
                      //             case ConnectionState.done:
                      //               if (snapshot.hasData) {
                      //                 RedeModel redeRetorno = snapshot.data;
                      //                 _nomeImagem = ConstantesRest.URL_BASE_AMAZON +
                      //                     redeRetorno.nomeFoto;
                      //
                      //                 return GestureDetector(
                      //                   child: Container(
                      //                     height:140,
                      //                     decoration: BoxDecoration(
                      //                       color: Colors.grey[300].withOpacity(0.5),
                      //                       image: DecorationImage(
                      //                           image: NetworkImage(_nomeImagem),
                      //                           fit: BoxFit.fill),
                      //                       //borderRadius: BorderRadius.circular(5.0),
                      //                       // border: Border.all(
                      //                       //   width: 1.0,
                      //                       //   color: Colors.grey[300],
                      //                       // )
                      //                     ),
                      //                   ),
                      //                   onTap: () {
                      //                     //_showModalIndisponivel();
                      //                     _showModalAtualizaImagem(
                      //                         context,
                      //                         "Imagem",
                      //                         "Buscar imagem de qual origem?",
                      //                         widget.redeModel.id);
                      //                   },
                      //                 );
                      //               } else {
                      //                 return Center(
                      //                   child: Text("Sem valores!!!"),
                      //                 );
                      //               }
                      //               break;
                      //           }
                      //           return null;
                      //         },
                      //       ),
                      new Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              AppColors.colorEspecialPrimario1,
                              AppColors.colorEspecialPrimario2
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: new Text(
                          'Imagem da Rede',
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 5),
                      //   child: Text(
                      //     "Imagem da Rede",
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            rows('Nome', 'Digite o nome da Rede',
                                _controllerNome),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            //   child: TextField(
                            //     keyboardType: TextInputType.text,
                            //     decoration: InputDecoration(
                            //       filled: true,
                            //       fillColor: Colors.white,
                            //       hintText: "Nome da rede",
                            //       hintStyle: TextStyle(
                            //         fontSize: 14,
                            //         color: Colors.grey[400],
                            //       ),
                            //       /*prefixIcon: Icon(
                            //         Icons.done_all,
                            //         color: Colors.black,
                            //       ),*/
                            //       // icon: new Icon(Icons.done_all),
                            //       // prefixText: "Nome",
                            //       // prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                            //       // labelText: "Informe seu nome",
                            //       /* border: OutlineInputBorder(
                            //         gapPadding: 5,
                            //       ),*/
                            //     ),
                            //     style: TextStyle(
                            //         fontSize: 16,
                            //         color: Colors.black
                            //     ),
                            //     controller: _controllerNome,
                            //   ),
                            // ),
                            new Container(
                              //color: Colors.red,
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 16,
                                bottom: 4,
                              ),
                              child: new Text(
                                'País',
                                style: TextStyle(
                                    color: Color(0xff112841),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                            new Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        // color: Colors.black12,
                                        color: Colors.black12,
                                        blurRadius: 5)
                                  ]),
                              margin:
                                  const EdgeInsets.only(right: 16, left: 16),
                              child: Padding(
                                padding: EdgeInsets.only(),
                                child: FindDropdown<PaisModel>(
                                  showSearchBox: true,
                                  selectedItem: PaisModel(widget.redeModel.pais,
                                      widget.redeModel.pais),
                                  onFind: (String filter) => _listaPaises(),
                                  searchBoxDecoration: InputDecoration(
                                    hintText: "Search",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    icon: new Icon(Icons.monetization_on),
                                    labelText: "País",
                                  ),
                                  onChanged: (PaisModel data) =>
                                      _controllerPaisRede = data.id,
                                  showClearButton: false,
                                ),
                              ),
                            ),
                            rows('Cidade ', 'Digite a cidade da Rede',
                                _controllerCidade),
                            rows('Local ', 'Digite o local da Rede',
                                _controllerLocal),
                            rowsQtInte('Limite de integrantes', '20',
                                _controllerQtdIntegrantes),

                            // TextField(
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     hintText: "Lisboa",
                            //     hintStyle: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.grey[400],
                            //     ),
                            //     // icon: new Icon(Icons.location_city),
                            //     /* border: OutlineInputBorder(
                            //               gapPadding: 1,
                            //             ),*/
                            //   ),
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.black
                            //   ),
                            //   controller: _controllerCidade,
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.all(5),
                            // ),
                            // TextField(
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     hintText: "Cascais - Praia dos pescadores",
                            //     hintStyle: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.grey[400],
                            //     ),
                            //   ),
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.black
                            //   ),
                            //   controller: _controllerLocal,
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.all(5),
                            // ),
                            // TextField(
                            //   enabled: false,
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     hintText: "20",
                            //     hintStyle: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.grey[400],
                            //     ),
                            //     // icon: new Icon(Icons.monetization_on),
                            //     suffixIcon: Icon(
                            //       Icons.monetization_on,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.black
                            //   ),
                            //   //maxLength: 3,
                            //   //maxLengthEnforced: true,
                            //   controller: _controllerQtdIntegrantes,
                            //   onTap: () => {
                            //     /*Navigator.push(context, MaterialPageRoute(
                            //       builder: (context) => MensalidadeView(),
                            //     ))*/
                            //   },
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.all(5),
                            // ),
                            new Container(
                              //color: Colors.red,
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 16,
                                bottom: 4,
                              ),
                              child: new Text(
                                'Observação',
                                style: TextStyle(
                                    color: Color(0xff112841),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 16, left: 16),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[400],
                                  )),
                              child: TextField(
                                maxLines: 10,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration.collapsed(
                                  hintText:
                                      "Acrescente alguma observação(opcional)",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
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
                                    fontFamily: FontFamily.fontSpecial,
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
            bottomNavigationBar: widget.redeModel.status == 2
                ? BottomAppBar(
                    child: new Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    color: Color(0xfff7f7f7),
                    child: RaisedButton(
                      onPressed: () {
                        _atualizaRede();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.all(0.0),
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
                          constraints: const BoxConstraints(
                              minWidth: 88.0, minHeight: 36.0),
                          // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Text(
                            "Atualizar",
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.colorTextLogCad,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    //   color: Colors.grey[300],
                    //   child: RaisedButton(
                    //     color: Color(0xff086ba4),
                    //     textColor: Colors.white,
                    //     padding: EdgeInsets.all(15),
                    //     child: Text(
                    //       "Atualiza",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontFamily: 'Candal',
                    //       ),
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(2),
                    //     ),
                    //     onPressed: () {
                    //       _atualizaRede();
                    //     },
                    //   ),
                    // ),
                    )
                : null,
          );
  }

  Widget rows(String title, String hint, TextEditingController controller) {
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
                height: 40,
                padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          // color: Colors.black12,
                          color: Colors.black12,
                          blurRadius: 5)
                    ]),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget rowsQtInte(
      String title, String hint, TextEditingController controller) {
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
                height: 40,
                padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Color(0xB3FFFFFF),
                    boxShadow: [
                      BoxShadow(
                          // color: Colors.black12,
                          color: Colors.black12,
                          blurRadius: 5)
                    ]),
                child: TextField(
                  controller: controller,
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Future<Null> _cropImage(File file) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Parte Escolhida',
            toolbarColor: AppColors.colorFundoEscuroApp,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            showCropGrid: false,
            backgroundColor: AppColors.colorFundoEscuroApp,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Parte Escolhida',
        ));
    if (croppedFile != null) {
      setState(() {
        trocouFoto = true;
        imagemSelecionada = croppedFile;
      });
      // imageFile = croppedFile;
      // setState(() {
      //   state = AppState.cropped;
      // });
    }
    selecao = false;
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
}
