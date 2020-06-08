import 'dart:convert';

import 'package:futt/futt/model/TipoAvaliacaoModel.dart';

class TipoAvaliacaoServiceFixo {

  String retornoTipo = '{'
        '"id": 1, '
        '"nome": "LEVANTADA", '
        '"descricao": "LEVANTADA", '
        '"listaTipoRespostasAvaliacaoDTO": []'
      '}';

  String retornoTipos = '['
        '{'
          '"id": 1, '
          '"nome": "LEVANTADA", '
          '"descricao": "LEVANTADA", '
          '"listaTipoRespostasAvaliacaoDTO": []'
        '},'
          '{"id": 2, '
          '"nome": "RECEPCAO", '
          '"descricao": "RECEPÇÃO", '
          '"listaTipoRespostasAvaliacaoDTO": [] '
        '} '
      ']';

  String responseLista() {
    return retornoTipos;
  }

  String responseObjeto() {
    return retornoTipo;
  }

  Future<TipoAvaliacaoModel> _buscaTipoAvaliacaoFixo() async {
    var dadosJson = json.decode(retornoTipo);
    return TipoAvaliacaoModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<TipoAvaliacaoModel>> _listaTiposDeAvaliacaoFixo() async {
    var dadosJson = json.decode(retornoTipos);
    List<TipoAvaliacaoModel> lista = List();
    for (var registro in dadosJson) {
      TipoAvaliacaoModel tipoAvaliacaoModel = TipoAvaliacaoModel.fromJson(registro); //.converteJson
      lista.add(tipoAvaliacaoModel);
    }
    return lista;
  }

  Future<TipoAvaliacaoModel> getAvaliacao(String id) async {
    return _buscaTipoAvaliacaoFixo();
  }

  Future<List<TipoAvaliacaoModel>> listaPorNome(String nome) async {
    return _listaTiposDeAvaliacaoFixo();
  }

  Future<List<TipoAvaliacaoModel>> listaPorParteDoNome(String nome) async {
    return _listaTiposDeAvaliacaoFixo();
  }

  Future<List<TipoAvaliacaoModel>> listaFind(String nome) async {
    return _listaTiposDeAvaliacaoFixo();
  }

  Future<List<TipoAvaliacaoModel>> listaTodos() async {
    return _listaTiposDeAvaliacaoFixo();
  }

}