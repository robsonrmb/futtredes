import 'dart:convert';
import 'package:futt/futt/model/UsuarioModel.dart';

class UsuarioServiceFixo {

  String retornoUsuario = '{ '
        '"id": 1, '
        '"nome": "Robson", '
        '"email": "robson@gmail.com", '
        '"apelido": null, '
        '"dataNascimento": null, '
        '"ondeJoga": null, '
        '"tipo": null, '
        '"nivel": null, '
        '"cidade": null, '
        '"estado": "DF", '
        '"pais": "Brasil", '
        '"status": "A", '
        '"sexo": "M", '
        '"nomeFoto": null, '
        '"fotografia": null, '
        '"amigo": false, '
        '"dataNascimentoFormatada": "", '
        '"desativo": false, '
        '"ativo": true '
      '}';

  String retornoUsuarios = '[ '
        '{ '
          '"id": 1, '
          '"nome": "Robson", '
          '"email": "robson@gmail.com", '
          '"apelido": null, '
          '"dataNascimento": null, '
          '"ondeJoga": null, '
          '"tipo": null, '
          '"nivel": null, '
          '"cidade": null, '
          '"estado": "DF", '
          '"pais": "Brasil", '
          '"status": "A", '
          '"sexo": "M", '
          '"nomeFoto": null, '
          '"fotografia": null, '
          '"amigo": false, '
          '"dataNascimentoFormatada": "", '
          '"desativo": false, '
          '"ativo": true '
        '} '
      ']';

  String responseLista() {
    return retornoUsuarios;
  }

  String responseObjeto() {
    return retornoUsuarios;
  }

  Future<UsuarioModel> _buscaUsuarioFixo() async {
    var dadosJson = json.decode(retornoUsuario);
    return UsuarioModel.fromJson(dadosJson); //.converteJson
  }

  Future<List<UsuarioModel>> _listaUsuariosFixo() async {
    var dadosJson = json.decode(retornoUsuarios);
    List<UsuarioModel> lista = List();
    for (var registro in dadosJson) {
      UsuarioModel usuarioModel = UsuarioModel.fromJson(registro); //.converteJson
      lista.add(usuarioModel);
    }
    return lista;
  }

  Future<UsuarioModel> buscaPorId(String idUsuario) async {
    return _buscaUsuarioFixo();
  }

  Future<List<UsuarioModel>> listaTodos() async {
    return _listaUsuariosFixo();
  }

  Future<List<UsuarioModel>> listaPorFiltros(var usuarioModel) async {
    return _listaUsuariosFixo();
  }

  Future<List<UsuarioModel>> listaPorFiltroComFlagAmigoDoUsuario(String idUsuario, var usuarioModel) async {
    return _listaUsuariosFixo();
  }

  Future<List<UsuarioModel>> listaPorFiltroComFlagAmigo() async {
    return _listaUsuariosFixo();
  }

  Future<List<UsuarioModel>> listaPorEstado(String estado) async {
    return _listaUsuariosFixo();
  }

  Future<UsuarioModel> listaPorEmail(String email) async {
    return _buscaUsuarioFixo();
  }

  Future<List<UsuarioModel>> listaPorNome(String nome) async {
    return _listaUsuariosFixo();
  }

}