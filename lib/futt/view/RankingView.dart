import 'package:flutter/material.dart';
import 'package:futt/futt/view/subview/RankingSubView.dart';

class RankingView extends StatefulWidget {

  int anoDefault;
  int idRankingDefault;
  RankingView(this.anoDefault, this.idRankingDefault);

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {

  TextEditingController _controllerAno = TextEditingController();
  int _controllerRankingEntidade = 0;

  String _ano = "0";
  int _idRankingEntidade = 0;

  _pesquisarRanking() {
    setState(() {
      _ano = "0";
      if(_controllerAno.text != "") {
        _ano = _controllerAno.text;
      }
      _idRankingEntidade = _controllerRankingEntidade;
    });
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
                        Text("PESQUISA RANKING DE OUTRAS ENTIDADES",
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
                          title: Text("Pesquisa de ranking"),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Ano",
                                  ),
                                  maxLength: 4,
                                  controller: _controllerAno,
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
                                _pesquisarRanking();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                    },
                  ),
                ),
                Text(
                  "CBFv - Profissional!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Candal'
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RankingSubView(1,1,1,1),
          )
        ],
      );
  }
}
