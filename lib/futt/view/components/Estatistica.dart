import 'package:flutter/material.dart';

class Estatistica {

    jogo(String valor) {
      bool vitoria = true;
      if (valor != 'V') {
        vitoria = false;
      }
      return new Container(
        decoration: vitoria ? BoxDecoration(
          color: Color(0xff093352),
          borderRadius: BorderRadius.circular(50),
        ) : BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: vitoria ? Center(
          child: Text(" V ",
            style: TextStyle(
              fontFamily: 'Candal',
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ) : Center(
          child: Text(" D ",
            style: TextStyle(
              fontFamily: 'Candal',
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      );
    }

    torneio(int _colocacao) {
      return new Container(
        width: 50,
        decoration: BoxDecoration(
          color: Color(0xff89d5ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(" ${_colocacao}º ",
            style: TextStyle(
              fontFamily: 'Candal',
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      );
    }

    pontos(int _anos, int _pontos) {
      return new Container(
        height: 30, width: 100,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(" ${_anos} - ${_pontos}pts ",
            style: TextStyle(
              fontFamily: 'Candal',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    jogos(int _anos, int _jogos) {
      return new Container(
        height: 30, width: 100,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(" ${_anos} - ${_jogos} ",
            style: TextStyle(
              fontFamily: 'Candal',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      );
    }
}