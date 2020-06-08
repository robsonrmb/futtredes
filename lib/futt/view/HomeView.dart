import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/PaisService.dart';
import 'package:futt/futt/view/DashboardView.dart';
import 'package:futt/futt/view/EscolinhasView.dart';
import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:futt/futt/view/InfoEscolinhasView.dart';
import 'package:futt/futt/view/InfoTorneiosView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/MeusTorneiosView.dart';
import 'package:futt/futt/view/NoticiasView.dart';
import 'package:futt/futt/view/NovoTorneioView.dart';
import 'package:futt/futt/view/RankingView.dart';
import 'package:futt/futt/view/TorneiosView.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {

  TabController _controllerDashboard;
  TabController _controllerTorneios;
  TabController _controllerEscolinha;
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
    PaisService paisService = PaisService();
    return paisService.listaPaises();
  }

  @override
  void initState() {
    super.initState();
    _controllerDashboard = TabController(
      length: 3, vsync: this, initialIndex: 0,
    );
    _controllerTorneios = TabController(
      length: 3, vsync: this, initialIndex: 1,
    );
    _controllerEscolinha = TabController(
      length: 2, vsync: this, initialIndex: 1,
    );
  }

  int _indiceAtual = 1;
  String _titleAppBar = "Dashboard";

  @override
  Widget build(BuildContext context) {
    /*
    List<Widget> views = [
      TorneiosView(),
      DashboardView(),
      EscolinhasView("","")
    ];
    */
    _abrirAvaliacoes() {
      print("Abrindo avaliações...");
      Navigator.pushNamed(context, "/avaliacoes");
    }

    _abrirPerfil() {
      print("Abrindo perfil...");
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
        _titleAppBar = "Torneios";

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
              onPressed: _abrirAvaliacoes,
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
            _indiceAtual > 0 ?
                (_indiceAtual == 1) ?
                    TabBar(
                      controller: _controllerDashboard,
                      tabs: <Widget>[
                        Tab(text: "Notícias",),
                        Tab(text: "Dashboard",),
                        Tab(text: "Ranking",),
                      ],

                    ) : TabBar(
                      controller: _controllerEscolinha,
                      tabs: <Widget>[
                        Tab(text: "Informações",),
                        Tab(text: "Escolinhas",),
                      ],
                    )

          : TabBar(
              controller: _controllerTorneios,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: <Widget>[
                Tab(text: "Novo",),
                Tab(text: "Pesquisa",),
                Tab(text: "Meus",),
              ],
            ),
        ),
        floatingActionButton: (_indiceAtual == 0 && _currentIndex == 1) ? FloatingActionButton(
          child: Icon(Icons.filter),
          onPressed: () {
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("Pesquise seu torneio"),
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Nome",
                        ),
                        controller: _controllerNome,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Datas",
                        ),
                        controller: _controllerData,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Cidade ou local",
                        ),
                        controller: _controllerCidade,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: FindDropdown<PaisModel>(
                          label: "País",
                          showSearchBox: false,
                          onFind: (String filter) => _listaPaises(),
                          searchBoxDecoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (PaisModel data) => _controllerPais = data.id,
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
                        "Pesquisar",
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
                      _pesquisarTorneios();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
          },
        ) : null,
      body: _indiceAtual > 0 ?
              (_indiceAtual == 1) ?
                  TabBarView(
                    controller: _controllerDashboard,
                    children: <Widget>[
                      NoticiasView(),
                      EstatisticasView(),
                      RankingView(2020, 7)
                    ],
                  ) : TabBarView(
                        controller: _controllerEscolinha,
                        children: <Widget>[
                          InfoEscolinhasView(),
                          EscolinhasView("", ""),
                        ],
                      )

      : TabBarView(
        controller: _controllerTorneios,
        children: <Widget>[
          InfoTorneiosView(),
          TorneiosView(),
          MeusTorneiosView(),
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
        fixedColor: Color(0xfff79e07),
        items: [
          BottomNavigationBarItem(
            title: Text("Torneios"),
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            title: Text("Dahboard"),
            icon: Icon(Icons.home),
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
