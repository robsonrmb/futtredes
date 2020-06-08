import 'package:futt/futt/model/JogoModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/JogoServiceFixo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JogoRest extends BaseRest {

  Future<List<JogoModel>> processaHttpGetList(String url, int idFase, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaJogoModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        JogoServiceFixo serviceFixo = JogoServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista(idFase));
        return _parseListaJogoModel(dadosJson);

      } else {
        throw Exception('Falha ao listar participantes!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  Future<List<JogoModel>> processaHttpGetListPlacarAtualizado(String url, int idFase, bool atualizouPlacar, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaJogoModel(dadosJson);

      } else {
        throw Exception('Failed to load Tipo Torneio!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        JogoServiceFixo serviceFixo = JogoServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseListaPlacarAtualizado(idFase));
        return _parseListaJogoModel(dadosJson);

      } else {
        throw Exception('Falha ao listar participantes!!!');
      }

    } catch (error) {
      print(error.toString());
    }

  }

  List<JogoModel> _parseListaJogoModel(dadosJson) {
    List<JogoModel> lista = List();
    for (var registro in dadosJson) {
      JogoModel resultadoModel = JogoModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }
}