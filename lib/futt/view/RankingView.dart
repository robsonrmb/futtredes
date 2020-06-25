import 'package:flutter/material.dart';
import 'package:futt/futt/view/subview/RankingSubView.dart';

class RankingView extends StatefulWidget {

  int idRede;
  int ano;
  RankingView(this.idRede, this.ano);

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> with TickerProviderStateMixin {

  TabController _controllerRanking;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controllerRanking = TabController(
      length: 3, vsync: this, initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {

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
        title: Text("Ranking"),
        bottom: TabBar(
            controller: _controllerRanking,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: <Widget>[
              Tab(text: "Vitórias",),
              Tab(text: "Jogos",),
              Tab(text: "Pontos",),
            ],
          )
      ),
      body: TabBarView(
        controller: _controllerRanking,
        children: <Widget>[
          RankingSubView(widget.idRede, widget.ano, 1),
          RankingSubView(widget.idRede, widget.ano, 2),
          RankingSubView(widget.idRede, widget.ano, 3),
        ],
      ),
    );
  }
}
