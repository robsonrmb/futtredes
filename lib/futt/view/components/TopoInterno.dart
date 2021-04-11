import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';

class TopoInterno {

  Widget getTopo(String _nomeRede, int _statusRede) {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // color: Colors.black12,
                color: Colors.black.withOpacity(0.5),

                blurRadius: 5
            )
          ]
      ),
      child: Column(
        children: <Widget>[
          new Container(
            height: 5,
            decoration: new BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),

              ),
              gradient:  LinearGradient(
                colors: <Color>[AppColors.colorEspecialPrimario1, AppColors.colorEspecialPrimario2],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Text(_nomeRede,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: FontFamily.fontSpecial,
                  color: _statusRede < 3 ? (_statusRede == 1) ? Color(0xff093352): Color(0xff093352) : Colors.grey[400]
              ),
            ),
          ),
        ],
      ),
    );


      Container(
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