import 'dart:convert';
import 'package:futt/futt/view/NovaRedeView.dart';
import 'package:futt/futt/view/RegasView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/LoginModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/view/DashboardView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/MinhasRedesView.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/PerfilUserView.dart';
import 'package:futt/futt/view/PerfilView.dart';
import 'package:futt/futt/view/RedesView.dart';
import 'package:futt/futt/view/SplashScreenView.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  TabController? _controllerTorneios;
  int _currentIndex = 0;

  TextEditingController _controllerNome = TextEditingController();
  String _controllerPais = "";
  TextEditingController _controllerCidade = TextEditingController();
  TextEditingController _controllerData = TextEditingController();

  int _indiceDeBusca = 0; //Busca todos os torneios
  String _nomeFiltro = "";
  String _paisFiltro = "";
  String _cidadeFiltro = "";
  String _dataFiltro = "";

  late SharedPreferences pref;

  UsuarioModel? usuarioModel;
  bool? assinante = false;
  bool permiteCriarRede = true;

  List<String> choices = <String>[
    "Regras",
    "Sair",
  ];

  _pesquisarTorneios() {
    setState(() {
      _indiceDeBusca = 1; //Busca por filtros
      _nomeFiltro = _controllerNome.text;
      _paisFiltro = _controllerPais;
      _cidadeFiltro = _controllerCidade.text;
      _dataFiltro = _controllerData.text;
    });
  }

  Future<List<PaisModel>> _listaPaises() async {
    UtilService utilService = UtilService();
    return utilService.listaPaises();
  }

  @override
  void initState() {
    buscarFoto();
    inicializarShared();
    super.initState();
  }

  void inicializarShared() async {
    pref = await SharedPreferences.getInstance();
    assinante = pref.getBool(ConstantesConfig.PREFERENCES_ASSINANTE);
    pref.setBool('restart', false);
    print('Assinante: $assinante');
    if (mounted) setState(() {});
  }

  void buscarFoto() async {
    usuarioModel = await _buscaUsuarioLogado();
    if (usuarioModel != null) {
      if (usuarioModel!.qtdRedePromocional! >= usuarioModel!.numMaximoRedePromocional!) {
        permiteCriarRede = false;
      }
      setState(() {});
    }
  }

  int _indiceAtual = 0;
  String _titleAppBar = "Redes";

  _novaRede() async{
    DialogFutt dialogFutt = new DialogFutt();

    if(assinante!){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NovaRedeView(userModel: usuarioModel,assinante: assinante,)),
      ).then((value) => buscarFoto());

    }else{
      if(permiteCriarRede){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NovaRedeView(userModel: usuarioModel,assinante: assinante,)),
        ).then((value) => buscarFoto());
      }else{
        dialogFutt.waiting(context, "Atenção", "Funcionalidade permitida somente para assinantes.");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
      }
    }
  }

  _abrirPerfil() async {
    pref.setBool('restart', true);

    //Navigator.pushNamed(context, "/perfil");
    bool fotoAlterada = await Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) => PerfilView(
            image: '${ConstantesRest.URL_STATIC_USER}${usuarioModel!.nomeFoto}',
            usuarioModel: usuarioModel,
          ),
        ));

    if (fotoAlterada) {
      buscarFoto();
    }
  }

  verificarUsuario() async {
    pref = await SharedPreferences.getInstance();
    String? email = pref.getString(ConstantesConfig.PREFERENCES_EMAIL);
    String? senha = pref.getString(ConstantesConfig.PREFERENCES_SENHA);
    if (email != null && senha != null && email != "" && senha != "") {
      LoginModel loginModel = LoginModel(email, senha);

      var _url = "${ConstantesRest.URL_LOGIN}";
      var _dados = loginModel.toJson();

      http.Response response = await http.post(Uri.parse(_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(_dados));

      if (response.statusCode == 200) {
        buscarFoto();
      }
    }
  }

  _abrirPerfil_(UsuarioModel usuarioModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PerfilUserView(
                  usuarioModel: usuarioModel,
                )));
  }

  _sairApp() async {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.showAlertDialogActionNoYes(
        context, "Deslogar?", 'Deseja realmente se Deslogar?', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      //Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => SplashScreenView(
                  splashInicial: true,
                )),
        (Route<dynamic> route) => false,
      );
    });
  }

  String _getTitleAppBar(indice) {
    switch (indice) {
      case 0:
        _titleAppBar = "Redes";
        return _titleAppBar;
        break;
      case 1:
        _titleAppBar = "Minhas Redes";
        return _titleAppBar;
        break;
      case 2:
        _titleAppBar = "Dashboard";
        return _titleAppBar;
        break;
      default:
        _titleAppBar = "Dashboard";
        return _titleAppBar;
        break;
    }
  }

  Future<UsuarioModel?> _buscaUsuarioLogado() async {
    UsuarioService usuarioService = UsuarioService();
    UsuarioModel? usuario =
        await usuarioService.buscaLogado();
    return usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          opacity: 1,
        ),
        title: Text(
          _titleAppBar,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.colorTextAppNav,
          ),
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _novaRede,
            color: AppColors.colorTextAppNav,
          ),
          new Container(
            height: 36,
            width: 36,
            //margin: const EdgeInsets.only(right: 20),
            child: usuarioModel != null
                ? new GestureDetector(
                    onTap: _abrirPerfil,
                    child: new Hero(
                      tag: 'perfil',
                      child: Container(
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image: NetworkImage(
                                      "${ConstantesRest.URL_STATIC_USER}${usuarioModel!.nomeFoto}")),
                              border: Border.all(color: Colors.white))),
                    ))
                : Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.5),
                    highlightColor: Colors.white,
                    child: new Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    )),
          ),
          // IconButton(
          //   icon: Icon(Icons.person),
          //   onPressed: _abrirPerfil, //_(usuarioModel),
          // ),

          PopupMenuButton(
            onSelected: (dynamic value) {
              selectedChoice(value);
            },
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: FaIcon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.white,
              size: 17,
            ),
          )
        ],
      ),
      body: buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.colorFundoButtonNav,

        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
            _titleAppBar = _getTitleAppBar(indice);
          });
        },
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        //este e o padrão
        fixedColor: AppColors.colorTextAppNav,
        items: [
          BottomNavigationBarItem(
            label: 'Redes',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
              label: 'Dono', icon: FaIcon(FontAwesomeIcons.addressBook)),
          BottomNavigationBarItem(
              label:'Dashboard',
              icon: FaIcon(FontAwesomeIcons.chartLine)),
        ],
      ),
    );
  }

  Widget buildBody() {
    switch (_indiceAtual) {
      case 0:
        return RedesView();
        // TabBarView(
        //       controller: _controllerTorneios,
        //       children: <Widget>[
        //         RedesView(),
        //         MinhasRedesView(),
        //       ],
        //     );
        break;
      case 1:
        return MinhasRedesView();
        break;
      case 2:
        pref.setBool('restart', false);
        return DashboardView(
          nome: usuarioModel!.nome,
          nomeFoto: usuarioModel!.nomeFoto,
          pais: usuarioModel!.pais,
          apelido: usuarioModel!.apelido,
          user: usuarioModel!.user,
          estado: usuarioModel!.estado,
          localOndeJoga: usuarioModel!.ondeJoga,
          posicao: usuarioModel!.posicao,
          idUser: usuarioModel!.id,
        );
        break;
      default:
        return new Container();
        break;
    }
  }

  void selectedChoice(String value) {
    switch (value) {
      case "Regras":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegrasView()));
        break;
      case "Sair":
        //dialogLogout();
        _sairApp();
        break;
      default:
        break;
    }
  }
}
