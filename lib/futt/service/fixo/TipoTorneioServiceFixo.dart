class TipoTorneioServiceFixo {

  String retorno = '['
        '{ '
          '"id": 1, '
          '"nome": "Dupla eliminatória", '
          '"descricao": null, '
          '"geracaoJogos": "S" '
        '}, '
        '{ '
          '"id": 2, '
          '"nome": "Eliminatória simples", '
          '"descricao": null, '
          '"geracaoJogos": "S" '
        '}'
        /*'{ '
          '"id": 3, '
          '"nome": "Torneio de grupos", '
          '"descricao": null, '
          '"geracaoJogos": "N" '
        '}'*/
      ']';

  String responseLista() {
    return retorno;
  }

}