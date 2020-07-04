import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/subview/RankingSubView.dart';

class RankingView extends StatefulWidget {

  int idRede;
  String nomeRede;
  int ano;
  RankingView(this.idRede, this.nomeRede, this.ano);

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> with TickerProviderStateMixin {

  TabController _controllerRanking;

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
        title: Text("Outros rankings"),
        bottom: TabBar(
            controller: _controllerRanking,
            onTap: (index) {},
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
          RankingSubView(widget.idRede, widget.nomeRede, widget.ano, 1),
          RankingSubView(widget.idRede, widget.nomeRede, widget.ano, 2),
          RankingSubView(widget.idRede, widget.nomeRede, widget.ano, 3),
        ],
      ),
    );
  }
}
