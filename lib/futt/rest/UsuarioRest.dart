import 'package:futt/futt/constantes/ConstantesConfig.dart';
import 'package:futt/futt/model/EstadoModel.dart';
import 'package:futt/futt/model/PaisesModel.dart';
import 'package:futt/futt/model/UsuarioAssinanteModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/rest/BaseRest.dart';
import 'package:futt/futt/service/fixo/UsuarioServiceFixo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioRest extends BaseRest {

  Future<List<UsuarioModel>> processaHttpGetList(String url, bool fixo) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        return _parseListaUsuarioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar usuários!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaUsuarioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }

    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<PaisesModel>> processaHttpGetListPaises(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaPaisesModel(dadosJson);

      } else {
        throw Exception('Falha ao listar paises');
      }
    } on Exception catch (e) {

    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<EstadosModel>> processaHttpGetListEstados(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaEstadosModel(dadosJson);

      } else {
        throw Exception('Falha ao listar estados');
      }
    } on Exception catch (e) {

    } catch (error) {
      print(error.toString());
    }
  }

  Future<UsuarioModel> processaHttpGetObject(String url, bool fixo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.get(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
      );
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        UsuarioModel usuarioModel = UsuarioModel.fromJson(dadosJson);
        return usuarioModel;

      } else {
        throw Exception('Falha ao listar usuário!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return UsuarioModel.fromJson(dadosJson);

      } else {
        throw Exception('Falha ao listar usuários!!!');
      }

    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<UsuarioModel>> processaHttpPostReturn(String url, var usuarioModel, bool fixo) async {
    http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          jsonDecode(usuarioModel)
        }
    );
    var dadosJson = json.decode(response.body);

    if (fixo != null && fixo == true) {
      UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
      dadosJson = serviceFixo.responseLista();
    }
    List<UsuarioModel> lista = List();
    for (var registro in dadosJson) {
      UsuarioModel usuarioModel = UsuarioModel.fromJson(registro); //.converteJson
      lista.add(usuarioModel);
    }
    return lista;
  }

  Future<List<UsuarioModel>> processaHttpGetListToken(String url, bool fixo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.get(url,
          headers: <String, String>{
            'Authorization': token,
          });
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        var dadosJson = json.decode(source);
        return _parseListaUsuarioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      if (fixo != null && fixo == true) {
        UsuarioServiceFixo serviceFixo = UsuarioServiceFixo();
        var dadosJson = json.decode(serviceFixo.responseLista());
        return _parseListaUsuarioModel(dadosJson);

      } else {
        throw Exception('Falha ao listar redes!!!');
      }

    } catch (error) {
      print(error.toString());
    }
  }

  List<UsuarioModel> _parseListaUsuarioModel(dadosJson) {
    List<UsuarioModel> lista = List();
    for (var registro in dadosJson) {
      UsuarioModel resultadoModel = UsuarioModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  List<PaisesModel> _parseListaPaisesModel(dadosJson) {
    List<PaisesModel> lista = List();
    for (var registro in dadosJson) {
      PaisesModel resultadoModel = PaisesModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  List<EstadosModel> _parseListaEstadosModel(dadosJson) {
    List<EstadosModel> lista = List();
    for (var registro in dadosJson) {
      EstadosModel resultadoModel = EstadosModel.fromJson(
          registro); //.converteJson
      lista.add(resultadoModel);
    }
    return lista;
  }

  Future<UsuarioAssinanteModel> processaHttpGetAssinante(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = await prefs.getString(ConstantesConfig.PREFERENCES_TOKEN);

      http.Response response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        UsuarioAssinanteModel usuarioModel = UsuarioAssinanteModel.fromJson(dadosJson);
        return usuarioModel;

      } else {
        throw Exception('Falha ao carregar Dados de Usuario Assinante!!!');
      }
    } on Exception catch (exception) {

    } catch (error) {
      print(error.toString());
    }
  }
}