import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/RedeService.dart';
import 'package:futt/futt/view/EdicaoRedeView.dart';
import 'package:futt/futt/view/JogosView.dart';
import 'package:futt/futt/view/IntegrantesView.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/ResponsaveisRedeView.dart';
import 'package:futt/futt/view/components/Apresentacao.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/components/Passos.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

class MinhasRedesSubView extends StatefulWidget {
  @override
  _MinhasRedesSubViewState createState() => _MinhasRedesSubViewState();
}

class _MinhasRedesSubViewState extends State<MinhasRedesSubView> {

  String _mensagem = "";

  List<String> choices = <String>[
    "Integrantes",
    "Responsáveis",
    "Desativar rede",
  ];

  List<String> choices2 = <String>[
    "Integrantes",
    "Responsáveis",
    "Ativar rede"
  ];

  Future<List<RedeModel>> _listaMinhasRedes() async {
    RedeService redeService = RedeService();
    return redeService.listaMinhasRedes(ConstantesConfig.SERVICO_FIXO);
  }

  _showModalAtivaDesativa(BuildContext context, String title, String description, int idRede, String acao){
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.showAlertDialogActionNoYes(context, title,
        description, () {
          _realizaAcao(idRede, true, context, acao);
        });
    // return showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (BuildContext) {
    //       return AlertDialog(
    //         title: Text(title),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               Text(description),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             onPressed: () => _realizaAcao(idRede, false, context, acao),
    //             child: Text("Não"),
    //           ),
    //           FlatButton(
    //             onPressed: () => _realizaAcao(idRede, true, context, acao),
    //             child: Text("Sim"),
    //           )
    //         ],
    //       );
    //     }
    // );
  }

  _realizaAcao(int idRede, bool resposta, BuildContext context, acao) async {
    circularProgress(context);
    if (resposta) {
      if (acao == "D") {
        _desativando(idRede, context);
      }else{
        _ativando(idRede, context);
      }
      Navigator.pop(context);

    }else{
      Navigator.pop(context);
    }
  }

  _ativando(int idRede, BuildContext context) async {
    try {
      var _url = "${ConstantesRest.URL_REDE}/${idRede}/ativa";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: _dados,
      );
      Navigator.pop(context);

      if (response.statusCode == 201) {
        _mensagem = "Rede ativada com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        setState(() {});

      }else{
        print(response.body);
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Rede", "(${response.statusCode}) Falha no processamento!!!");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
      }

    } on Exception catch (exception) {
      print(exception.toString());
      setState(() {
        _mensagem = exception.toString();
      });
    } catch (error) {
      setState(() {
        _mensagem = error.toString();
      });
    }
  }

  _desativando(int idRede, BuildContext context) async {
    try {
      var _url = "${ConstantesRest.URL_REDE}/${idRede}/desativa";
      var _dados = "";

      if (ConstantesConfig.SERVICO_FIXO == true) {
        _url = "https://jsonplaceholder.typicode.com/posts/1";
        _dados = jsonEncode({ 'userId': 1, 'id': 1, 'title': 'Título', 'body': 'Corpo da mensagem' });
      }

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.put(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: _dados,
      );
      Navigator.pop(context);

      if (response.statusCode == 201) {
        _mensagem = "Rede desativada com sucesso!!!";

        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingSucess(context, "Rede", "${_mensagem}");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
        setState(() {});

      }else{
        DialogFutt dialogFutt = new DialogFutt();
        dialogFutt.waitingError(context, "Rede", "(${response.statusCode}) Falha no processamento!!!");
        await Future.delayed(Duration(seconds: 3));
        Navigator.pop(context);
      }

    } on Exception catch (exception) {
      print(exception.toString());
      setState(() {
        _mensagem = exception.toString();
      });
      
    } catch (error) {
      setState(() {
        _mensagem = error.toString();
      });
    }
  }

  _getSubTitulo(int status, String data) {
    if (status == 1) {
      return "EM APROVAÇÃO";
    }else if (status == 2) {
      if (data != null && data.length>=10) {
        return data.substring(8) + "-" + data.substring(5, 7) + "-" + data.substring(0, 4);
      }else if (data == null) {
        return "-";
      }else{
        return data??'';
      }
    }else if (status == 3) {
      return "FECHADA";
    }else if (status == 4) {
      return "DESATIVADA";
    }else{
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RedeModel>>(
      future: _listaMinhasRedes(),
      builder: (context, snapshot) {
        switch( snapshot.connectionState ) {
          case ConnectionState.none :
          case ConnectionState.waiting :
          return ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {

              return new FadeAnimation(0.5*index, Column(
                children: <Widget>[
                  Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.5),
                      highlightColor: Colors.white,
                      child: new Container(
                        height: 140,
                        decoration: new BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      //borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Flexible(
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 30,
                                    width: 100,
                                    decoration: new BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        subtitle: Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.5),
                            highlightColor: Colors.white,
                            child: new Container(
                              height: 30,
                              width: 100,
                              decoration: new BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            )),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 30,
                                    width: 30,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 30,
                                    width: 30,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                    color: Colors.white,
                  ),
                ],
              ),horizontal: true,);
            },
          );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
          if( snapshot.hasData && snapshot.data.length > 0 ) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {

                  String validade = '';

                  List<RedeModel> redes = snapshot.data;
                  RedeModel rede = redes[index];

                  if(rede.disponibilidade != null){
                    validade = redeValidadeFormatada(rede.disponibilidade);
                  }

                  return new Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: new Container(
                      decoration: new BoxDecoration(
                          border: Border.all(width: 2,color: Colors.white),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => EdicaoRedeView(redeModel: rede,imageRede: ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto,),
                              ));
                            },
                            child: new Hero(tag: 'imageRede$index', child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.grey[300].withOpacity(0.5),
                                image: DecorationImage(
                                    image: NetworkImage(ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto),
                                    fit: BoxFit.fill
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),),
                          ),
                          new Container(height: 2,width: double.infinity,color: Colors.white,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(4.0),
                                bottomLeft: Radius.circular(4.0),
                              ),
                              gradient: LinearGradient(
                                colors: <Color>[AppColors.colorFundoCardClaro, AppColors.colorFundoCardEscuro],
                              ),
                              //borderRadius: BorderRadius.circular(5),
                            ),
                            child: GestureDetector(
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        "${rede.nome}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorTextTitle : AppColors.colorRedeDesabilitadaTextICon,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle:
                                rede.disponibilidade != null?
                                    rede.status == 2?
                                    new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Validade: $validade",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.colorSubTitle,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Text(
                                          _retorneSubtitulo(rede.pais, rede.cidade, rede.local),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorSubTitle : AppColors.colorRedeDesabilitadaTextICon,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
                                    ):
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(_getSubTitulo(rede.status, rede.disponibilidade),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: rede.status < 3 ? (rede.status == 1) ? Color(0xff093352): AppColors.colorSubTitle : AppColors.colorRedeDesabilitadaTextICon,
                                      ),
                                    ),
                                    rede.status == 4?
                                        new Container():
                                    validade != null?
                                    Text(
                                      "Validade: $validade",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.colorSubTitle,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ):new Container(),
                                    Text(
                                      _retorneSubtitulo(rede.pais, rede.cidade, rede.local),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorSubTitle : AppColors.colorRedeDesabilitadaTextICon,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ):Text(_getSubTitulo(rede.status, rede.disponibilidade),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: rede.status < 3 ? (rede.status == 1) ? Color(0xff093352): AppColors.colorSubTitle : AppColors.colorRedeDesabilitadaTextICon,
                                  ),
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Container(
                                        height: 40,
                                        width: 40,
                                        //padding: const EdgeInsets.all(8),
                                        decoration: new BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: <Color>[
                                                  rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario1 : AppColors.colorRedeDesabilitadaTextICon,
                                                  rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario2 : AppColors.colorRedeDesabilitadaTextICon,
                                                ]),
                                            shape: BoxShape.circle),
                                        child: GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 1),
                                            child: new Center(
                                              child:  new FaIcon(FontAwesomeIcons.spellCheck,color:  AppColors.colorIconCardRede,size: 17,),
                                            )
                                          ),
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => JogosView(redeModel: rede, donoRede: true),
                                            ));
                                          },
                                        ),
                                      ),
                                      new Container(width: 6,),
                                      // new Container(
                                      //   height: 40,
                                      //   width: 40,
                                      //   //padding: const EdgeInsets.all(8),
                                      //   margin: const EdgeInsets.only(left: 6),
                                      //   decoration: new BoxDecoration(
                                      //       gradient: LinearGradient(begin: Alignment.topLeft,
                                      //           end: Alignment.bottomRight,
                                      //           colors: <Color>[
                                      //             rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario1 : AppColors.colorRedeDesabilitadaTextICon,
                                      //             rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario2 : AppColors.colorRedeDesabilitadaTextICon,
                                      //           ]),
                                      //       shape: BoxShape.circle),
                                      //   child:  GestureDetector(
                                      //     child: Icon(Icons.people,
                                      //         color:  AppColors.colorIconCardRede
                                      //     ),
                                      //     onTap: (){
                                      //       Navigator.push(context, MaterialPageRoute(
                                      //           builder: (context) => IntegrantesView(redeModel: rede, donoRede: true)
                                      //       ));
                                      //     },
                                      //   ),
                                      // ),
                                      // new Container(
                                      //   height: 40,
                                      //   width: 40,
                                      //   //padding: const EdgeInsets.all(8),
                                      //   margin: const EdgeInsets.only(left: 6),
                                      //   decoration: new BoxDecoration(
                                      //       gradient: LinearGradient(begin: Alignment.topLeft,
                                      //           end: Alignment.bottomRight,
                                      //           colors: <Color>[
                                      //             rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario1 : AppColors.colorRedeDesabilitadaTextICon,
                                      //             rede.status < 3 ? (rede.status == 1) ?Color(0xff093352): AppColors.colorEspecialPrimario2 : AppColors.colorRedeDesabilitadaTextICon,
                                      //           ]),
                                      //       shape: BoxShape.circle),
                                      //   child: GestureDetector(
                                      //     child:Icon(Icons.smartphone,
                                      //         color:  AppColors.colorIconCardRede
                                      //     ),
                                      //     onTap: (){
                                      //       Navigator.push(context, MaterialPageRoute(
                                      //           builder: (context) => ResponsaveisRedeView(redeModel: rede,)
                                      //       ));
                                      //     },
                                      //   ),
                                      // ),
                                      //
                                      // (rede.status == 1 || rede.status == 2) ?
                                      // new Container(
                                      //   height: 40,
                                      //   width: 40,
                                      //   //padding: const EdgeInsets.all(8),
                                      //   margin: const EdgeInsets.only(left: 6),
                                      //   decoration: new BoxDecoration(
                                      //       gradient: LinearGradient(begin: Alignment.topLeft,
                                      //           end: Alignment.bottomRight,
                                      //           colors: <Color>[
                                      //             AppColors.colorEspecialPrimario1,
                                      //             AppColors.colorEspecialPrimario2
                                      //           ]),
                                      //       shape: BoxShape.circle),
                                      //   child: GestureDetector(
                                      //     child: Icon(Icons.delete_forever,
                                      //       color: rede.status == 1 ? Color(0xff093352) :  AppColors.colorIconCardRede,),
                                      //     onTap: (){
                                      //       _showModalAtivaDesativa(context, "Desativa rede", "Deseja realmente desativar a rede?", rede.id, "D");
                                      //     },
                                      //   )
                                      // )
                                      //  : new Padding(
                                      //   padding: EdgeInsets.all(1),
                                      // ),
                                      // (rede.status == 3 || rede.status == 4) ? GestureDetector(
                                      //   child: Padding(
                                      //     padding: EdgeInsets.only(left: 10),
                                      //     child: Icon(Icons.done,),
                                      //   ),
                                      //   onTap: (){
                                      //     _showModalAtivaDesativa(context, "Ativa rede", "Deseja reativar a rede?", rede.id, "A");
                                      //   },
                                      // ) : new Padding(
                                      //   padding: EdgeInsets.all(1),
                                      // ),
                                      (rede.status == 1 || rede.status == 2)?
                                      new Container(
                                        height: 40,
                                        width: 40,
                                        //padding: const EdgeInsets.all(8),
                                        decoration: new BoxDecoration(
                                            gradient: LinearGradient(begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: <Color>[
                                                  AppColors.colorEspecialPrimario1,
                                                  AppColors.colorEspecialPrimario2
                                                ]),
                                            shape: BoxShape.circle),
                                        child: PopupMenuButton(
                                          color: Color(0xff083251),
                                          onSelected: (value) {
                                            selectedChoice(value,rede);
                                          },
                                          // shape: RoundedRectangleBorder(
                                          //     borderRadius: new BorderRadius.circular(20.0)),
                                          padding: EdgeInsets.zero,
                                          // initialValue: choices[_selection],
                                          itemBuilder: (BuildContext context) {
                                            return choices.map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: new Row(children: [
                                                  Text(choice,style: new TextStyle(color: Colors.white),),
                                                ],)
                                              );
                                            }).toList();
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.bars,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        )
                                      ):new Padding(
                                          padding: EdgeInsets.all(1),
                                        ),(rede.status == 3 || rede.status == 4) ?
                                      new Container(
                                          height: 40,
                                          width: 40,
                                          //padding: const EdgeInsets.all(8),
                                          decoration: new BoxDecoration(
                                              gradient: LinearGradient(begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: <Color>[
                                                    AppColors.colorRedeDesabilitadaTextICon,
                                                    AppColors.colorRedeDesabilitadaTextICon
                                                  ]),
                                              shape: BoxShape.circle),
                                          child: PopupMenuButton(
                                            color: Color(0xff083251),
                                            onSelected: (value) {
                                              selectedChoice2(value,rede);
                                            },
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius: new BorderRadius.circular(20.0)),
                                            padding: EdgeInsets.zero,
                                            // initialValue: choices[_selection],
                                            itemBuilder: (BuildContext context) {
                                              return choices2.map((String choice) {
                                                return PopupMenuItem<String>(
                                                  value: choice,
                                                  child:
                                                  Text(choice,style: new TextStyle(color: Colors.white),),
                                                );
                                              }).toList();
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.bars,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                          )
                                      ):
                              new Padding(
                                  padding: EdgeInsets.all(1),
                                )

                                    ]
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => EdicaoRedeView(redeModel: rede,imageRede: ConstantesRest.URL_BASE_AMAZON + rede.nomeFoto,),
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  );
                },
              );
            }else{
              return Apresentacao().getApresentacao(2,context);
            }
            break;
        }
        return new Container();
      },
    );
  }

  String redeValidadeFormatada(String value){
    String dataFormatada = '${value.split('-')[2]}/${value.split('-')[1]}/${value.split('-')[0]}';
    return dataFormatada;

  }


  _retorneSubtitulo(String pais, String cidade,String local) {
    if(pais ==""){
      pais = null;
    }
    if(cidade ==""){
      cidade = null;
    }
    if(local ==""){
      local = null;
    }
    if (pais == null && cidade == null && local == null) {
      return "";
    }
    //
    // else if (pais != null && cidade != null) {
    //   return pais + " - " + cidade;
    // } else if (pais != null && cidade == null) {
    //   return pais;
    // } else if (pais == null && cidade != null) {
    //   return cidade;
    // }
    else if(pais != null && cidade == null && local == null){
      String value = pais;
      return value;
    }
    else if(pais != null && cidade != null && local == null){
      String value = "${pais == 'Brasil'?'':'$pais - '}${pais == 'Brasil'?'$cidade':''}";
      return value;
    }
    else if(pais != null && cidade != null && local != null){
      String value = "${pais == 'Brasil'?'':'$pais - '}${pais == 'Brasil'?'$cidade -':''} $local";
      return value;
    }
    else if(pais == null && cidade == null && local != null){
      String value = local;
      return value;
    }
    else if(pais == null && cidade != null && local != null){
      String value = "$cidade - $local";
      return value;
    }
    else if(pais != null && cidade == null && local != null){
      String value = "${pais == 'Brasil'?'':'$pais - '} $local";
      return value;
    }
  }

  void selectedChoice(String value,RedeModel rede) {
    switch (value) {
      case "Integrantes":
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => IntegrantesView(redeModel: rede, donoRede: true)));
        break;
      case "Responsáveis":
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ResponsaveisRedeView(redeModel: rede,)
        ));
        break;
      case "Desativar rede":
        _showModalAtivaDesativa(context, "Desativar rede", "Deseja realmente desativar a rede?", rede.id, "D");
        break;
      default:
        break;
    }
  }

  void selectedChoice2(String value,RedeModel rede) {
    switch (value) {
      case "Integrantes":
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => IntegrantesView(redeModel: rede, donoRede: true)));
        break;
      case "Responsáveis":
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ResponsaveisRedeView(redeModel: rede,)
        ));
        break;
      case "Ativar rede":
        _showModalAtivaDesativa(context, "Ativar rede", "Deseja reativar a rede?", rede.id, "A");
        break;
      default:
        break;
    }
  }

  void circularProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext bc) {
          return Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )
              ],
            ),
          );
        });
  }
}
