import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/EstadoModel.dart';
import 'package:futt/futt/model/PaisesModel.dart';
import 'package:futt/futt/model/UsuarioAssinanteModel.dart';
import 'package:futt/futt/model/UsuarioModel.dart';
import 'package:futt/futt/rest/UsuarioRest.dart';

class UsuarioService {

  inclui(var cadastroLoginModel) {
    String url = "${ConstantesRest.URL_USUARIOS}/adiciona";
    UsuarioRest usuarioRest = UsuarioRest();
    usuarioRest.processaHttpPost(url, cadastroLoginModel);
  }

  atualiza(var usuarioModel) {
    String url = "${ConstantesRest.URL_USUARIOS}";
    UsuarioRest usuarioRest = UsuarioRest();
    usuarioRest.processaHttpPut(url, usuarioModel);
  }

  desativa(String idUsuario) {
    String url = "${ConstantesRest.URL_USUARIOS}/desativa/${idUsuario}";
    UsuarioRest usuarioRest = UsuarioRest();
    usuarioRest.processaHttpPut(url, "");
  }

  exclui(String idUsuario) {
    String url = "${ConstantesRest.URL_USUARIOS}/${idUsuario}";
    UsuarioRest usuarioRest = UsuarioRest();
    usuarioRest.processaHttpDelete(url);
  }

  Future<UsuarioModel?> buscaPorId(String idUsuario) {
    String url = "${ConstantesRest.URL_USUARIOS}/${idUsuario}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetObject(url);
  }

  Future<UsuarioModel?> buscaLogado() {
    String url = "${ConstantesRest.URL_USUARIOS}/logado";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetObject(url);
  }

  Future<List<UsuarioModel>?> listaTodos() {
    String url = "${ConstantesRest.URL_USUARIOS}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetList(url);
  }

  Future<List<UsuarioModel>> listaPorFiltros(var usuarioModel) {
    String url = "${ConstantesRest.URL_USUARIOS}/filter";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpPostReturn(url, usuarioModel);
  }

  Future<List<UsuarioModel>> listaPorFiltroComFlagAmigoDoUsuario(String idUsuario, var usuarioModel) {
    String url = "${ConstantesRest.URL_USUARIOS}/filterComFlagAmigoDoUsuario/${idUsuario}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpPostReturn(url, usuarioModel);
  }

  Future<List<UsuarioModel>> listaPorFiltroComFlagAmigo(var usuarioModel) {
    String url = "${ConstantesRest.URL_USUARIOS}/filterComFlagAmigo";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpPostReturn(url, usuarioModel);
  }

  Future<List<UsuarioModel>?> listaPorEstado(String estado) {
    String url = "${ConstantesRest.URL_USUARIOS}/filterEstado/${estado}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetList(url);
  }

  Future<UsuarioModel?> buscaPorEmail(String email) {
    String url = "${ConstantesRest.URL_USUARIOS}/filterEmail/${email}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetObject(url);
  }

  Future<List<UsuarioModel>?> listaPorNome(String nome) {
    String url = "${ConstantesRest.URL_USUARIOS}/filterNome/${nome}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetList(url);
  }

  Future<List<PaisesModel>?> listaPaises() {
    String url = "${ConstantesRest.URL_PAISES}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetListPaises(url);
  }

  Future<List<EstadosModel>?> listaEstados() {
    String url = "${ConstantesRest.URL_ESTADOS}";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetListEstados(url);
  }

  Future<UsuarioAssinanteModel?> buscaUsuarioAssinante() {
    String url = "${ConstantesRest.URL_USUARIOS}/assinatura/futtredes";
    UsuarioRest usuarioRest = UsuarioRest();
    return usuarioRest.processaHttpGetAssinante(url);
  }
}