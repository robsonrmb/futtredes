import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futt/futt/view/CadastroView.dart';
import 'package:futt/futt/view/EdicaoRedeView.dart';
import 'package:futt/futt/view/HomeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/LoginView.dart';
import 'package:futt/futt/view/MinhasRedesView.dart';
import 'package:futt/futt/view/NovaRedeView.dart';
import 'package:futt/futt/view/IntegrantesView.dart';
import 'package:futt/futt/view/PerfilView.dart';
import 'package:futt/futt/view/SplashScreenView.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides ();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color(0xff112841),
      100: Color(0xff112841),
      200: Color(0xff112841),
      300: Color(0xff112841),
      400: Color(0xff112841),
      500: Color(0xff112841),
      600: Color(0xff112841),
      700: Color(0xff112841),
      800: Color(0xff112841),
      900: Color(0xff112841),
    };
    MaterialColor colorCustom = MaterialColor(0xff112841, color);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Color(0xff112841),
    // ));
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/cadastro" : (context) => CadastroView(),
        "/home" : (context) => HomeView(),
        "/jogos" : (context) => JogosView(),
        "/participantes" : (context) => IntegrantesView(),
        "/novarede" : (context) => NovaRedeView(),
        "/edicaorede" : (context) => EdicaoRedeView(),
        "/minhasredes" : (context) => MinhasRedesView(),
        "/perfil" : (context) => PerfilView(),
      },
      home:  SplashScreenView(splashInicial: true,),
      theme: ThemeData(
        primarySwatch: colorCustom,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          )

      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String Host, int port)=> true;
  }
}



