import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/AvaliacaoModel.dart';
import 'package:futt/futt/rest/AvaliacaoRest.dart';
import 'package:futt/futt/rest/fixo/BaseRestFixo.dart';

class AvaliacaoService {

  inclui(var avaliacaoModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_AVALIACOES}/add";
      AvaliacaoRest avaliacaoRest = AvaliacaoRest();
      avaliacaoRest.processaHttpPost(url, avaliacaoModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  aceita(var avaliacaoModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_AVALIACOES}/aceita";
      AvaliacaoRest avaliacaoRest = AvaliacaoRest();
      avaliacaoRest.processaHttpPut(url, avaliacaoModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  recusa(var avaliacaoModel, {bool fixo}) {
    if (fixo == null || fixo == false) {
      String url = "${ConstantesRest.URL_AVALIACOES}/recusa";
      AvaliacaoRest avaliacaoRest = AvaliacaoRest();
      avaliacaoRest.processaHttpPut(url, avaliacaoModel);

    }else{
      BaseRestFixo serviceFixo = BaseRestFixo();
      serviceFixo.processaHttpPostFixo();
    }
  }

  Future<List<AvaliacaoModel>> listaRecebidasPendentes(int idUsuario, bool fixo) {
    String url = "${ConstantesRest.URL_AVALIACOES}/recebidas/pendentes?usuario=${idUsuario}";
    AvaliacaoRest avaliacaoRest = AvaliacaoRest();
    return avaliacaoRest.processaHttpGetList(url, fixo);
  }

  Future<List<AvaliacaoModel>> listaRecebidas(int idUsuario, String status, bool fixo) {
    String url = "${ConstantesRest.URL_AVALIACOES}/recebidas?usuario=${idUsuario}&status=${status}";
    AvaliacaoRest avaliacaoRest = AvaliacaoRest();
    return avaliacaoRest.processaHttpGetList(url, fixo);
  }

}