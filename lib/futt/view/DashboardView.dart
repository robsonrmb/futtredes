import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:futt/futt/view/NoticiasView.dart';
import 'package:futt/futt/view/RankingView.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  int _indiceSubviewAtual = 1;
  bool _aba1 = false;
  bool _aba2 = true;
  bool _aba3 = false;

  List<Widget> subviews_dashboard = [
    NoticiasView(),
    EstatisticasView(),
    RankingView(2020, 7)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              color: Color(0xff093352),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _indiceSubviewAtual = 0;
                            _aba1 = true;
                            _aba2 = false;
                            _aba3 = false;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Notícias",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: _aba1? Colors.white : Colors.grey[500],
                                    fontFamily: 'Candal'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _indiceSubviewAtual = 1;
                            _aba1 = false;
                            _aba2 = true;
                            _aba3 = false;
                          });
                        },
                        child: Text(
                          "Estatísticas",
                          style: TextStyle(
                              fontSize: 14,
                              color: _aba2? Colors.white : Colors.grey[500],
                              fontFamily: 'Candal'
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _indiceSubviewAtual = 2;
                            _aba1 = false;
                            _aba2 = false;
                            _aba3 = true;
                          });
                        },
                        child: Text(
                          "Ranking",
                          style: TextStyle(
                              fontSize: 14,
                              color: _aba3? Colors.white : Colors.grey[500],
                              fontFamily: 'Candal'
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.orange, height: 4,
            ),
            Expanded(
              child: Container(
                child: subviews_dashboard[_indiceSubviewAtual],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
