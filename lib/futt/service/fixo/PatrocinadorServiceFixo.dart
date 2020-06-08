import 'dart:convert';
import 'package:futt/futt/model/PatrocinadorModel.dart';

class PatrocinadorServiceFixo {

  String retornoPatrocinador = '{'
      '"id": 1, '
      '"nome": "Show do Milhão", '
      '"website": showdomilhao.com '
      '} ';

  String retornoPatrocinadores = '[ '
        '{'
          '"id": 1, '
          '"nome": "Show do Milhão", '
          '"website": showdomilhao.com '
        '} '
      ']';

  String responseLista() {
    return retornoPatrocinadores;
  }

  String responseObjeto() {
    return retornoPatrocinadores;
  }

  Future<PatrocinadorModel> _buscaPatrocinadorFixo() async {
    var dadosJson = json.decode(retornoPatrocinador);
    return PatrocinadorModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<PatrocinadorModel>> _listaPatrocinadoresFixo() async {
    var dadosJson = json.decode(retornoPatrocinadores);
    List<PatrocinadorModel> lista = List();
    for (var registro in dadosJson) {
      PatrocinadorModel patrocinadorModel = PatrocinadorModel.fromJson(registro); //.converteJson
      lista.add(patrocinadorModel);
    }
    return lista;
  }

  Future<List<PatrocinadorModel>> listaPatrocinadores() async {
    _listaPatrocinadoresFixo();
  }

  Future<List<PatrocinadorModel>> listaPorTorneios(String idTorneio) async {
    _listaPatrocinadoresFixo();
  }

}