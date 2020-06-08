import 'package:flutter/material.dart';
import 'package:futt/futt/view/AvaliacoesView.dart';
import 'package:futt/futt/view/CadastroView.dart';
import 'package:futt/futt/view/EdicaoTorneioView.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/MeusTorneiosView.dart';
import 'package:futt/futt/view/NovaAvaliacaoView.dart';
import 'package:futt/futt/view/NovoTorneioView.dart';
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
      "/novo_torneio" : (context) => NovoTorneioView(),
      "/edicao_torneio" : (context) => EdicaoTorneioView(),
      "/meustorneios" : (context) => MeusTorneiosView(),
      "/perfil" : (context) => PerfilView(),
      "/avaliacoes" : (context) => AvaliacoesView(),
      "/nova_avaliacao" : (context) => NovaAvaliacaoView(0),
    },
    home: LoginView(),
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.black,

    ),
    debugShowCheckedModeBanner: false,
  ));
}



