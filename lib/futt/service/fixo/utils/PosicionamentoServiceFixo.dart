class PosicionamentoServiceFixo {

  String retornoPosicionamentos = '['
        '{'
          '"id": "D",'
          '"nome": "Direita"'
        '},'
        '{'
          '"id": "E",'
          '"nome": "Esquerda"'
        '},'
        '{'
          '"id": "A",'
          '"nome": "Ambas"'
        '}'
      ']';

  String responseLista() {
    return retornoPosicionamentos;
  }

}