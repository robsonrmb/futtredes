import 'dart:convert';
import 'package:futt/futt/model/AreaAvaliacaoModel.dart';

class AreaAvaliacaoServiceFixo {

  String retornoArea = '{'
        '"id": 1, '
        '"nome": "Avaliações Técnicas", '
        '"listaTipoAvaliacaoDTO": []'
      '}';

  String retornoAreas = '['
        '{'
          '"id": 1, '
          '"nome": "Avaliações Técnicas", '
          '"listaTipoAvaliacaoDTO": []'
        '},'
        '{'
          '"id": 2, '
          '"nome": "Avaliações Táticas", '
          '"listaTipoAvaliacaoDTO": []'
        '}'
      ']';

  String responseLista() {
    return retornoAreas;
  }

  String responseObjeto() {
    return retornoArea;
  }

  Future<AreaAvaliacaoModel> _buscaAreaAvaliacaoFixo() async {
    var dadosJson = json.decode(retornoArea);
    return AreaAvaliacaoModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<AreaAvaliacaoModel>> _listaAreasDeAvaliacaoFixo() async {
    var dadosJson = json.decode(retornoAreas);
    List<AreaAvaliacaoModel> lista = List();
    for (var registro in dadosJson) {
      AreaAvaliacaoModel areaAvaliacaoModel = AreaAvaliacaoModel.fromJson(registro); //.converteJson
      lista.add(areaAvaliacaoModel);
    }
    return lista;
  }

  Future<List<AreaAvaliacaoModel>> listaAtivas() async {
    return _listaAreasDeAvaliacaoFixo();
  }

}