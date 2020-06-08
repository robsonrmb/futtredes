import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/PaisService.dart';
import 'package:futt/futt/view/subview/TorneiosSubView.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TorneiosView extends StatefulWidget {
  @override
  _TorneiosViewState createState() => _TorneiosViewState();
}

class _TorneiosViewState extends State<TorneiosView> {

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
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /*
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/novo_torneio");
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Novo",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Candal'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  */
                  /*
                  RaisedButton(
                    color: Color(0xff086ba4),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Filtrar",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Candal',
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    onPressed: (){
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
                  ),
                  */
                  /*
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/meustorneios");
                    },
                    child: Text(
                      "Meus",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Candal'
                      ),
                    ),
                  ),
                  */
                ],
              ),
            ],
          ),
        ),
        /*
        Container(
          padding: EdgeInsets.all(5),
          color: Colors.orange, height: 4,
        ),
        */
        Expanded(
          child: TorneiosSubView(_indiceDeBusca, _nomeFiltro, _paisFiltro, _cidadeFiltro, _dataFiltro),
        )
      ],
    );
  }
}

