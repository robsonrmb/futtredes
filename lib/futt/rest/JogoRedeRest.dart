import 'package:futt/futt/model/JogoRedeModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/JogoRedeServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogoRedeRest extends BaseRest {

  Future<List<JogoRedeModel>> processaHttpGetList(String url, int dia, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        JogoRedeServiceFixo serviceFixo = JogoRedeServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista(dia));
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Falha ao listar participantes!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<JogoRedeModel>> processaHttpGetListPlacarAtualizado(String url, int dia, bool atualizouPlacar, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        JogoRedeServiceFixo serviceFixo = JogoRedeServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseListaPlacarAtualizado(dia));
        return _parseListaJogoRedeModel(dadosJson);

      } else {
        throw Exception('Falha ao listar participantes!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<JogoRedeModel> _parseListaJogoRedeModel(dadosJson) {
    List<JogoRedeModel> lista = List();
    for (var registro in dadosJson) {
      JogoRedeModel resultadoModel = JogoRedeModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}