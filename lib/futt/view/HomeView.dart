import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/UtilService.dart';
import 'package:futt/futt/view/DashboardView.dart';
import 'package:futt/futt/view/EscolinhasView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/MinhasRedesView.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/RedesView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {

  TabController _controllerTorneios;
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
    super.initState();
    _controllerTorneios = TabController(
      length: 2, vsync: this, initialIndex: 0,
    );
  }

  int _indiceAtual = 0;
  String _titleAppBar = "Redes";

  @override
  Widget build(BuildContext context) {

    _novaRede() {
      Navigator.pushNamed(context, "/novarede");
    }

    _abrirPerfil() {
      Navigator.pushNamed(context, "/perfil");
    }

    _sairApp() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(ConstantesConfig.PREFERENCES_EMAIL);
      await prefs.remove(ConstantesConfig.PREFERENCES_SENHA);

      //Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginView()));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
      );
    }

    String _getTitleAppBar(indice) {
      _titleAppBar = "Dashboard";
      if (indice == 0) {
        _titleAppBar = "Redes";

      }else if (indice == 2) {
        _titleAppBar = "Escolinhas";
      }
      return _titleAppBar;
    }

    return Scaffold(
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
          title: Text(_titleAppBar),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _novaRede,
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: _abrirPerfil,
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: _sairApp,
            ),
          ],
          bottom:
            _indiceAtual == 0 ? TabBar(
              controller: _controllerTorneios,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: <Widget>[
                Tab(text: "Participante",),
                Tab(text: "Dono",),
              ],
            ) : null,
        ),
      body: _indiceAtual > 0 ?
              (_indiceAtual == 1) ?
                DashboardView() : EscolinhasView("","")

      : TabBarView(
        controller: _controllerTorneios,
        children: <Widget>[
          RedesView(),
          MinhasRedesView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
            _titleAppBar = _getTitleAppBar(indice);
          });
        },
        type: BottomNavigationBarType.fixed, //este e o padrão
        fixedColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            title: Text("Redes"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Dashboard"),
            icon: Icon(Icons.insert_chart),
          ),
          BottomNavigationBarItem(
            title: Text("Escolinhas"),
            icon: Icon(Icons.school),
          )
        ],
      ),
    );
  }
}
