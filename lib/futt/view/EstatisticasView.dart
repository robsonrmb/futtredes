import 'dart:convert';

import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EstadosByUfModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/service/UsuarioService.dart';
import 'package:futt/futt/view/components/EstatisticasJogosPontos.dart';
import 'package:futt/futt/view/components/EstatisticasQuantitativas.dart';
import 'package:futt/futt/view/components/EstatisticasSequenciais.dart';
import 'package:flutter/material.dart';
import 'package:futt/futt/view/components/animation.dart';
import 'package:futt/futt/view/style/colors.dart';
import 'package:futt/futt/view/style/font-family.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:http/http.dart' as http;

class EstatisticasView extends StatefulWidget {
  int idUsuario;
  String apelido;
  int idRede;
  String nomeRede;
  String nome;
  String nomeFoto;
  String hero;
  int colocacao;
  String pais;
  String user;
  String estado;
  String localOndeJoga;
  String posicao;

  EstatisticasView(
      this.idUsuario, this.idRede, this.nomeRede, this.nome, this.nomeFoto,
      {this.hero, this.colocacao,this.pais,this.apelido,this.user,this.estado,this.localOndeJoga,this.posicao});

  @override
  _EstatisticasViewState createState() => _EstatisticasViewState();
}

class _EstatisticasViewState extends State<EstatisticasView> {

  UsuarioModel usuarioModel;
  SharedPreferences pref;

  String user = '';
  List<EstadosByUFModel> listEstados = [];
  String siglaEstado;
  String localOndeJoga;
  String posicao;
  String pais;
  bool restart;

  @override
  void initState() {
    super.initState();

  }

  void preecherUf()async{
    listEstados =  await retornaUser();
    if(listEstados != null){
    if(listEstados.length >0){
      if(widget.estado == null){
        if(usuarioModel != null){
          for(int i = 0; i < listEstados.length; i ++){
            if(usuarioModel.estado == listEstados[i].nome){
              siglaEstado = listEstados[i].sigla;
            }
          }
        }
      }else{
        for(int i = 0; i < listEstados.length; i ++){
          if(widget.estado == listEstados[i].nome){
            siglaEstado = listEstados[i].sigla;
          }
        }
      }
      setState(() {});
    }
    }else{
      setState(() {});
    }
  }

  Future<void> inicializarShared() async {
    pref = await SharedPreferences.getInstance();
  }

  void buscarUser()async{
    await inicializarShared();
    restart = pref.getBool('restart');
    usuarioModel = await _buscaUsuarioSelecionado();
    if(usuarioModel != null){
      user = usuarioModel.user;
      localOndeJoga = usuarioModel.ondeJoga;
      posicao = posicaos(usuarioModel.posicao);
      pais = usuarioModel.pais;
      widget.estado = usuarioModel.estado;

      if(posicao == "2"){
        posicao = "Esquerda";
      }
      if(posicao == "1"){
        posicao = "Direita";
      }
      if(posicao == "0"){
        posicao = "Ambas";
      }

      if(!restart){
        pref.setBool('restart', true);
        preecherUf();
      }

      //setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    buscarUser();
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      color: Colors.grey[300],
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //     padding: EdgeInsets.all(5),
              //     child: new Container(
              //       margin: const EdgeInsets.only(left: 8),
              //       child: Text(
              //         "Atleta",
              //         style: TextStyle(
              //           color: AppColors.colorTextTitlesDash,
              //           fontSize: 16,
              //           fontFamily: FontFamily.fontSpecial,
              //         ),
              //       ),
              //     )),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, top: 20,bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          // color: Colors.black12,
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5)
                    ]),
                child: Column(
                  children: <Widget>[
                    new Container(
                      height: 5,
                      decoration: new BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          topLeft: Radius.circular(4),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[
                            AppColors.colorEspecialPrimario1,
                            AppColors.colorEspecialPrimario2
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Text(
                        widget.nomeRede == null
                            ? "ESTATÍSTICAS DE TODAS AS REDES"
                            : "REDE: ${widget.nomeRede.toUpperCase()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff093352)),
                      ),
                    ),
                  ],
                ),
              ),
              new FadeAnimation(
                1,
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: new Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              new Container(
                                margin: const EdgeInsets.all(20),
                                child: new Hero(
                                  tag: widget.hero ?? '',
                                  child: new Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      new Container(
                                        margin: const EdgeInsets.all(4),
                                        height: 80,
                                        width: 80,
                                        decoration: new BoxDecoration(
                                          //color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${ConstantesRest.URL_BASE_AMAZON}${widget.nomeFoto}'),
                                          radius: 30.0,
                                        ),
                                      ),

                                      _buildStar(widget.colocacao)
                                    ],
                                  ),
                                ),
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    margin:
                                        const EdgeInsets.only(top: 20, left: 6),
                                    child: Text(
                                      apelidoOuNome(widget.apelido,widget.nome),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.colorTextTitlesDash,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Candal'),
                                    ),
                                  ),
                                  widget.user != null?
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 6),
                                      child: Text(
                                        'Usuário: ${widget.user}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      )):Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 6),
                                      child: Text(
                                        'Usuário: ${user??""}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      )),
                                  // usuarioModel != null?
                                  // usuarioModel.estado != null?
                                  // Container(
                                  //     margin: const EdgeInsets.only(
                                  //         top: 8, left: 6),
                                  //     child: Text(
                                  //       siglaEstado??"",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     )):new Container():new Container(),
                                  // widget.estado != null?
                                  // Container(
                                  //     margin: const EdgeInsets.only(
                                  //         top: 8, left: 6),
                                  //     child: Text(
                                  //       siglaEstado??"",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     )):new Container(),

                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 6),
                                      child: Text(
                                        estadoOuPais(localOndeJoga, pais),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      )),
                                  // widget.localOndeJoga != null?
                                  // Container(
                                  //     margin: const EdgeInsets.only(
                                  //         top: 8, left: 6),
                                  //     child: Text(
                                  //       "${widget.localOndeJoga??""} - ${widget.pais??""} ",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     )):
                                  // Container(
                                  //     margin: const EdgeInsets.only(
                                  //         top: 8, left: 6),
                                  //     child: Text(
                                  //       "${localOndeJoga??""} - ${widget.pais??""} ",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     )),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 6),
                                      child: Text(
                                        "${posicao??""}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      )),
                                  // Container(
                                  //     margin: const EdgeInsets.only(top: 8,left: 6),
                                  //     child: Text(
                                  //       '31 anos  |  Destro',
                                  //       style: TextStyle(
                                  //         fontSize: 16,color: Colors.grey,
                                  //       ),
                                  //     )),
                                ],
                              )
                            ],
                          ),
                          widget.colocacao != null && widget.colocacao < 4
                              ? Container(
                                  //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        AppColors.colorEspecialPrimario1,
                                        AppColors.colorEspecialPrimario2
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(4.0),
                                      bottomRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Center(
                                      child: new Container(
                                    padding: const EdgeInsets.only(
                                        top: 6, bottom: 6),
                                    child: Text(
                                      '${widget.colocacao}° Lugar ${widget.nomeRede.toUpperCase()}',
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                )
                              : new Container(),
                        ],
                      )),
                ),
                horizontal: false,
              ),
              EstatisticasSequenciais(widget.idUsuario, widget.idRede),
              Padding(
                padding: EdgeInsets.all(3),
              ),
              EstatisticasQuantitativas(widget.idUsuario, widget.idRede),
              Padding(
                padding: EdgeInsets.all(3),
              ),
              EstatisticasJogosPontos(widget.idUsuario, widget.idRede),
              new Container(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStar(int ind) {
    switch (ind) {
      case 1:
        return new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/star1.png"),
                      fit: BoxFit.cover)),
            ),
          ],
        );
        break;
      case 2:
        return new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/star2.png"),
                      fit: BoxFit.cover)),
            ),
          ],
        );
        break;
      case 3:
        return new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/star3.png"),
                      fit: BoxFit.cover)),
            ),
          ],
        );
        break;
      default:
        return new Container();
    }
  }
  String apelidoOuNome(String apelido, String nome) {
    if (apelido != null && apelido != "") {
      return apelido;
    } else if (nome.split(' ').length == 1) {
      return nome;
    } else  if (nome.split(' ').length > 1){
      String nomeFormatado = '${nome.split(' ')[0]}';
      return nomeFormatado;
    }
  }

  String estadoOuPais(String localOndeJoga, String pais) {
    if(pais == 'Brasil'){
      if(widget.estado!= null){
        if(localOndeJoga != null && pais != null){
          if(localOndeJoga != ""){
            return '$localOndeJoga - ${siglaEstado??""}';
          }else{
            return '${siglaEstado??""}';
          }
        }else{
          return '';
        }
      }else{
        if(localOndeJoga != null && pais != null){
          if(usuarioModel != null){
            if(usuarioModel.estado!= null){
              if(localOndeJoga != ""){
                return '$localOndeJoga - ${siglaEstado??""}';
              }else{
                return '${siglaEstado??""}';
              }
            }else{
              return '';
            }
          }else{
            return "";
          }
        }else{
          return '';
        }

      }
    }else{
      if(localOndeJoga != null && pais != null){
        if(localOndeJoga != ""){
          return '$localOndeJoga - $pais';
        }else{
          return '$pais';
        }
      }else{
        return '';
      }
    }
  }

  String posicaos(String pos) {
    switch (pos){
      case '2':
        return 'Esquerda';
        break;
      case '1':
        return 'Direita';
        break;
      case '0':
        return 'Ambas';
        break;
      default:
        return '';
        break;
    }
  }

  Future<UsuarioModel> _buscaUsuarioSelecionado() async {
    UsuarioService usuarioService = UsuarioService();
    UsuarioModel usuario =
    await usuarioService.buscaPorId(widget.idUsuario.toString(), false);
    return usuario;
  }

  Future<List<EstadosByUFModel>> retornaUser() async {
    var response = await http.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados',);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((e) => EstadosByUFModel.fromJson(e)).toList();

    } else {
      return [];
    }
  }

}
