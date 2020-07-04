import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/RankingView.dart';
import 'package:futt/futt/view/components/TopoInterno.dart';
import 'package:futt/futt/view/subview/RankingRedeSubView.dart';

class RankingRedeView extends StatefulWidget {

  int idRede;
  String nomeRede;
  int statusRede;
  int ano;
  RankingRedeView(this.idRede, this.nomeRede, this.statusRede, this.ano);

  @override
  _RankingRedeViewState createState() => _RankingRedeViewState();
}

class _RankingRedeViewState extends State<RankingRedeView> {

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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star_half),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => RankingView(widget.idRede, widget.nomeRede, widget.statusRede, widget.ano),
            ));
        },
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TopoInterno().getTopo(widget.nomeRede, widget.statusRede),
            Expanded(
              child: RankingRedeSubView(widget.idRede, widget.nomeRede, widget.ano, 4),
            )
          ],
        ),
    );
  }
}
