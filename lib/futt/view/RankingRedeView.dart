import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/RankingView.dart';
import 'package:futt/futt/view/subview/RankingRedeSubView.dart';
import 'package:futt/futt/view/subview/RankingSubView.dart';

class RankingRedeView extends StatefulWidget {

  int idRede;
  String nomeRede;
  int ano;
  RankingRedeView(this.idRede, this.nomeRede, this.ano);

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
              builder: (context) => RankingView(widget.idRede, widget.nomeRede, widget.ano),
            ));
        },
      ),
      body: RankingRedeSubView(widget.idRede, widget.nomeRede, widget.ano, 4),
    );
  }
}
