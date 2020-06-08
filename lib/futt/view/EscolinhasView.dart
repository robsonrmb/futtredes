import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/service/PaisService.dart';
import 'package:futt/futt/view/subview/EscolinhaSubView.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EscolinhasView extends StatefulWidget {

  String paisDefault;
  String cidadeDefault;
  EscolinhasView(this.paisDefault, this.cidadeDefault);

  @override
  _EscolinhasViewState createState() => _EscolinhasViewState();
}

class _EscolinhasViewState extends State<EscolinhasView> {
  TextEditingController _controllerCidade = TextEditingController();
  String _controllerPais = "";

  String _pais = "";
  String _cidade = "";

  _pesquisarEscolinhas() {
    setState(() {
      _pais = _controllerPais;
      _cidade = _controllerCidade.text;
    });
  }

  Future<List<PaisModel>> _listaPaises() async {
    PaisService paisService = PaisService();
    return paisService.listaPaises();
  }

  @override
  Widget build(BuildContext context) {

    return new Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.find_in_page,
                        color: Color(0xff086ba4),
                      ),
                      Text("PESQUISA ESCOLINHAS",
                        style: TextStyle(
                          color: Color(0xff086ba4),
                          fontSize: 12,
                          fontFamily: 'Candal',
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Pesquisa de escolinha"),
                        content: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Cidade",
                                ),
                                maxLength: 20,
                                controller: _controllerCidade,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
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
                              _pesquisarEscolinhas();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: EscolinhaSubView(_pais, _cidade, widget.paisDefault, widget.cidadeDefault),
        )
      ],
    );
  }
}
