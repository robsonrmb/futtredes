class RankingEntidadeServiceFixo {

  String retorno = '['
        '{ '
          '"id": 1, '
          '"nome": "CBFv_PROFISSIONAL", '
          '"descricao": "CBFv - Profissional" '
        '}, '
        '{ '
          '"id": 2, '
          '"nome": "TAF_PROFISSIONAL", '
          '"descricao": "TAF - Profissional" '
        '}, '
        '{ '
          '"id": 3, '
          '"nome": "TAF_AMADOR", '
          '"descricao": "TAF - Amador" '
        '}'
      ']';

  String responseLista() {
    return retorno;
  }

}