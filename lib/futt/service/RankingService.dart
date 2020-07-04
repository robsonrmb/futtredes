import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/RankingModel.dart';
import 'package:futt/futt/rest/RankingRest.dart';

class RankingService {

  Future<List<RankingModel>> listaRankingRede(int idRede, int ano, int tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/rankingvitorias/${idRede}";
    if (tipo == 2) {
      url = "${ConstantesRest.URL_ESTATISTICAS}/rankingjogos/${idRede}";
    }else if (tipo == 3) {
      url = "${ConstantesRest.URL_ESTATISTICAS}/rankingpontos/${idRede}";
    }else if (tipo == 4) {
      url = "${ConstantesRest.URL_ESTATISTICAS}/rankingmedia/${idRede}";
    }
    RankingRest rankingRest = RankingRest();
    return rankingRest.processaHttpGetList(url, fixo);
  }

}