import 'package:flutter/material.dart';
import 'package:futt/futt/view/CadastroView.dart';
import 'package:futt/futt/view/EdicaoRedeView.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/MinhasRedesView.dart';
import 'package:futt/futt/view/NovaRedeView.dart';
import 'package:futt/futt/view/ParticipantesView.dart';
import 'package:futt/futt/view/PerfilView.dart';
import 'package:futt/futt/view/ResultadosView.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/cadastro" : (context) => CadastroView(),
      "/home" : (context) => HomeView(),
      "/jogos" : (context) => JogosView(),
      "/resultados" : (context) => ResultadosView(),
      "/participantes" : (context) => ParticipantesView(),
      "/novarede" : (context) => NovaRedeView(),
      "/edicaorede" : (context) => EdicaoRedeView(),
      "/minhasredes" : (context) => MinhasRedesView(),
      "/perfil" : (context) => PerfilView(),
    },
    home: LoginView(),
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.black,

    ),
    debugShowCheckedModeBanner: false,
  ));
}



