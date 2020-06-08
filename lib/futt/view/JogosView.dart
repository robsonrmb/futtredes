import 'package:futt/futt/constantes/ConstantesFasesDeJogos.dart';
import 'package:futt/futt/view/subview/JogosTorneioSubView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JogosView extends StatefulWidget {

  int idTorneio;
  String nomeTorneio;
  int statusTorneio;
  int idSubView;
  bool editaPlacar;
  JogosView({this.idTorneio, this.nomeTorneio, this.statusTorneio, this.idSubView, this.editaPlacar});

  @override
  _JogosViewState createState() => _JogosViewState();
}

class _JogosViewState extends State<JogosView> {

  int _indiceAtual = 0;
  int _indiceFase = 0;
  int _paramFase = 0;
  double _opacidadeLeft = 0.3;
  double _opacidadeRight = 1.0;
  String _fase = "";
  List<String> _fases;
  Map<int, int> _mapaDoIdFases;

  _faseAnterior() {
    if (_indiceFase > 0) {
      setState(() {
        _indiceFase = _indiceFase - 1;
        _paramFase = _mapaDoIdFases[_indiceFase];
        _fase = _fases[_indiceFase];
        _indiceAtual = 0;
        _opacidadeRight = 1.0;
        _opacidadeLeft = 1.0;
        if (_indiceFase == 0) {
          _opacidadeLeft = 0.3;
        }
      });
    }else{

    }
  }

  _proximaFase() {
    if (_indiceFase < _fases.length-1) {
      setState(() {
        _indiceFase = _indiceFase + 1;
        _paramFase = _mapaDoIdFases[_indiceFase];
        _fase = _fases[_indiceFase];
        _indiceAtual = 0;
        _opacidadeLeft = 1.0;
        _opacidadeRight = 1.0;
        if (_indiceFase == _fases.length-1) {
          _opacidadeRight = 0.3;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _indiceFase = 0;
    if (widget.idSubView == 1) { //Eliminatória simples com 16 duplas
      _mapaDoIdFases = {
        0: ConstantesFasesDeJogos.OITAVAS,
        1: ConstantesFasesDeJogos.QUARTAS,
        2: ConstantesFasesDeJogos.SEMIFINAL,
        3: ConstantesFasesDeJogos.FINAL,
        4: ConstantesFasesDeJogos.TERCEIRO_LUGAR
      };
      setState(() {
        _paramFase = _mapaDoIdFases[0];
        _fase = "8ª de Final";
        _fases = [
          "8ª de Final",
          "4ª de Final",
          "Semifinal",
          "Final",
          "Terceiro Lugar"
        ];
      });
    }else if (widget.idSubView == 2) { //Eliminatória simples com 8 duplas
      _mapaDoIdFases = {
        0: ConstantesFasesDeJogos.QUARTAS,
        1: ConstantesFasesDeJogos.SEMIFINAL,
        2: ConstantesFasesDeJogos.FINAL,
        3: ConstantesFasesDeJogos.TERCEIRO_LUGAR
      };
      setState(() {
        _paramFase = _mapaDoIdFases[0];
        _fase = "4ª de Final";
        _fases = [
          "4ª de Final",
          "Semifinal",
          "Final",
          "Terceiro Lugar"
        ];
      });
    }else if (widget.idSubView == 3) { //Eliminatória simples com 4 duplas
      _mapaDoIdFases = {
        0: ConstantesFasesDeJogos.SEMIFINAL,
        1: ConstantesFasesDeJogos.FINAL,
        2: ConstantesFasesDeJogos.TERCEIRO_LUGAR
      };
      setState(() {
        _fase = "Semifinal";
        _fases = [
          "Semifinal",
          "Final",
          "Terceiro Lugar"
        ];
      });
    }else if (widget.idSubView == 4) { //Dupla Eliminatória
      _mapaDoIdFases = {
        0: ConstantesFasesDeJogos.PRINCIPAL,
        1: ConstantesFasesDeJogos.RESPESCAGEM,
        2: ConstantesFasesDeJogos.SEMIFINAL,
        3: ConstantesFasesDeJogos.FINAL,
        4: ConstantesFasesDeJogos.TERCEIRO_LUGAR
      };
      setState(() {
        _fase = "Principal";
        _fases = [
          "Principal",
          "Repescagem",
          "Semifinal",
          "Final",
          "Terceiro Lugar"
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    bool _edtPlacar = false;
    if (widget.editaPlacar) {
      if (widget.statusTorneio == 40) {
        _edtPlacar = true;
      }
    }

    List<Widget> subViews = [
      JogosTorneioSubView(widget.idTorneio, _paramFase, _edtPlacar),
    ];

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
        title: Text("Jogos"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/group.png"),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Container(
                        height: 40, width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/setaMenor.jpg"),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(_opacidadeLeft),BlendMode.dstATop),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onTap: _faseAnterior,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Text("${_fase}", // ${_indiceFase}
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Candal',
                          ),
                        ),
                        Text(widget.nomeTorneio,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontFamily: 'Candal',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Container(
                        height: 40, width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/setaMaior.jpg"),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(_opacidadeRight), BlendMode.dstATop),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onTap: _proximaFase,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: subViews[_indiceAtual],
            )
          ],
        ),
      ),
    );
  }
}
