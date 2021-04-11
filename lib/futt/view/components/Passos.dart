import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';

class Passos {

  Widget getPassos(int passo) {
    return Center(
        child: Column(children: <Widget>[
          FadeAnimation(0.8, avisos("Cadastre sua rede",'Pode indicar até 3 responsáveis!'),),
          FadeAnimation(1.1, avisos("Cadastre os integrantes",'Disponível até 50 integrantes por rede!'),),
          FadeAnimation(1.4, avisos("Cadastre os jogos",'Informe os resultados para gerar as estatísticas!'),),
          FadeAnimation(1.7,  avisos("Veja o ranking e estatísticas",'E confira sua performance!'),),
          //
          // new Container(
          //   child: Text("Cadastre sua rede",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),),
          // ),
          // Text("Pode indicar até 3 responsáveis.",
          //   style: TextStyle(
          //     color: Colors.black54,
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),),
          // Padding(
          //   padding: EdgeInsets.all(5),
          // ),
          // Text("Cadastre os integrantes",
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),),
          // Text("Disponível até 50 integrantes por rede.",
          //   style: TextStyle(
          //     color: Colors.black54,
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),),
          // Padding(
          //   padding: EdgeInsets.all(5),
          // ),
          // Text("Cadastre os jogos",
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),),
          // Text("Informe os resultados para gerar as estatísticas.",
          //   style: TextStyle(
          //     color: Colors.black54,
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),),
          // Padding(
          //   padding: EdgeInsets.all(5),
          // ),
          // Text("Veja o ranking e estatísticas",
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),),
          // Text("E confira sua performance.",
          //   style: TextStyle(
          //     color: Colors.black54,
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),),
        ],)
    );
  }
  Widget avisos(String title, String subTitle){
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
            height: 10,
            decoration: new BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),

              ),
              gradient:  LinearGradient(
                colors: <Color>[AppColors.colorEspecialSecundario1, AppColors.colorEspecialSecundario2],
              ),
            ),
          ),
          new Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: FontFamily.fontSpecial,
                      color: Color(0xff093352)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.fontSpecial,
                      color: Color(0xff093352)
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}