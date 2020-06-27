import 'package:flutter/material.dart';

class Estatistica {

    resultadoJogo(String valor) {
      bool vitoria = true;
      if (valor != 'V') {
        vitoria = false;
      }
      return new Container(
        height: 50, width: 50,
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

    jogosPontos(int _anos, int _jogos, int _posicao) {
      return Column(
        children: <Widget>[
          Container(
            height: 70, width: 70,
            decoration: BoxDecoration(
              color: _posicao > 0 ? _posicao == 2 ? Colors.grey[100] : Colors.grey[300] : Colors.orangeAccent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(" ${_jogos} ",
                style: TextStyle(
                  fontFamily: 'Candal',
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          Container(
            height: 30, width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(" ${_anos} ",
                style: TextStyle(
                  fontFamily: 'Candal',
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      );
    }
}