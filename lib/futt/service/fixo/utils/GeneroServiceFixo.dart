class GeneroServiceFixo {

  String retornoGeneros = '['
        '{'
          '"id": "M",'
          '"nome": "Masculino"'
        '},'
        '{'
          '"id": "F",'
          '"nome": "Feminino"'
        '}'
      ']';

  String responseLista() {
    return retornoGeneros;
  }

}