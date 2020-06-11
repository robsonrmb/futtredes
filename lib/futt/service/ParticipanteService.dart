import 'package:futt/futt/constantes/ConstantesRest.dart';
import 'package:futt/futt/model/ParticipanteModel.dart';
import 'package:futt/futt/rest/ParticipanteRest.dart';

class ParticipanteService {

  Future<List<ParticipanteModel>> listaParticipantesDaRede(int idRede, bool fixo, int lista) {
    String url = "${ConstantesRest.URL_PARTICIPANTES}/${idRede}";
    ParticipanteRest participanteRest = ParticipanteRest();
    return participanteRest.processaHttpGetList(url, fixo, lista);
  }

}