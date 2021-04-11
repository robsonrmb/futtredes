import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futt/futt/view/style/colors.dart';

class RegrasView extends StatefulWidget {
  @override
  _RegrasViewState createState() => _RegrasViewState();
}

class _RegrasViewState extends State<RegrasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            opacity: 1,
          ),
          textTheme:
              TextTheme(title: TextStyle(color: Colors.white, fontSize: 20)),
          title: Text(
            "Regras",
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.colorTextAppNav,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                  AppColors.colorFundoClaroApp,
                  AppColors.colorFundoEscuroApp
                ])),
          ),
        ),
        body: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: new SingleChildScrollView(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Row(
                  children: [
                    new Container(
                      child: new Text(
                        'Regras de uso',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  ],
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: new Text(
                    'Todas as informações cadastradas são de responsabilidade do usuário, tais como:',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: new Text(
                    '- Nome da rede',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: new Text(
                    '- Dados pessoais do atleta',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: new Text(
                    '- Apelido do atleta',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: new Text(
                    'O usuário poderá desativar seu cadastro se não estiver de acordo com as regras através do próprio aplicativo e se for assinante, poderá cancelar sua assinatura utilizando a estrutura da Hotmart seguindo o passo a passo disponível no site oficial do FuttApp (www.futtapp.com.br).',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),

                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: new Text(
                    'Em caso de dúvidas, envie um email para futtapp@gmail.com e responderemos o mais breve possível.',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),

                new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: new Text(
                    'À disposição.',
                    style: new TextStyle(fontSize: 18),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
