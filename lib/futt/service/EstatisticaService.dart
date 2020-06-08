import 'package:futt/futt/constantes/ConstantesEstatisticas.dart';
import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/QuantidadeModel.dart';
import 'package:futt/futt/model/RespPerformanceModel.dart';
import 'package:futt/futt/model/RespQuantidadeModel.dart';
import 'package:futt/futt/model/RespostaModel.dart';
import 'package:futt/futt/rest/EstatisticaRest.dart';

class EstatisticaService {

  Future<List<RespQuantidadeModel>> vitoriasDerrotas(String idUsuario, String ano, String id, String tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/vitoriasederrotas/usuario/${idUsuario}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespQuantidadeModel>> tiebreaks(String idUsuario, String ano, String idTorneio, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/tiebreaksvencidoseperdidos/usuario/${idUsuario}?ano=${ano}&&id=${idTorneio}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespQuantidadeModel>> pontos(String idUsuario, String ano, String id, String tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/pontos/usuario/${idUsuario}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespQuantidadeModel>> jogos(String idUsuario, String ano, String id, String tipo, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/jogos/usuario/${idUsuario}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespQuantidade(url, 1, fixo);
  }

  Future<List<RespPerformanceModel>> avaliativa(String idUsuario, String tipo, String ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/avaliativa/usuario/${idUsuario}/${tipo}?ano=${ano}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListRespPerformance(url, 0, fixo);
  }

  Future<List<QuantidadeModel>> quantitativa(String idUsuario, String tipoestatistica, String ano, String id, String tipo, bool fixo) async {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/qtd/usuario/${idUsuario}/${tipoestatistica}?ano=${ano}&&id=${id}&&tipo=${tipo}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListQuantidade(url, 0, fixo);
  }

  Future<List<RespostaModel>> getPerformanceTecnica(int idUsuario, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/performancetecnica/${idUsuario}?ano=${ano}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.TECNICA, fixo); //tecnicas
  }

  Future<List<RespostaModel>> getPerformanceTatica(int idUsuario, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/performancetatica/${idUsuario}?ano=${ano}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.TATICA, fixo); //táticas
  }

  Future<List<RespostaModel>> getQuantitativas(int idUsuario, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/quantitativas/${idUsuario}?ano=${ano}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.QUANTITATIVOS, fixo); //quantitativas
  }

  Future<List<RespostaModel>> getJogosEPontos(int idUsuario, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/jogosepontos/${idUsuario}?ano=${ano}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.JOGOSEPONTOS, fixo); //jogos e pontos
  }

  Future<List<RespostaModel>> getSequenciais(int idUsuario, int ano, bool fixo) {
    String url = "${ConstantesRest.URL_ESTATISTICAS}/sequenciais/${idUsuario}?ano=${ano}";
    EstatisticaRest estatisticaRest = EstatisticaRest();
    return estatisticaRest.processaHttpGetListResposta(url, ConstantesEstatisticas.SEQUENCIAIS, fixo); //jogos e pontos
  }

}