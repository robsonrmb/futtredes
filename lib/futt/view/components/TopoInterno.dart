import 'package:flutter/material.dart';

class TopoInterno {

  Widget getTopo(String _nomeRede, int _statusRede) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(5),
        color: _statusRede < 3 ? (_statusRede == 1) ? Colors.grey[200] : Colors.lightBlue : Colors.grey[200]
        /*image: DecorationImage(
            image: NetworkImage('${ConstantesRest.URL_BASE_AMAZON}semImagem.png'),
            fit: BoxFit.cover
        ),*/
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Text(_nomeRede,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Candal',
                  color: _statusRede < 3 ? (_statusRede == 1) ? Color(0xff093352): Colors.white : Colors.grey[400]
              ),
            ),
          ),
        ],
      ),
    );
  }
}