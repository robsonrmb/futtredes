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
                  margin: const EdgeInsets.only(top: 4),
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
                      new Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Text('Regras de uso',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: FontFamily.fontSpecial,
                                  color: Color(0xff093352)
                              ),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 16,bottom: 16,top: 6,right: 16),
                            child: Text('Todas as informações cadastradas são de responsabilidade do usuário, tais como:',
                              textAlign: TextAlign.start,
                              style: new TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // new Row(
                //   children: [
                //     new Container(
                //       child: new Text(
                //         'Regras de uso',
                //         style: new TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 20),
                //       ),
                //     )
                //   ],
                // ),
                // new Container(
                //   margin: const EdgeInsets.only(top: 30),
                //   child: new Text(
                //     'Todas as informações cadastradas são de responsabilidade do usuário, tais como:',
                //     style: new TextStyle(fontSize: 18),
                //   ),
                // ),

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
                     new Row(
                       children: [
                         new Container(
                           margin: const EdgeInsets.only(left: 16),
                           child:  new Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               new Container(
                                 margin: const EdgeInsets.only(top: 10),
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
                                 margin: const EdgeInsets.only(top: 10,bottom: 10),
                                 child: new Text(
                                   '- Apelido do atleta',
                                   style: new TextStyle(fontSize: 18),
                                 ),
                               ),
                             ],
                           ),
                         )
                       ],
                     )
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
                        margin: const EdgeInsets.all(16),
                        child:
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              'O usuário poderá desativar seu cadastro se não estiver de acordo com as regras através do próprio aplicativo e se for assinante, poderá cancelar sua assinatura utilizando a estrutura da Hotmart seguindo o passo a passo disponível no site oficial do FuttApp (www.futtapp.com.br).',
                              style: new TextStyle(fontSize: 18),
                              textAlign: TextAlign.start,
                            ),
                            new Container(height: 10,),
                            new Text(
                              'Em caso de dúvidas, envie um email para futtapp@gmail.com e responderemos o mais breve possível.',
                              style: new TextStyle(fontSize: 18),
                              textAlign: TextAlign.start,

                            ),
                            new Container(height: 10,),

                            new Text(
                              'À disposição.',
                              style: new TextStyle(fontSize: 18),
                              textAlign: TextAlign.start,

                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
