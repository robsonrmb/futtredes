class GeneroServiceFixo {

  String retornoGeneros = '['
        '{'
          '"id": "1",'
          '"nome": "Masculino"'
        '},'
        '{'
          '"id": "2",'
          '"nome": "Feminino"'
        '},'
        '{'
          '"id": "3",'
          '"nome": "Misto"'
        '}'
      ']';

  String responseLista() {
    return retornoGeneros;
  }

}