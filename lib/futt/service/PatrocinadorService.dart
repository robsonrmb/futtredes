import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/PatrocinadorModel.dart';
import 'package:futt/futt/rest/PatrocinadorRest.dart';

class PatrocinadorService {

  inclui(var patrocinadorModel) {
    String url = "${ConstantesRest.URL_PATROCINADOR}/adiciona";
    PatrocinadorRest patrocinadorRest = PatrocinadorRest();
    patrocinadorRest.processaHttpPost(url, patrocinadorModel);
  }

  atualiza(var patrocinadorModel) {
    String url = "${ConstantesRest.URL_PATROCINADOR}/atualiza";
    PatrocinadorRest patrocinadorRest = PatrocinadorRest();
    patrocinadorRest.processaHttpPut(url, patrocinadorModel);
  }

  remove(String idPatrocinador) {
    String url = "${ConstantesRest.URL_PATROCINADOR}/remove/${idPatrocinador}";
    PatrocinadorRest patrocinadorRest = PatrocinadorRest();
    patrocinadorRest.processaHttpDelete(url);
  }

  Future<List<PatrocinadorModel>> listaPatrocinadores() {
    String url = "${ConstantesRest.URL_PATROCINADOR}/ativos";
    PatrocinadorRest patrocinadorRest = PatrocinadorRest();
    return patrocinadorRest.processaHttpGetList(url);
  }

  Future<List<PatrocinadorModel>> listaPorTorneios(String idTorneio) {
    String url = "${ConstantesRest.URL_PATROCINADOR}/torneio/${idTorneio}";
    PatrocinadorRest patrocinadorRest = PatrocinadorRest();
    return patrocinadorRest.processaHttpGetList(url);
  }

}