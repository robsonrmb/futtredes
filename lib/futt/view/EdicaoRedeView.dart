import 'dart:ui';
import 'package:async/async.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EstadoModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/PaisesModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
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
  List<String> listDropEstado = new List();
  List<EstadosModel> estadosList = [];
  String estadoSelecionado = '';
  String paisSelecionado = '';
  List<String> listDropPais = new List();
  bool carregando = true;
  BuildContext context;

  @override
  void initState() {
    super.initState();
    inicializarTela();
  }

  void inicializarTela()async{
    await _buscaPais();
    await _buscaEstado();
    imageCache.clear();
    _atualizaValoresIniciais(widget.redeModel);
  }

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
        _mensagem = "Informe o nome.";
      }else if (paisSelecionado == "") {
        _mensagem = "Informe o país.";
      }
      else if(paisSelecionado == "Brasil"){
        if(estadoSelecionado == ""){
          _mensagem = "Informe o estado.";
        }else{
          if (_controllerCidade.text == "") {
            _mensagem = "Informe a cidade.";
          }else if(_controllerLocal.text == null || _controllerLocal.text == ""){
            _mensagem = "Informe o local.";
          }
        }
      }else{
        if (_controllerCidade.text == "") {
          _mensagem = "Informe a cidade.";
        }else if(_controllerLocal.text == null || _controllerLocal.text == ""){
          _mensagem = "Informe o local.";
        }
      }

      String enviaEstado = estadoSelecionado;

      if (_mensagem != "") {
        if(_mensagem == "Rede atualizada com sucesso!!!"){
          _mensagem = "Ocorreu algum erro";
        }
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.pop(context);

        throw Exception(_mensagem);
      }

      if(paisSelecionado != "Brasil"){
        estadoSelecionado = '';
        enviaEstado = '';
      }else{
        for(int i = 0; i < estadosList.length; i++){
          if(estadoSelecionado == estadosList[i].texto){
            enviaEstado = estadosList[i].codigo;
          }
        }
      }

      RedeModel redeModel = RedeModel.Edita(
          widget.redeModel.id,
          _controllerNome.text,
            paisSelecionado,
          enviaEstado,
          _controllerCidade.text,
          _controllerLocal.text,
          int.parse(_controllerQtdIntegrantes.text),
          _controllerMais.text);

      var _url = "${ConstantesRest.URL_REDE}/atualiza";
      var _dados = redeModel.toJson();

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados));

      // if(trocouFoto){
      //   await _uploadImagem();
      // }

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
    if(redeOrigem.pais != null && redeOrigem.pais != ""){
      paisSelecionado = redeOrigem.pais;
    }
    if(redeOrigem.estado != null && redeOrigem.estado != ""){
      for(int i = 0; i < estadosList.length;i++){
        if(redeOrigem.estado == estadosList[i].codigo){
          estadoSelecionado =  estadosList[i].texto;
        }
      }
    }
    PaisModel _paisModel = PaisModel(redeOrigem.pais, redeOrigem.pais);
    _controllerCidade.text = redeOrigem.cidade;
    _controllerLocal.text = redeOrigem.local;
    _controllerQtdIntegrantes.text = redeOrigem.qtdIntegrantes.toString();
    _controllerMais.text = redeOrigem.info;
  }

  Future<RedeModel> _atualizaImagem(int idRede) async {
    RedeService redeService = RedeService();
    return redeService.buscaRedePorId(idRede); //ConstantesConfig.SERVICO_FIXO
  }

  _showOpc(BuildContext context, String title, String description, int idUsuario){
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
                      child: new Column(
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
                    )
                )
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        context: context,
        pageBuilder: (context, animation1, animation2) {});

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
        _imagemSelecionada = await ImagePicker.pickImage(imageQuality: 20,
            source: ImageSource.camera); //, maxHeight: 500, maxWidth: 500
        break;
      case "galeria":
        _imagemSelecionada = await ImagePicker.pickImage(
            source: ImageSource.gallery,imageQuality: 20); //, maxHeight: 500, maxWidth: 500
        break;
    }

    if (_imagemSelecionada != null) {
      _cropImage(_imagemSelecionada);
    }
    selecao = false;

    _imagem = _imagemSelecionada;
    //  trocouImagem = true;

    setState(() {});
  }

  Future<List<RedeModel>> _uploadImagem() async {
    circularProgress(context);
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

    var request = new http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ConstantesRest.URL_REDE}/${widget.redeModel.id}/imagem'));
    var header = new Map<String, String>();
    header['Content-Type'] = 'application/x-www-form-urlencoded';
    //header['Accept'] = 'application/json';

    if (token.isNotEmpty)
      header[HttpHeaders.authorizationHeader] = token;

    request.headers.addAll(header);

    var stream =
    new http.ByteStream(DelegatingStream.typed(imagemSelecionada.openRead()));
    var length = await imagemSelecionada.length();
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imagemSelecionada.path));

    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    final respStr = await streamedResponse.stream.bytesToString();

    print("RESPONSE CODE:" + streamedResponse.statusCode.toString());
    print("RESPONSE State:" + respStr);
    Navigator.pop(context);

    if(streamedResponse.statusCode != 200){
      DialogFutt dialogFutt = new DialogFutt();
      dialogFutt.waitingError(context, "Erro Foto", "${streamedResponse.statusCode.toString()}");
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
            body: Container(
              color: Color(0xfff7f7f7),
              child: Center(
                child: SingleChildScrollView(
                  //padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey[300].withOpacity(0.5),
                          image: DecorationImage(
                              image: NetworkImage(widget.imageRede),
                              fit: BoxFit.fill),
                        ),
                      ),
                      /* PARA POSSIBILITAR A TROCA DA IMAGEM/BANNER DA REDE:
                         - ELIMINE O CONTAINER ACIMA
                         - DESCOMENTE O IF TERNÁRIO ABAIXO (LINHA 654 À 692)
                      imagemSelecionada == null
                          ? GestureDetector(
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300].withOpacity(0.5),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.imageRede),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              onTap: () {
                                //_showModalIndisponivel();
                                _showOpc(
                                    context,
                                    "Imagem",
                                    "Buscar imagem de qual origem?",
                                    widget.redeModel.id);
                              },
                            )
                          : new GestureDetector(
                              onTap: () {
                                _showOpc(
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
                            ),*/
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
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            rows('Nome', 'Digite o nome da Rede',
                                _controllerNome),
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
                            _buildDropPais(),
                            paisSelecionado == 'Brasil'?
                            new Container(
                              //color: Colors.red,
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 16,
                                bottom: 4,
                              ),
                              child: new Text(
                                'Estado',
                                style: TextStyle(
                                    color: Color(0xff112841),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ):new Container(),
                            _buildDropEstado(),
                            rows('Cidade ', 'Digite a cidade da Rede',
                                _controllerCidade),
                            rows('Local ', 'Digite o local da Rede',
                                _controllerLocal),
                            rowsQtInte('Limite de integrantes', '20',
                                _controllerQtdIntegrantes),

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
                            carregando?new Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Padding(
                                padding: EdgeInsets.only(top: 1),
                                child: Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.5),
                                    highlightColor: Colors.white,
                                    child: new Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width*0.9,
                                      decoration: new BoxDecoration(
                                        //shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    )),
                              ),
                            ):
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
                )
                : null,
          );
  }

  Widget rows(String title, String hint, TextEditingController controller) {
    if(carregando){
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
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.white,
                          child: new Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*0.9,
                            decoration: new BoxDecoration(
                              //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          )),
                    )
                  ],
                ),
              ))
        ],
      );
    }
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
    if(carregando){
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
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.white,
                          child: new Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*0.9,
                            decoration: new BoxDecoration(
                              //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          )),
                    )
                  ],
                ),
              ))
        ],
      );
    }
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
      await _uploadImagem();
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

  Widget _buildDropPais(){
    if(carregando){
      return Padding(
        padding: EdgeInsets.only(top: 1),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child:Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.5),
              highlightColor: Colors.white,
              child: new Container(
                height: 40,
                //width: MediaQuery.of(context).size.width*0.9,
                decoration: new BoxDecoration(
                  //shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.5),
                ),
              )),
        )
      );
    }
    return new Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // color: Colors.black12,
                color: Colors.black12,
                blurRadius: 5)
          ]),
      margin:
      const EdgeInsets.only(right: 16, left: 16),
      child: new Container(
        padding: const EdgeInsets.only(left: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              "Selecione o País",
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            value: paisSelecionado,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 14),
            dropdownColor: Colors.white,
            //, Color(0xff112841),
            onChanged: (newValue) {
              setState(() {
                paisSelecionado = newValue;
                estadoSelecionado = '';
                //controllerNomeCartaoContaBancaria.text = newValue;
              });
            },
            items: listDropPais.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDropEstado(){
    if(carregando){
      return new Container();
    }
    if(paisSelecionado == 'Brasil'){
      return new Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                // color: Colors.black12,
                  color: Colors.black12,
                  blurRadius: 5)
            ]),
        margin:
        const EdgeInsets.only(right: 16, left: 16),
        child: new Container(
          padding: const EdgeInsets.only(left: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                "Selecione o Estado",
                style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              value: estadoSelecionado,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 14),
              dropdownColor: Colors.white,
              //, Color(0xff112841),
              onChanged: (newValue) {
                setState(() {
                  estadoSelecionado = newValue;
                  //controllerNomeCartaoContaBancaria.text = newValue;
                });
              },
              items: listDropEstado.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }
    return new Container();
  }

  Future<void> _buscaEstado() async {
    listDropEstado.add('');
    UsuarioService usuarioService = UsuarioService();
    List<EstadosModel> estados = await usuarioService.listaEstados();
    if (estados != null) {
      estadosList = estados;
      for (int i = 0; i < estados.length; i++) {
        listDropEstado.add(estados[i].texto);
      }
    }
    setState(() {
      carregando = false;
    });
  }


  Future<void> _buscaPais() async {
    listDropPais.add('');
    UsuarioService usuarioService = UsuarioService();
    List<PaisesModel> paises = await usuarioService.listaPaises();
    if (paises != null) {
      for (int i = 0; i < paises.length; i++) {
        listDropPais.add(paises[i].texto);
      }
    }
  }
}
