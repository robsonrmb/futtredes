class RedeServiceFixo {

  String _retornoRedesQParticipo = '[ '
      '{'
        '"id": 1, '
        '"nome": "Show do Milhão", '
        '"nomeFoto": "teste", '
        '"status": 2, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Rio de Janeiro", '
        '"local": "Ipanema", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-06-01", '
        '"qtdIntegrantes": 50, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '}, '
      '{'
        '"id": 2, '
        '"nome": "AABB Master", '
        '"nomeFoto": "teste", '
        '"status": 2, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Brasília", '
        '"local": "Clube AABB", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-08-01", '
        '"qtdIntegrantes": 10, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '},'
      '{'
        '"id": 3, '
        '"nome": "SQA", '
        '"nomeFoto": "teste", '
        '"status": 2, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Brasília", '
        '"local": "Condomínio SQA", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-09-01", '
        '"qtdIntegrantes": 10, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '},'
      '{'
        '"id": 4, '
        '"nome": "Liga das Trevas", '
        '"nomeFoto": "teste", '
        '"status": 2, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Brasília", '
        '"local": "Parque da Cidade", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-10-01", '
        '"qtdIntegrantes": 50, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '},'
      '{'
        '"id": 5, '
        '"nome": "Rede do Candango", '
        '"nomeFoto": "teste", '
        '"status": 4, '
        '"pais": "Brasil", '
        '"estado": null, '
        '"cidade": "Brasília", '
        '"local": "Parque da Cidade", '
        '"info": "Dados gerais da rede", '
        '"disponibilidade": "2020-06-01", '
        '"qtdIntegrantes": 50, '
        '"responsavelRede": 1, '
        '"responsavelJogos1": 0, '
        '"responsavelJogos2": 0, '
        '"responsavelJogos3": 0 '
      '}'
    ']';

  String _retornoMinhasRedes = '[ '
        '{'
          '"id": 2, '
          '"nome": "AABB Master", '
          '"nomeFoto": "", '
          '"status": 2, '
          '"pais": "Brasil", '
          '"estado": null, '
          '"cidade": "Brasília", '
          '"local": "Clube AABB", '
          '"info": "Dados gerais da rede", '
          '"disponibilidade": "2020-08-01", '
          '"qtdIntegrantes": 10, '
          '"responsavelRede": 1, '
          '"responsavelJogos1": 0, '
          '"responsavelJogos2": 0, '
          '"responsavelJogos3": 0 '
        '},'
        '{'
          '"id": 3, '
          '"nome": "SQA", '
          '"nomeFoto": "", '
          '"status": 2, '
          '"pais": "Brasil", '
          '"estado": null, '
          '"cidade": "Brasília", '
          '"local": "Condomínio SQA", '
          '"info": "Dados gerais da rede", '
          '"disponibilidade": "2020-09-01", '
          '"qtdIntegrantes": 10, '
          '"responsavelRede": 1, '
          '"responsavelJogos1": 0, '
          '"responsavelJogos2": 0, '
          '"responsavelJogos3": 0 '
        '},'
        '{'
          '"id": 4, '
          '"nome": "Liga das Trevas", '
          '"nomeFoto": "", '
          '"status": 2, '
          '"pais": "Brasil", '
          '"estado": null, '
          '"cidade": "Brasília", '
          '"local": "Parque da Cidade", '
          '"info": "Dados gerais da rede", '
          '"disponibilidade": "2020-10-01", '
          '"qtdIntegrantes": 50, '
          '"responsavelRede": 1, '
          '"responsavelJogos1": 0, '
          '"responsavelJogos2": 0, '
          '"responsavelJogos3": 0 '
        '},'
        '{'
          '"id": 5, '
          '"nome": "Rede do Candango", '
          '"nomeFoto": "", '
          '"status": 4, '
          '"pais": "Brasil", '
          '"estado": null, '
          '"cidade": "Brasília", '
          '"local": "Parque da Cidade", '
          '"info": "Dados gerais da rede", '
          '"disponibilidade": "2020-06-01", '
          '"qtdIntegrantes": 50, '
          '"responsavelRede": 1, '
          '"responsavelJogos1": 0, '
          '"responsavelJogos2": 0, '
          '"responsavelJogos3": 0 '
        '}'
      ']';

  String _retornoIntegrantes = '[ '
        '{ '
          '"idUsuario": 1, '
          '"nome": "Robson", '
          '"nomeFoto": null, '
          '"pais": "Brasil", '
          '"estado": "DF", '
          '"idRede": 1 '
        '}, '
        '{ '
          '"idUsuario": 2, '
          '"nome": "Pedro", '
          '"nomeFoto": null, '
          '"pais": "Brasil", '
          '"estado": "DF", '
          '"idRede": 1 '
        '} '
      ']';

  String responseRedeLista(String tipo) {
    if (tipo == "1") {
      return _retornoRedesQParticipo;
    }else{
      return _retornoMinhasRedes;
    }
  }

  String responseIntegrantesLista() {
    return _retornoIntegrantes;
  }

}