import 'dart:convert';
import 'package:futt/futt/model/AreaEstatisticaModel.dart';

class AreaEstatisticaServiceFixo {

  String retornoArea = '{'
      '"id": 1, '
      '"nome": "Estatísticas Técnicas", '
      '"listaTipoAvaliacaoDTO": []'
      '}';

  String retornoAreas = '['
        '{'
          '"id": 1, '
          '"nome": "Estatísticas Técnicas", '
          '"listaTipoEstatisticaDTO": []'
        '},'
        '{'
          '"id": 2, '
          '"nome": "Estatísticas Táticas", '
          '"listaTipoEstatisticaDTO": []'
        '}'
      ']';

  String responseLista() {
    return retornoAreas;
  }

  String responseObjeto() {
    return retornoArea;
  }

  Future<AreaEstatisticaModel> _buscaAreaEstatisticaFixo() async {
    var dadosJson = json.decode(retornoArea);
    return AreaEstatisticaModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<AreaEstatisticaModel>> _listaAreasEstatisticasFixo() async {
    var dadosJson = json.decode(retornoAreas);
    List<AreaEstatisticaModel> lista = List();
    for (var registro in dadosJson) {
      AreaEstatisticaModel areaEstatisticaModel = AreaEstatisticaModel.fromJson(registro); //.converteJson
      lista.add(areaEstatisticaModel);
    }
    return lista;
  }

  Future<List<AreaEstatisticaModel>> listaAtivas() async {
    return _listaAreasEstatisticasFixo();
  }

}