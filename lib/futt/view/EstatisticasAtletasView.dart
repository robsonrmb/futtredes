import 'package:futt/futt/view/EstatisticasView.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';

class EstatisticasAtletasView extends StatefulWidget {
  int idUsuario;
  int idRede;
  String nomeRede;
  String nome;
  String nomeFoto;
  String hero;
  int colocacao;
  String cidade;
  String apelido;
  String user;

  EstatisticasAtletasView(
      this.idUsuario, this.idRede, this.nomeRede, this.nome, this.nomeFoto,
      {this.hero, this.colocacao, this.cidade, this.apelido, this.user});

  @override
  _EstatisticasAtletasViewState createState() =>
      _EstatisticasAtletasViewState();
}

class _EstatisticasAtletasViewState extends State<EstatisticasAtletasView> {
  @override
  Widget build(BuildContext context) {
    double _tam = 90;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Estatísticas",
          style: TextStyle(
              color: AppColors.colorTextAppNav, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                AppColors.colorFundoClaroApp,
                AppColors.colorFundoEscuroApp
              ])),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: EstatisticasView(
                    widget.idUsuario,
                    widget.idRede,
                    widget.nomeRede,
                    widget.nome,
                    widget.nomeFoto,
                    hero: widget.hero,
                    colocacao: widget.colocacao,
                    cidade: widget.cidade,
                    apelido: widget.apelido,
                    user: widget.user,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
