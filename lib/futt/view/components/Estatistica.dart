import 'package:flutter/material.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';

class Estatistica {

    resultadoJogo(String valor,bool first) {
      bool vitoria = true;
      if (valor != 'V') {
        vitoria = false;
      }
      if(first){
        return
          new Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(width: 2,color:!vitoria? Colors.orange:AppColors.colorFundoCardJogosEscuro)
            ),
            child: Container(
              height: 40, width: 40,
              decoration: vitoria ? BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.colorFundoCardJogosClaro,
                      AppColors.colorFundoCardJogosEscuro,
                    ]),
                borderRadius: BorderRadius.circular(40),
              ) : BoxDecoration(
                gradient:  LinearGradient(
                  colors: <Color>[AppColors.colorEspecialPrimario1, AppColors.colorEspecialPrimario2],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: vitoria ? Center(
                child: Text(" V ",
                  style: TextStyle(
                    fontFamily: FontFamily.fontSpecial,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ) : Center(
                child: Text(" D ",
                  style: TextStyle(
                    fontFamily: FontFamily.fontSpecial,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
      }
      return
        new Container(
        height: 40, width: 40,
        decoration: vitoria ? BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  AppColors.colorFundoCardJogosClaro,
                  AppColors.colorFundoCardJogosEscuro,
                ]),
          borderRadius: BorderRadius.circular(40),
        ) : BoxDecoration(
          gradient:  LinearGradient(
            colors: <Color>[AppColors.colorEspecialPrimario1, AppColors.colorEspecialPrimario2],
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: vitoria ? Center(
          child: Text(" V ",
            style: TextStyle(
              fontFamily: FontFamily.fontSpecial,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ) : Center(
          child: Text(" D ",
            style: TextStyle(
              fontFamily: FontFamily.fontSpecial,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    jogosPontos(int _anos, int _jogos, int _posicao,bool jogos) {
      return new Container(
        width: 140,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: <Color>[
            !jogos? AppColors.colorFundoCardJogosClaro:AppColors.colorEspecialPrimario1,
            !jogos?AppColors.colorFundoCardJogosEscuro:AppColors.colorEspecialPrimario2,
          ]),
          image: DecorationImage(
              image: AssetImage("images/torneiosCard.png"),
              alignment: Alignment.topRight,
              fit: BoxFit.scaleDown),
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset:
              Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: new Container(
          margin: const EdgeInsets.only(left: 8),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "$_anos",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    fontFamily: FontFamily.fontSpecial,
                  ),
                ),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "$_jogos",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      fontFamily: FontFamily.fontSpecial,
                    ),
                  ),
                  Text(
                    jogos?"Jogos":"Pontos",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  new Container(height: 10,)
                ],
              )
            ],
          ),
        ),
      );


        Column(
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