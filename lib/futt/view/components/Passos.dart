import 'package:flutter/material.dart';

class Passos {

  Widget getPassos(int passo) {
    return Center(
        child: Column(children: <Widget>[
          Text("Cadastre sua rede",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
          Text("Pode indicar até 3 responsáveis.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Text("Cadastre os integrantes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
          Text("Disponível até 50 integrantes por rede.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Text("Cadastre os jogos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
          Text("Informe os resultados para gerar as estatísticas.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Text("Veja o ranking e estatísticas",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),),
          Text("E confira sua performance.",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
        ],)
    );
  }
}