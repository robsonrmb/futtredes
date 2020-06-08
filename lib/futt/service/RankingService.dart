import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RankingModel.dart';
import 'package:futt/futt/rest/RankingRest.dart';

class RankingService {

  Future<List<RankingModel>> listaRanking(int ano, int idRanking, bool fixo) {
    String url = "${ConstantesRest.URL_RANKING}/${ano}/${idRanking}";
    RankingRest rankingRest = RankingRest();
    bool _filtro = true;
    if (ano%2 == 0) {
      _filtro = false;
    }
    return rankingRest.processaHttpGetList(url, _filtro, fixo);
  }

}