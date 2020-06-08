class ClassificacaoTorneioServiceFixo {

  String retorno = '['
        '{ '
          '"id": 1, '
          '"nome": "Profissional", '
          '"descricao": null '
        '}, '
        '{ '
          '"id": 2, '
          '"nome": "Amador", '
          '"descricao": null '
        '}, '
        '{ '
          '"id": 3, '
          '"nome": "Master", '
          '"descricao": null '
        '},'
        '{ '
          '"id": 4, '
          '"nome": "Misto", '
          '"descricao": null '
        '}'
      ']';

  String responseLista() {
    return retorno;
  }

}