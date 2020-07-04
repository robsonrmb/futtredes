import 'package:flutter/material.dart';

class CabecalhoLista {

  Widget cabecalho(String _nomeRede, String _nomePais, String _nomeCidade, String _nomeLocal, int _statusRede) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
        /*image: DecorationImage(
            image: NetworkImage('${ConstantesRest.URL_BASE_AMAZON}semImagem.png'),
            fit: BoxFit.cover
        ),*/
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Text(_nomeRede,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Candal',
                  color: _statusRede < 3 ? (_statusRede == 1) ? Color(0xff093352): Colors.blue : Colors.grey[800]
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text("${_nomePais} - ${_nomeCidade}",
              style: TextStyle(
                  fontSize: 12,
                  color: _statusRede < 3 ? (_statusRede == 1) ? Color(0xff093352): Colors.blue : Colors.grey[800]
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Text("${_nomeLocal}",
              style: TextStyle(
                  fontSize: 12,
                  color: _statusRede < 3 ? (_statusRede == 1) ? Color(0xff093352): Colors.blue : Colors.grey[800]
              ),
            ),
          ),
        ],
      ),
    );
  }
}