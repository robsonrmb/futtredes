import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/TipoAvaliacaoModel.dart';
import 'package:futt/futt/rest/TipoAvaliacaoRest.dart';

class TipoAvaliacaoService {

  Future<TipoAvaliacaoModel> getAvaliacao(String id, {bool fixo}) {
    String url = "${ConstantesRest.URL_TIPO_AVALIACOES}/${id}";
    TipoAvaliacaoRest tipoAvaliacaoRest = TipoAvaliacaoRest();
    return tipoAvaliacaoRest.processaHttpGetObject(url, fixo);
  }

  Future<List<TipoAvaliacaoModel>> listaPorNome(String nome, {bool fixo}) {
    String url = "${ConstantesRest.URL_TIPO_AVALIACOES}/porNome/${nome}";
    TipoAvaliacaoRest tipoAvaliacaoRest = TipoAvaliacaoRest();
    return tipoAvaliacaoRest.processaHttpGetList(url, fixo);
  }

  Future<List<TipoAvaliacaoModel>> listaPorParteDoNome(String nome, {bool fixo}) {
    String url = "${ConstantesRest.URL_TIPO_AVALIACOES}?nome=${nome}";
    TipoAvaliacaoRest tipoAvaliacaoRest = TipoAvaliacaoRest();
    return tipoAvaliacaoRest.processaHttpGetList(url, fixo);
  }

  Future<List<TipoAvaliacaoModel>> listaFind(String nome, {bool fixo}) {
    String url = "${ConstantesRest.URL_TIPO_AVALIACOES}/find?nome=${nome}";
    TipoAvaliacaoRest tipoAvaliacaoRest = TipoAvaliacaoRest();
    return tipoAvaliacaoRest.processaHttpGetList(url, fixo);
  }

  Future<List<TipoAvaliacaoModel>> listaTodos({bool fixo}) {
    String url = "${ConstantesRest.URL_TIPO_AVALIACOES}";
    TipoAvaliacaoRest tipoAvaliacaoRest = TipoAvaliacaoRest();
    return tipoAvaliacaoRest.processaHttpGetList(url, fixo);
  }

}