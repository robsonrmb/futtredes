import 'package:futt/futt/model/RankingEntidadeModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/RankingEntidadeServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankingEntidadeRest extends BaseRest {

  Future<List<RankingEntidadeModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaRankingEntidadeModel(dadosJson);

      } else {
        throw Exception('Failed to load ranking entidade!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        RankingEntidadeServiceFixo serviceFixo = RankingEntidadeServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaRankingEntidadeModel(dadosJson);

      } else {
        throw Exception('Falha ao listar resultados!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<RankingEntidadeModel> _parseListaRankingEntidadeModel(dadosJson) {
    List<RankingEntidadeModel> lista = List();
    for (var registro in dadosJson) {
      RankingEntidadeModel resultadoModel = RankingEntidadeModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}