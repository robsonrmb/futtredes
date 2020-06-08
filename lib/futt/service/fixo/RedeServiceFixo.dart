import 'dart:convert';
import 'package:futt/futt/model/IntegranteModel.dart';
import 'package:futt/futt/model/RedeModel.dart';

class RedeServiceFixo {

  String retornoRede = '{'
        '"id": 1, '
        '"nome": "Show do Milhão", '
        '"status": 1, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Rio de Janeiro", '
        '"local": "Ipanema", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-06-01", '
        '"qtdIntegrantes": 50, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '} ';

  String retornoRedes = '[ '
      '{'
        '"id": 1, '
        '"nome": "Show do Milhão", '
        '"status": 1, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Rio de Janeiro", '
        '"local": "Ipanema", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-06-01", '
        '"qtdIntegrantes": 50, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '} '
    ']';

  String retornoIntegrante = '{ '
        '"idUsuario": 1, '
        '"nome": "Robson", '
        '"nomeFoto": null, '
        '"pais": "Brasil", '
        '"estado": "DF", '
        '"idRede": 0 '
      '} ';

  String retornoIntegrantes = '[ '
        '{ '
          '"idUsuario": 1, '
          '"nome": "Robson", '
          '"nomeFoto": null, '
          '"pais": "Brasil", '
          '"estado": "DF", '
          '"idRede": 1 '
        '}, '
        '{ '
          '"idUsuario": 2, '
          '"nome": "Pedro", '
          '"nomeFoto": null, '
          '"pais": "Brasil", '
          '"estado": "DF", '
          '"idRede": 1 '
        '} '
      ']';

  String responseRedeLista() {
    return retornoRedes;
  }

  String responseRedeObjeto() {
    return retornoRedes;
  }

  String responseIntegrantesLista() {
    return retornoIntegrantes;
  }

  Future<RedeModel> _buscaRedeFixo() async {
    var dadosJson = json.decode(retornoRede);
    return RedeModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<RedeModel>> _listaRedesFixo() async {
    var dadosJson = json.decode(retornoRedes);
    List<RedeModel> lista = List();
    for (var registro in dadosJson) {
      RedeModel redeModel = RedeModel.fromJson(registro); //.converteJson
      lista.add(redeModel);
    }
    return lista;
  }

  Future<List<IntegranteModel>> _listaIntegrantesFixo() async {
    var dadosJson = json.decode(retornoRedes);
    List<IntegranteModel> lista = List();
    for (var registro in dadosJson) {
      IntegranteModel integranteModel = IntegranteModel.fromJson(registro); //.converteJson
      lista.add(integranteModel);
    }
    return lista;
  }

  Future<List<RedeModel>> listaPorFiltros(var redeModel) async {
    _listaRedesFixo();
  }

  Future<List<RedeModel>> listaPorStatus(var status) async {
    _listaRedesFixo();
  }

  Future<List<RedeModel>> listaTodos() async {
    _listaRedesFixo();
  }

  Future<List<IntegranteModel>> listaIntegrantesDaRede(String idRede) async {
    _listaIntegrantesFixo();
  }

}