import 'dart:ui';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EstadoModel.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/PaisesModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/model/UsuarioModelAtualiza.dart';
import 'package:futt/futt/model/utils/GeneroModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/model/utils/PosicionamentoModel.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/view/SplashScreenView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:shimmer/shimmer.dart';

class PerfilSubView extends StatefulWidget {
  String? image;
  UsuarioModel? usuarioModel;

  PerfilSubView({this.image, this.usuarioModel});

  @override
  _PerfilSubViewState createState() => _PerfilSubViewState();
}

class _PerfilSubViewState extends State<PerfilSubView> {
  String? _mensagem = "";
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerApelido = TextEditingController();
  TextEditingController _controllerDataNascimento = TextEditingController();
  String? _controllerPosicionamento = "";
  String? _controllerSexo = "";
  String? _controllerPais = "";
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();

  PaisModel? paisModelSelecionado;
  late GeneroModel generoModelSelecionado;
  PosicionamentoModel? posicionamentoModelSelecionado;
  List<EstadosModel> estadosList = [];
  File? _imagem;
  String _nomeImagem = "";
  bool enableEdit = false;
  String? sexoSelecionado;
  List<String> listDropSexo = ['Masculino', 'Feminino'];
  String? posicaoSelecionado;
  List<String> listDropPosicao = ['','Esquerda', 'Direita', 'Ambas'];
  String? paisSelecionado;
  List<String?> listDropPais = [];
  String? estadoSelecionado;
  List<String?> listDropEstado = [];

  bool trocouImagem = false;
  bool salvouFotoTrocada = false;
  late SharedPreferences prefs;
  bool enableEditPencil = false;


  bool podeMontarDrops = false;

  @override
  void initState() {
    super.initState();
    iniciarShared();
    _buscaPais();
    _buscaEstado();
  }

  void iniciarShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _atualizar(BuildContext context) async {
    try {
      _mensagem = "";
      _valida();

      if (_mensagem != "") {
        circularProgress(context);
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waiting(context, "Mensagem", "${_mensagem}");
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.pop(context);

        throw Exception(_mensagem);
      }
      circularProgress(context);
      DateTime? _dataNasc;
      
      if(_controllerDataNascimento.text != ""&& _controllerDataNascimento.text.length==10){
        _dataNasc = new DateTime(
            int.parse(_controllerDataNascimento.text.substring(6)),
            int.parse(_controllerDataNascimento.text.substring(3, 5)),
            int.parse(_controllerDataNascimento.text.substring(0, 2)));
      }

      String enviaPosicao = '';
      String? enviaEstado = estadoSelecionado;
      if(posicaoSelecionado == "Esquerda"){
        enviaPosicao = "2";
      }
      if(posicaoSelecionado == "Direita"){
        enviaPosicao = "1";
      }
      if(posicaoSelecionado == "Ambas"){
        enviaPosicao = "0";
      }
      if (_controllerPais != 'Brasil') {
        estadoSelecionado = '';
        enviaEstado = '';
      }else{
        for(int i = 0; i < estadosList.length; i++){
          if(estadoSelecionado == estadosList[i].texto){
            enviaEstado = estadosList[i].codigo;
          }
        }
      }

      UsuarioModelAtualiza usuarioModel = UsuarioModelAtualiza.Atualiza(
          _controllerNome.text,
          _controllerApelido.text,
          _dataNasc,
          _controllerSexo,
          enviaPosicao,
          enviaEstado,
          _controllerPais,
          _controllerCidade.text,
          _controllerLocal.text);

      var _url = "${ConstantesRest.URL_USUARIOS}";
      var _dados = usuarioModel.toJson();

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

      http.Response response = await http.put(Uri.parse(_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados));

      if (trocouImagem) {
        bool foto = await uploadImagemBool(widget.usuarioModel!.id);
        if (foto) {
          if (response.statusCode == 204) {
            setState(() {
              _mensagem = "Usuário alterado com sucesso!!!";
            });

            DialogFutt dialogFutt = new DialogFutt();
            dialogFutt.waitingSucess(context, "Usuário", "${_mensagem}");
            await Future.delayed(Duration(seconds: 3));
            Navigator.pop(context);
            Navigator.pop(context);
            imageCache.clear();
          } else {
            var _dadosJson = jsonDecode(response.body);
            ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
            setState(() {
              _mensagem = exceptionModel.msg;
            });
          }
        } else {
          setState(() {
            _mensagem = "Houve um erro ao trocar a foto de Perfil!!!";
          });

          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingError(context, "Usuário", "${_mensagem}");
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
        }
      } else {
        if (response.statusCode == 204) {
          setState(() {
            _mensagem = "Usuário alterado com sucesso!!!";
          });

          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingSucess(context, "Usuário", "${_mensagem}");
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          DialogFutt dialogFutt = new DialogFutt();
          dialogFutt.waitingError(context, "Erro", "${_mensagem}");
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
          Navigator.pop(context);
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

  Future<UsuarioModel?> _buscaUsuarioLogado() async {
    UsuarioService usuarioService = UsuarioService();
    return usuarioService.buscaLogado();
  }

  // _showModalIndisponivel() async {
  //   DialogFutt dialogFutt = new DialogFutt();
  //   dialogFutt.waiting(context, "Mensagem", "Opção indisponível!!!");
  //   await Future.delayed(Duration(seconds: 2));
  //   Navigator.pop(context);
  // }
  _showOpc(BuildContext context, String title, String description, int? idUsuario){
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
                          ElevatedButton(


                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              padding: const EdgeInsets.all(0.0),
                            ),
                            onPressed: () {
                              _recuperaImagem("camera", idUsuario);
                              Navigator.pop(context);
                            },

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
                          ElevatedButton(
                            onPressed: () {
                              _recuperaImagem("galeria", idUsuario);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              padding: const EdgeInsets.all(0.0),
                            ),


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
        pageBuilder: (context, animation1, animation2) {} as Widget Function(BuildContext, Animation<double>, Animation<double>));

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
                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(0.0),
                  ),

                  onPressed: () {
                    _recuperaImagem("camera", idUsuario);
                    Navigator.pop(context);
                  },

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
                ElevatedButton(
                  onPressed: () {
                    _recuperaImagem("galeria", idUsuario);
                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(0.0),
                  ),



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

  _recuperaImagem(String origemImagem, int? idRede) async {
    XFile? _imagemSelecionada;
    final ImagePicker _picker = ImagePicker();
    switch (origemImagem) {
      case "camera":
        _imagemSelecionada = await _picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 30); //, maxHeight: 500, maxWidth: 500
        break;
      case "galeria":
        _imagemSelecionada = await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 30); //, maxHeight: 500, maxWidth: 500
        break;
    }
    File fileImage = File(_imagemSelecionada!.path);

    _imagem = fileImage;
    trocouImagem = true;

    setState(() {});
  }

  Future<bool> uploadImagemBool(int? idUsuario) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

    var request = new http.MultipartRequest(
        'PUT', Uri.parse('${ConstantesRest.URL_USUARIOS}/$idUsuario/foto'));

    var stream =
        new http.ByteStream(DelegatingStream.typed(_imagem!.openRead()));
    var length = await _imagem!.length();
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(_imagem!.path));

    var header = new Map<String, String>();
    header['Content-Type'] = 'application/x-www-form-urlencoded';
    //header['Accept'] = 'application/json';

    header[HttpHeaders.authorizationHeader] = token;

    request.headers.addAll(header);

    request.files.add(
        //multipartFile
        http.MultipartFile.fromBytes('file', _imagem!.readAsBytesSync(),
            filename: _imagem!.path.split("/").last));

    var streamedResponse = await request.send();
    final respStr = await streamedResponse.stream.bytesToString();

    print("RESPONSE CODE:" + streamedResponse.statusCode.toString());
    print("RESPONSE State:" + respStr);

    if (streamedResponse.statusCode == 200) {
      salvouFotoTrocada = true;
      return true;
    } else {
      return false;
    }

  }

  Future<UsuarioModel?> _uploadImagem(int idUsuario) async {
    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

    var request = new http.MultipartRequest(
        'PUT', Uri.parse('${ConstantesRest.URL_USUARIOS}/$idUsuario/foto'));

    var stream =
        new http.ByteStream(DelegatingStream.typed(_imagem!.openRead()));
    var length = await _imagem!.length();
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(_imagem!.path));

    var header = new Map<String, String>();
    header['Content-Type'] = 'application/x-www-form-urlencoded';
    //header['Accept'] = 'application/json';

    header[HttpHeaders.authorizationHeader] = token;

    request.headers.addAll(header);

    request.files.add(
        //multipartFile
        http.MultipartFile.fromBytes('file', _imagem!.readAsBytesSync(),
            filename: _imagem!.path.split("/").last));

    var streamedResponse = await request.send();
    final respStr = await streamedResponse.stream.bytesToString();

    print("RESPONSE CODE:" + streamedResponse.statusCode.toString());
    print("RESPONSE State:" + respStr);

    if (streamedResponse.statusCode == 200) {}

    salvouFotoTrocada = true;
  }

  void _buscaPais() async {
    UsuarioService usuarioService = UsuarioService();
    List<PaisesModel>? paises = await usuarioService.listaPaises();
    if (paises != null) {
      for (int i = 0; i < paises.length; i++) {
        listDropPais.add(paises[i].texto);
      }
    }
  }

  void _buscaEstado() async {
    listDropEstado.add('');
    UsuarioService usuarioService = UsuarioService();
    List<EstadosModel>? estados = await usuarioService.listaEstados();
    if (estados != null) {
      estadosList = estados;
      for (int i = 0; i < estados.length; i++) {
        listDropEstado.add(estados[i].texto);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/fundo.jpg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            //padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Stack(
                  alignment: Alignment.center,
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: new IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.colorIconPerfil,
                              ),
                              onPressed: () {
                                prefs.setBool('restart', false);
                               if(trocouImagem && salvouFotoTrocada){
                                 Navigator.pop(context, true);
                               }else{
                                 Navigator.pop(context, false);
                               }
                              }

                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Center(
                          child: new Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: new Text(
                                'PERFIL',
                                style: new TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.colorTextPerfil,
                                  fontFamily: FontFamily.fontSpecial,
                                ),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(bottom: 5),
                //   child: Text(
                //     "Atualize seus dados",
                //     // e mantenha sua foto atualizada
                //     style: TextStyle(fontSize: 12),
                //   ),
                // ),
                new Hero(
                    tag: 'perfil',
                    child: _imagem == null
                        ? new Stack(
                            alignment: Alignment.topRight,
                            children: [
                              new GestureDetector(
                                onTap: () {
                                  _showOpc(
                                      context,
                                      "Imagem",
                                      "Buscar imagem de qual origem?",
                                      widget.usuarioModel!.id);
                                },
                                child: new Container(
                                  margin: const EdgeInsets.all(4),
                                  height: 110,
                                  width: 110,
                                  decoration: new BoxDecoration(
                                      //color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.colorBorderPerfil)
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 2,
                                      //     blurRadius: 7,
                                      //     offset: Offset(0, 3), // changes position of shadow
                                      //   ),
                                      // ],
                                      ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(widget.image!),
                                    radius: 30.0,
                                  ),
                                ),
                              )
                            ],
                          )
                        : new GestureDetector(
                            onTap: () {
                              _showOpc(
                                  context,
                                  "Imagem",
                                  "Buscar imagem de qual origem?",
                                  widget.usuarioModel!.id);
                            },
                            child: new Container(
                              height: 110,
                              width: 110,
                              decoration: new BoxDecoration(
                                  //color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: new FileImage(_imagem!),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.colorBorderPerfil)),
                            ),
                          )),
                // _showModalAtualizaImagem(context, "Imagem", "Buscar imagem de qual origem?", widget.usuarioModel.id);

                FutureBuilder<UsuarioModel?>(
                  future: _buscaUsuarioLogado(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Text("None!!!"),
                        );
                      case ConnectionState.waiting:
                        return Container(
                          child: Center(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  // Shimmer.fromColors(
                                  //     baseColor: Colors.grey.withOpacity(0.5),
                                  //     highlightColor: Colors.white,
                                  //     child: new Container(
                                  //       height: 20,
                                  //       width: 100,
                                  //       decoration: new BoxDecoration(
                                  //           color: Colors.grey.withOpacity(0.5),
                                  //           borderRadius: BorderRadius.circular(8)),
                                  //     )),
                                  new Container(
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Shimmer.fromColors(
                                        baseColor: Colors.grey.withOpacity(0.5),
                                        highlightColor: Colors.white,
                                        child: new Container(
                                          height: 24,
                                          width: 120,
                                          decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        )),
                                  ),
                                  // new Container(
                                  //   margin: const EdgeInsets.only(
                                  //     top: 4,
                                  //   ),
                                  //   child: Shimmer.fromColors(
                                  //       baseColor: Colors.grey.withOpacity(0.5),
                                  //       highlightColor: Colors.white,
                                  //       child: new Container(
                                  //         height: 16,
                                  //         width: 80,
                                  //         decoration: new BoxDecoration(
                                  //             color: Colors.grey.withOpacity(0.5),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(8)),
                                  //       )),
                                  // ),
                                  new Container(
                                    height: 10,
                                  ),
                                  rowsLoad('Nome Completo', context),
                                  rowsLoad('Data de Nascimento', context),
                                  rowsLoad('Local onde joga:', context),
                                  rowsLoad('Posição:', context),
                                  rowsLoad('País', context),
                                  // rowsLoad('Estado'),
                                  rowsLoad('Cidade', context),
                                  rowsLoad('Sexo', context),
                                ],
                              ),
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.active:
                        return Center(
                          child: Text("Active!!!"),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          enableEditPencil = true;
                          String estado = '';
                          String posicao = '';
                          String idUser = '';

                          if (!enableEdit) {
                            UsuarioModel usuarioModel = snapshot.data!;
                            idUser = usuarioModel.id.toString();
                            prefs.setString(
                                'fotoPerfil', usuarioModel.nomeFoto!);
                            _controllerNome.text = usuarioModel.nome!;
                            _controllerApelido.text = usuarioModel.apelido!;
                            _nomeImagem = ConstantesRest.URL_STATIC_USER +
                                usuarioModel.nomeFoto!;
                            _controllerDataNascimento.text =
                                usuarioModel.dataNascimento!;
                            //_controllerDataNascimento.text = "";
                            if (usuarioModel.dataNascimento != null &&
                                usuarioModel.dataNascimento != "") {
                              var formatter = new DateFormat('dd/MM/yyyy');
                              // String formatted =
                              //     formatter.format(usuarioModel.dataNascimento);
                              _controllerDataNascimento.text =
                                  '${_controllerDataNascimento.text.split('-').last}/${_controllerDataNascimento.text.split('-')[1]}/${_controllerDataNascimento.text.split('-').first}';
                              ;
                            }

                            _controllerSexo = usuarioModel.sexo;
                            _controllerPosicionamento = usuarioModel.posicao;
                            _controllerPais = usuarioModel.pais;
                            _controllerCidade.text = usuarioModel.cidade!;
                            _controllerLocal.text = usuarioModel.ondeJoga!;
                            estado = usuarioModel.estado ?? '';
                            posicao =
                            usuarioModel.posicao == '2'
                                ? "Esquerda"
                                : usuarioModel.posicao == '1'
                                    ? "Direita"
                                      : usuarioModel.posicao == '0'
                                        ?"Ambas":
                                          "";
                            posicaoSelecionado = posicao;

                            paisModelSelecionado =
                                new PaisModel(_controllerPais, _controllerPais);
                            generoModelSelecionado = new GeneroModel(
                                _controllerSexo,
                                (_controllerSexo == "M" || _controllerSexo == "Masculino")
                                    ? "Masculino"
                                    : "Feminino");
                            posicionamentoModelSelecionado =
                                new PosicionamentoModel(
                                    _controllerPosicionamento,
                                    _controllerPosicionamento != "A"
                                        ? _controllerPosicionamento != "D"
                                            ? "Esquerda"
                                            : "Direita"
                                        : "Ambas");
                            sexoSelecionado = generoModelSelecionado.nome;
                            paisSelecionado = _controllerPais;
                            if (estado != null && estado != '') {
                              for (int i = 0; i < estadosList.length; i++) {
                                if (estado == estadosList[i].codigo) {
                                  estadoSelecionado = estadosList[i].texto;
                                }
                              }
                              if (usuarioModel.estado != null ||
                                  usuarioModel.estado != "") {
                                for(int i = 0; i < listDropEstado.length; i++){
                                  if(usuarioModel.estado == listDropEstado[i])
                                  estadoSelecionado = listDropEstado[i];
                                }
                                // if (estadoSelecionado == null || estadoSelecionado == "") {
                                //   estadoSelecionado = '';
                                // }
                              } else {
                                estadoSelecionado = '';
                              }
                            }
                            enableEdit = true;

                            Future.delayed(Duration(milliseconds: 0),(){
                              podeMontarDrops = true;
                              setState(() {});
                            });
                          }

                          if(podeMontarDrops){
                            return Container(
                              child: Center(
                                child: SingleChildScrollView(
                                  //padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                          //color: Colors.red,
                                          margin: const EdgeInsets.only(
                                              top: 4, bottom: 4),
                                          //height: 40,
                                          child: _controllerApelido.text !=
                                              null &&
                                              _controllerApelido.text != ""
                                              ? TextField(
                                            cursorColor:
                                            AppColors.colorTextPerfil,
                                            //keyboardType: inputType,
                                            controller: _controllerApelido,
                                            enabled: false,
                                            style: new TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color:
                                              AppColors.colorTextPerfil,
                                              fontFamily:
                                              FontFamily.fontSpecial,
                                            ),
                                            textAlign: TextAlign.center,
                                            decoration: new InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder:
                                                InputBorder.none,
                                                enabledBorder:
                                                InputBorder.none,
                                                errorBorder:
                                                InputBorder.none,
                                                isDense: true,
                                                // Added this

                                                disabledBorder:
                                                InputBorder.none,
                                                hintStyle: new TextStyle(
                                                  color: AppColors
                                                      .colorTextPerfil,
                                                ),
                                                contentPadding:
                                                EdgeInsets.all(0),
                                                hintText: ""),
                                          )
                                              : new Text(
                                            '${primeiroNome(_controllerNome.text)}',
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color:
                                              AppColors.colorTextPerfil,
                                              fontFamily:
                                              FontFamily.fontSpecial,
                                            ),
                                          )),
                                      new Container(
                                        height: 10,
                                      ),
                                      rows('Nome Completo', _controllerNome),
                                      rows('Apelido', _controllerApelido),

                                      rowsNasc('Data de Nascimento',
                                          _controllerDataNascimento),
                                      rows('Local onde joga:', _controllerLocal),
                                      rowsStringPosicao('Posição:', posicao),
                                      rowsStringPais(
                                          'País:', _controllerPais ?? ''),
                                      rowsStringEstado('Estado', estado),
                                      rowsCidade('Cidade:', _controllerCidade),
                                      rowsStringSexo(
                                          'Sexo:', generoModelSelecionado.nome),
                                      new Container(
                                        height: 16,
                                      ),
                                      new GestureDetector(
                                        onTap: () {
                                          dialogDesativarUser(idUser, context);
                                        },
                                        child: new Container(
                                          margin: const EdgeInsets.only(
                                              left: 26, bottom: 30),
                                          child: new Row(
                                            children: [
                                              new Icon(
                                                Icons.exit_to_app,
                                                color: Colors.red,
                                              ),
                                              new Container(
                                                width: 8,
                                              ),
                                              new Text(
                                                'Desativar Conta',
                                                style: new TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }else{
                            return Container(
                              child: Center(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Shimmer.fromColors(
                                            baseColor: Colors.grey.withOpacity(0.5),
                                            highlightColor: Colors.white,
                                            child: new Container(
                                              height: 24,
                                              width: 120,
                                              decoration: new BoxDecoration(
                                                  color:
                                                  Colors.grey.withOpacity(0.5),
                                                  borderRadius:
                                                  BorderRadius.circular(8)),
                                            )),
                                      ),
                                      new Container(
                                        height: 10,
                                      ),
                                      rowsLoad('Nome Completo', context),
                                      rowsLoad('Data de Nascimento', context),
                                      rowsLoad('Local onde joga:', context),
                                      rowsLoad('Posição:', context),
                                      rowsLoad('País', context),
                                      // rowsLoad('Estado'),
                                      rowsLoad('Cidade', context),
                                      rowsLoad('Sexo', context),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }

                        } else {
                          return Center(
                            child: Text("Sem valores!!!"),
                          );
                        }
                        break;
                    }
                    return new Container();
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.grey[900],
            child: new Container(
              margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _atualizar(context);
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
                    child: const Text(
                      "Atualizar",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget rows(String titile, TextEditingController controller) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
          //height: 60,
          //width: MediaQuery.of(context).size.width,

          margin: const EdgeInsets.only(top: 20, right: 26, left: 26),
          padding: const EdgeInsets.only(left: 6),
          decoration: new BoxDecoration(),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                //color: Colors.red,
                margin: const EdgeInsets.only(
                  top: 4,
                ),
                child: new Text(
                  titile,
                  style: TextStyle(
                      color: AppColors.colorTextPerfil,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              new Container(
                  //padding: const EdgeInsets.only(left: 16),
                  color: Colors.white.withOpacity(0.1),
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  height: 40,
                  child: new Center(
                    child: TextField(
                      cursorColor: AppColors.colorTextPerfil,
                      //keyboardType: inputType,
                      controller: controller,
                      style: new TextStyle(
                          color: AppColors.colorTextPerfil,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16.0, bottom: 8),
                      ),
                    ),
                  )),
            ],
          ),
        ))
      ],
    );
  }

  Widget rowsCidade(String titile, TextEditingController controller) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
          margin: EdgeInsets.only(
              top: paisSelecionado == 'Brasil' ? 20 : 14, right: 26, left: 26),
          padding: const EdgeInsets.only(left: 6),
          decoration: new BoxDecoration(),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                //color: Colors.red,
                margin: const EdgeInsets.only(
                  top: 4,
                ),
                child: new Text(
                  titile,
                  style: TextStyle(
                      color: AppColors.colorTextPerfil,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              new Container(
                  color: Colors.white.withOpacity(0.1),
                  padding: const EdgeInsets.only(left: 16),
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  height: 40,
                  child: new Center(
                    child: TextField(
                      cursorColor: AppColors.colorTextPerfil,
                      //keyboardType: inputType,
                      controller: controller,
                      style: new TextStyle(
                          color: AppColors.colorTextPerfil,
                          fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          isDense: true,
                          // Added this

                          disabledBorder: InputBorder.none,
                          hintStyle: new TextStyle(
                            color: AppColors.colorTextPerfil,
                          ),
                          contentPadding: EdgeInsets.all(0),
                          hintText: ""),
                    ),
                  )),
            ],
          ),
        ))
      ],
    );
  }

  Widget rowsNasc(String titile, TextEditingController controller) {
    final maskCpf = MaskTextInputFormatter(
        mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Expanded(
            child: new Container(
          //height: 60,
          //width: MediaQuery.of(context).size.width,

          margin: const EdgeInsets.only(top: 20, right: 26, left: 26),
          padding: const EdgeInsets.only(left: 6),
          decoration: new BoxDecoration(),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                //color: Colors.red,
                margin: const EdgeInsets.only(
                  top: 4,
                ),
                child: new Text(
                  titile,
                  style: TextStyle(
                      color: AppColors.colorTextPerfil,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              new Container(
                  color: Colors.white.withOpacity(0.1),
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  height: 40,
                  child: new Center(
                    child: TextField(
                      cursorColor: AppColors.colorTextPerfil,
                      inputFormatters: [maskCpf],
                      keyboardType: TextInputType.number,

                      //keyboardType: inputType,
                      controller: controller,
                      style: new TextStyle(
                          color: AppColors.colorTextPerfil,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16.0, bottom: 8),
                      ),
                    ),
                  )),
            ],
          ),
        ))
      ],
    );
  }

  Widget rowsStringPosicao(String titile, String value) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              //color: Colors.red,
              padding: const EdgeInsets.only(left: 6),

              margin: const EdgeInsets.only(
                  left: 26, top: 20, right: 26, bottom: 4),
              child: new Text(
                titile,
                style: TextStyle(
                    color: AppColors.colorTextPerfil,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 26, right: 26),
              height: 40,
              padding: EdgeInsets.only(left: 6),
              child: new Container(
                padding: const EdgeInsets.only(left: 16),
                color: Colors.white.withOpacity(0.1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: Text(
                      "Selecione a Posição",
                      style: new TextStyle(
                          color: AppColors.colorTextPerfil,
                          fontWeight: FontWeight.normal),
                    ),
                    value: posicaoSelecionado,
                    style: TextStyle(
                        color: AppColors.colorTextPerfil,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    dropdownColor: Color(0xff083251),
                    //, Color(0xff112841),
                    onChanged: (newValue) {
                      setState(() {
                        posicaoSelecionado = newValue;
                        //controllerNomeCartaoContaBancaria.text = newValue;
                      });
                    },
                    items: listDropPosicao.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget rowsStringPais(String titile, String value) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              //color: Colors.red,
              padding: const EdgeInsets.only(left: 6),

              margin: const EdgeInsets.only(
                  left: 26, top: 20, right: 26, bottom: 4),
              child: new Text(
                titile,
                style: TextStyle(
                    color: AppColors.colorTextPerfil,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 26, right: 26),
              height: 40,
              padding: EdgeInsets.only(left: 6),
              child: new Container(
                padding: const EdgeInsets.only(left: 16),
                color: Colors.white.withOpacity(0.1),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    hint: Text(
                      "Selecione o País",
                      style: new TextStyle(
                          color: AppColors.colorTextPerfil,
                          fontWeight: FontWeight.normal),
                    ),
                    value: paisSelecionado,
                    style: new TextStyle(
                        color: AppColors.colorTextPerfil,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    dropdownColor: Color(0xff083251),
                    //, Color(0xff112841),
                    onChanged: (newValue) {
                      setState(() {
                        paisSelecionado = newValue;
                        _controllerPais = newValue;
                      });
                    },
                    items: listDropPais.map((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget rowsStringEstado(String titile, String value) {
    if(podeMontarDrops){
      if (paisSelecionado == 'Brasil') {
        return new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      //color: Colors.red,
                      padding: const EdgeInsets.only(left: 6),

                      margin: const EdgeInsets.only(
                          left: 26, top: 20, right: 26, bottom: 4),
                      child: new Text(
                        titile,
                        style: TextStyle(
                            color: AppColors.colorTextPerfil,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 26, right: 26),
                      height: 40,
                      padding: EdgeInsets.only(left: 6),
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.only(left: 16),
                            color: Colors.white.withOpacity(0.1),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                ),

                                isExpanded: true,
                                hint: Text(
                                  "Selecione o Estado",
                                  style: new TextStyle(
                                      color: AppColors.colorTextPerfil,
                                      fontWeight: FontWeight.normal),
                                ),
                                value: estadoSelecionado,
                                style: new TextStyle(
                                    color: AppColors.colorTextPerfil,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                dropdownColor: Color(0xff083251),
                                //, Color(0xff112841),
                                onChanged: (newValue) {
                                  setState(() {
                                    estadoSelecionado = newValue;
                                    //controllerNomeCartaoContaBancaria.text = newValue;
                                  });
                                },
                                items: listDropEstado.map((String? value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value!),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        );
      }
      return new Container();
    }else{
      return new Container();
    }

  }

  Widget rowsStringSexo(String titile, String? value) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              //color: Colors.red,
              padding: const EdgeInsets.only(left: 6),

              margin: const EdgeInsets.only(
                  left: 26, top: 20, right: 26, bottom: 4),
              child: new Text(
                titile,
                style: TextStyle(
                    color: AppColors.colorTextPerfil,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 26, right: 26),
              height: 40,
              padding: EdgeInsets.only(left: 6),
              child: new Stack(
                children: <Widget>[
                  new Container(
                    color: Colors.white.withOpacity(0.1),
                    padding: const EdgeInsets.only(left: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.white,
                        ),

                        isExpanded: true,
                        hint: Text(
                          "Selecione o Sexo",
                          style: new TextStyle(
                              color: AppColors.colorTextPerfil,
                              fontWeight: FontWeight.normal),
                        ),
                        value: sexoSelecionado,
                        style: new TextStyle(
                            color: AppColors.colorTextPerfil,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        dropdownColor: Color(0xff083251),
                        //, Color(0xff112841),
                        onChanged: (newValue) {
                          setState(() {
                            sexoSelecionado = newValue;
                          });
                        },
                        items: listDropSexo.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget rowsLoad(String titile, BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          margin: const EdgeInsets.only(top: 20),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Container(
                margin: const EdgeInsets.only(
                  top: 4,
                ),
                child: new Text(
                  titile,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.white,
                        child: new Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: new BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        )
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

  void dialogDesativarUser(String id, BuildContext context) {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.showAlertDialogActionNoYes(
        context, "Desativar conta?", 'Você será redirecionado ao login e não terá mais acesso ao FuttApp.',
        () async {
      _desativarUser(id, context);
    });
  }

  Future<void> _desativarUser(String idUsuario, BuildContext context) async {
    DialogFutt dialogFutt = new DialogFutt();
    showLoad(context);

    final prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN)!;

    String url = "${ConstantesRest.URL_USUARIOS}/desativa/$idUsuario";
    var response = await http.put(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    });
    Navigator.pop(context);
    if (response.statusCode == 204) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      dialogFutt.waitingSucess(context, "Concluído", "Conta desativada!");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
      //Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => SplashScreenView(
                  splashInicial: true,
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      var _dadosJson = jsonDecode(response.body);
      ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
      _mensagem = exceptionModel.msg;
      dialogFutt.waitingError(
          context, "Erro", "$_mensagem.");
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
  }

  void showLoad(BuildContext context) {
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

  String? primeiroNome(String? nome) {
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
}
