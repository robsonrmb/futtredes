import 'package:futt/futt/model/utils/PaisModel.dart';
import 'package:futt/futt/rest/utils/PaisRest.dart';

class PaisService {

  Future<List<PaisModel>> listaPaises() async {
    PaisRest paisRest = PaisRest();
    return paisRest.processaHttpGetList();
  }

}