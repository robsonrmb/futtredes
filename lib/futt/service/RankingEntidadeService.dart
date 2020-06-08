import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RankingEntidadeModel.dart';
import 'package:futt/futt/rest/RankingEntidadeRest.dart';

class RankingEntidadeService {

  Future<List<RankingEntidadeModel>> listaPorUsuario(bool fixo) {
    String url = "${ConstantesRest.URL_RANKING_ENTIDADE}/ativasdousuariologado";
    RankingEntidadeRest tipoTorneioRest = RankingEntidadeRest();
    return tipoTorneioRest.processaHttpGetList(url, fixo);
  }

  Future<List<RankingEntidadeModel>> listaTodos(bool fixo) {
    String url = "${ConstantesRest.URL_RANKING_ENTIDADE}/ativas";
    RankingEntidadeRest tipoTorneioRest = RankingEntidadeRest();
    return tipoTorneioRest.processaHttpGetList(url, fixo);
  }

}