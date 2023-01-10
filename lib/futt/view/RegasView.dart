import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/imgHome1.png"), fit: BoxFit.fill)),
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
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
                            colors: <Color>[
                              Colors.grey,
                              Colors.grey[100]
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.all(10),
                        child:
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              'Contatos',
                              style: new TextStyle(fontSize: 16, color: Color(0xff093352), fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.all(10),
                        child:
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              'Em caso de dúvidas, sugestões, críticas, atualizações de cadastros, mudança de planos ou '
                                  'qualquer outra questão relacionada ao aplicativo, envie uma mensagem para o email abaixo '
                                  'que responderemos o mais breve possível.',
                              style: new TextStyle(fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            new Container(height: 10,),
                            new Text(
                              '- futtapp@gmail.com',
                              style: new TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.start,
                            ),
                            new Container(height: 10,),
                            new Text(
                              'À disposição.',
                              style: new TextStyle(fontSize: 14),
                              textAlign: TextAlign.start,

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
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
                            colors: <Color>[
                              Colors.grey,
                              Colors.grey[100]
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.all(10),
                        child:
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              'Regras',
                              style: new TextStyle(fontSize: 16, color: Color(0xff093352), fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.all(10),
                        child:
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              'Todas as informações disponíveis no aplicativo são de responsabilidade do usuário, '
                                  'dentre elas, os dados pessoais do cadastro e os dados de redes.',
                              style: new TextStyle(fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            new Container(height: 10,),
                            new Text(
                              'Todas as regras, planos, custos e demais informações podem ser obtidas a partir do site:',
                              style: new TextStyle(fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            new Container(height: 10,),
                            new Text(
                              'http://www.futtapp.com.br',
                              style: new TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.start,
                            ),
                            new Container(height: 10,),
                            new Text(
                              'Endereço alternativo: '
                                  'http://www.kmaops.hospedagemelastica.com.br/futback/',
                              style: new TextStyle(fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
