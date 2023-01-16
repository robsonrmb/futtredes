import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ExceptionModel.dart';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';
import 'package:futt/futt/service/IntegranteService.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/EstatisticasAtletasView.dart';
import 'package:futt/futt/view/components/DialogFutt.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

class IntegrantesSubView extends StatefulWidget {
  RedeModel redeModel;
  bool donoRede;
  int inclui;

  IntegrantesSubView(this.redeModel, this.donoRede, this.inclui);

  @override
  _IntegrantesSubViewState createState() => _IntegrantesSubViewState();
}

class _IntegrantesSubViewState extends State<IntegrantesSubView> {
  String _mensagem = "";

  Future<List<IntegranteModel>> _listaIntegrantes(int lista) async {
    IntegranteService resultadoService = IntegranteService();
    return resultadoService.listaIntegrantesDaRede( widget.redeModel.id);
  }

  _showModalRemoveIntegrante(
      BuildContext context, int idIntegrante, int idRede) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Remove integrante da rede"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Deseja realmente remover o integrante?"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _remove(context, idRede, idIntegrante, false),
                child: Text("Não"),
              ),
              FlatButton(
                onPressed: () => _remove(context, idRede, idIntegrante, true),
                child: Text("Sim"),
              )
            ],
          );
        });
  }

  _remove(
      BuildContext context, int idRede, int idIntegrante, bool resposta) async {
    if (resposta) {
      _removendo(context, idRede, idIntegrante);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  _removendo(BuildContext context, int idRede, int idAtleta) async {
    try {
      IntegranteModel integranteModel =
          IntegranteModel.Remove(idRede, idAtleta);

      var _url = "${ConstantesRest.URL_REDE}/removeintegrante";
      var _dados = integranteModel.toJson();

      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.post(_url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode(_dados));

      if (response.statusCode == 201) {
        setState(() {
          _mensagem = "Atleta inserido com sucesso!!!";
        });
      } else {
        setState(() {
          var _dadosJson = jsonDecode(response.body);
          ExceptionModel exceptionModel = ExceptionModel.fromJson(_dadosJson);
          _mensagem = exceptionModel.msg;
        });
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IntegranteModel>>(
      future: _listaIntegrantes(widget.inclui),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new FadeAnimation(
              1,
              Container(
                margin: const EdgeInsets.all(20),
                child: new Card(
                  elevation: 5,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(8, 4, 8, 0),
                            child: ListTile(
                              leading: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  child: new Container(
                                    height: 56,
                                    width: 56,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  )),
                              title: Row(
                                children: <Widget>[
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        height: 20,
                                        width: 90,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                ],
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      highlightColor: Colors.white,
                                      child: new Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        height: 20,
                                        width: 90,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.withOpacity(0.5),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              horizontal: true,
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return new Container(
                margin: const EdgeInsets.all(20),
                child: new Card(
                  elevation: 5,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      List<IntegranteModel> integrantes = snapshot.data;
                      IntegranteModel integrante = integrantes[index];
                      return new InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EstatisticasAtletasView(
                                  integrante.idUsuario,
                                  widget.redeModel.id,
                                  widget.redeModel.nome,
                                  integrante.nome,
                                  integrante.nomeFoto,
                                  hero: 'index$index',
                                  pais: integrante.pais,
                                  apelido: integrante.apelido,
                                  user: integrante.user,
                                  localOndeJoga: integrante.local,

                                ),
                              ));
                        },
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(8, 4, 0, 0),
                              child: ListTile(
                                leading: new Hero(
                                    tag: 'index$index',
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '${ConstantesRest.URL_STATIC_USER}${integrante.nomeFoto}'),
                                      radius: 30.0,
                                    )),
                                title: Row(
                                  children: <Widget>[
                                    new Container(
                                      width:widget.donoRede? MediaQuery.of(context).size.width*0.32:MediaQuery.of(context).size.width*0.43,
                                      child: Text(
                                        apelidoOuNome(integrante.apelido,integrante.nome),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.colorTextTitleIntegrantes,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    new Container(
                                      width:widget.donoRede? MediaQuery.of(context).size.width*0.32:MediaQuery.of(context).size.width*0.43,
                                      child: Text(
                                        _retorneSubtitulo(
                                            integrante.pais, integrante.cidade,integrante.local),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.colorTextSubTitleIntegrantes,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "${integrante.pais == 'Brasil'?'':'${integrante.pais} - '}${integrante.pais == 'Brasil'?'${integrante.cidade} -':''} ${integrante.local}",
                                    //   style: TextStyle(
                                    //       fontSize: 14,
                                    //       color: AppColors.colorSubTitle,
                                    //       fontWeight: FontWeight.w600
                                    //   ),
                                    // ),
                                  ],
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      widget.donoRede
                                          ? new Row(
                                        children: [
                                          new GestureDetector(
                                            child: Icon(Icons.delete,color: AppColors.colorTextIconIntegrantes,),
                                            onTap: () {
                                              showDialogExclusao(
                                                  context,
                                                  integrante.idUsuario,
                                                  widget.redeModel.id);
                                              // _showModalRemoveIntegrante(
                                              //     context,
                                              //     integrante.idUsuario,
                                              //     widget.redeModel.id);
                                            },
                                          ),
                                          new Container(width: 10,),
                                          new GestureDetector(
                                            child: FaIcon(FontAwesomeIcons.chartLine),
                                            // Icon(Icons.assessment_sharp,color: AppColors.colorTextIconIntegrantes,),
                                            //child: Icon(Icons.assessment_sharp,color: AppColors.colorTextIconIntegrantes,),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => EstatisticasAtletasView(
                                                      integrante.idUsuario,
                                                      widget.redeModel.id,
                                                      widget.redeModel.nome,
                                                      integrante.nome,
                                                      integrante.nomeFoto,
                                                      hero: 'index$index',
                                                      pais: integrante.pais,
                                                      apelido: integrante.apelido,
                                                      user: integrante.user,
                                                      localOndeJoga: integrante.local,

                                                    ),
                                                  ));
                                            },
                                          ),
                                        ],
                                      )
                                          : new GestureDetector(
                                        child: FaIcon(FontAwesomeIcons.chartLine),
                                       // Icon(Icons.assessment_sharp,color: AppColors.colorTextIconIntegrantes,),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EstatisticasAtletasView(
                                                  integrante.idUsuario,
                                                  widget.redeModel.id,
                                                  widget.redeModel.nome,
                                                  integrante.nome,
                                                  integrante.nomeFoto,
                                                  hero: 'index$index',
                                                  pais: integrante.pais,
                                                  apelido: integrante.apelido,
                                                  user: integrante.user,
                                                  localOndeJoga: integrante.local,

                                                ),
                                              ));
                                        },
                                      ),
                                    ]),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.5),
                            )
                          ],
                        ),
                      );
                    },
                    /*
                separatorBuilder: (context, index) => Divider(
                  height: 3,
                  color: Colors.amber,
                ),*/
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Sem valores!!!"),
              );
            }
            break;
        }
        return new Container();
      },
    );
  }

  void showDialogExclusao(
      BuildContext context, int idIntegrante, int idRede) {
    DialogFutt dialogFutt = new DialogFutt();
    dialogFutt.showAlertDialogActionNoYes(context, "Remove integrante da rede",
        'Deseja realmente remover o integrante?', () {
         // _zeraJogo(idJogo);
          _remove(context, idRede, idIntegrante, true);
        });
  }


  //APELIDO OU PRIMEIRO NOME
  String apelidoOuNome(String apelido, String nome) {
    if (apelido != null && apelido != "") {
      return apelido;
    } if(nome != null){
      if (nome.split(' ').length == 1) {
        return nome;
      } else if (nome.split(' ').length > 1) {
        String nomeFormatado = '${nome.split(' ')[0]}';
        return nomeFormatado;
      }
    }else{
      return '';
    }
  }

}
