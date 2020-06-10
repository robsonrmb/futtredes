import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/subview/RedesSubView.dart';

class RedesView extends StatefulWidget {
  @override
  _RedesViewState createState() => _RedesViewState();
}

class _RedesViewState extends State<RedesView> {

  int _indiceDeBusca = 0; //Busca todos os torneios
  String _nomeFiltro = "";
  String _paisFiltro = "";
  String _cidadeFiltro = "";
  String _dataFiltro = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: RedesSubView(_indiceDeBusca, _nomeFiltro, _paisFiltro, _cidadeFiltro, _dataFiltro),
        )
      ],
    )
    );
  }
}

