class ParticipanteServiceFixo {

  String retornoParticipantes = '['
        '{'
          '"idUsurio": 9,'
          '"nome": "Messi",'
          '"nomeFoto": "https://i.pinimg.com/originals/88/31/be/8831be300e5b4b7758f0bc34ef6d5db8.jpg",'
          '"pais": "Espanha",'
          '"cidade": "Barcelona"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Suarez",'
          '"nomeFoto": "https://3.bp.blogspot.com/-HCGJETqqJP0/VDspCWJ_1DI/AAAAAAAAAoI/warI-4pJH9A/s1600/suarez14.jpg",'
          '"pais": "Uruguai",'
          '"cidade": "Montevidéu"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Ronaldinho Gaúcho",'
          '"nomeFoto": "https://cdna.artstation.com/p/assets/images/images/011/583/200/large/marcelo-lima-26187682-1971683559710857-21601598144774144-n.jpg?1530311997",'
          '"pais": "Brasil",'
          '"cidade": "Porto Alegre"'
        '},'
        '{'
          '"idUsurio": 9,'
          '"nome": "Rivaldo",'
          '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
          '"pais": "Brasil",'
          '"cidade": "Recife"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Neymar",'
          '"nomeFoto": "https://3.bp.blogspot.com/-HCGJETqqJP0/VDspCWJ_1DI/AAAAAAAAAoI/warI-4pJH9A/s1600/suarez14.jpg",'
          '"pais": "Brasil",'
          '"cidade": "São Paulo"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "MBappe",'
          '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
          '"pais": "França",'
          '"cidade": "Paris"'
        '},'
        '{'
          '"idUsurio": 9,'
          '"nome": "Romário",'
          '"nomeFoto": "https://live.staticflickr.com/5116/5862708162_d0bc38a073_z.jpg",'
          '"pais": "Espanha",'
          '"cidade": "Barcelona"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Bebeto",'
          '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
          '"pais": "Uruguai",'
          '"cidade": "Montevidéu"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Marcelo",'
          '"nomeFoto": "https://i.pinimg.com/originals/1a/64/50/1a64503c82c12a2f1aea73cbad418db7.jpg",'
          '"pais": "Brasil",'
          '"cidade": "Rio de Janeiro"'
        '},'
        '{'
          '"idUsurio": 9,'
          '"nome": "Coutinho",'
          '"nomeFoto": "https://i.pinimg.com/originals/50/65/c9/5065c907335f6cf04a5d1db7408036c9.jpg",'
          '"pais": "Brasil",'
          '"cidade": "Rio de Janeiro"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Robson",'
          '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
          '"pais": "Brasil",'
          '"cidade": "Brasília"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Pedrinho",'
          '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
          '"pais": "Brasil",'
          '"cidade": "Brasília"'
        '}'
      ']';

  String retornoParticipantesExcluido = '['
        '{'
          '"idUsurio": 9,'
          '"nome": "Messi",'
          '"nomeFoto": "https://i.pinimg.com/originals/88/31/be/8831be300e5b4b7758f0bc34ef6d5db8.jpg",'
          '"pais": "Espanha",'
          '"cidade": "Barcelona"'
        '},'
        '{'
          '"idTorneio": 9,'
          '"nome": "Suarez",'
          '"nomeFoto": "https://3.bp.blogspot.com/-HCGJETqqJP0/VDspCWJ_1DI/AAAAAAAAAoI/warI-4pJH9A/s1600/suarez14.jpg",'
          '"pais": "Uruguai",'
          '"cidade": "Montevidéu"'
        '},'
      ']';

  String retornoParticipantesIncluido = '['
      '{'
        '"idUsurio": 9,'
        '"nome": "Messi",'
        '"nomeFoto": "https://i.pinimg.com/originals/88/31/be/8831be300e5b4b7758f0bc34ef6d5db8.jpg",'
        '"pais": "Espanha",'
        '"cidade": "Barcelona"'
      '},'
      '{'
        '"idUsurio": 9,'
        '"nome": "Rivaldo",'
        '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
        '"pais": "Brasil",'
        '"cidade": "Recife"'
      '},'
      '{'
        '"idTorneio": 9,'
        '"nome": "Neymar",'
        '"nomeFoto": "https://3.bp.blogspot.com/-HCGJETqqJP0/VDspCWJ_1DI/AAAAAAAAAoI/warI-4pJH9A/s1600/suarez14.jpg",'
        '"pais": "Brasil",'
        '"cidade": "São Paulo"'
      '},'
      '{'
        '"idTorneio": 9,'
        '"nome": "Pedrinho",'
        '"nomeFoto": "https://pbs.twimg.com/media/Dk0iKh4XoAERLOB.jpg",'
        '"pais": "Brasil",'
        '"cidade": "Brasília"'
      '}'
      ']';

  String responseLista(int lista) {
    if (lista == 0) {
      return retornoParticipantes;
    }else if (lista == 1) {
      return retornoParticipantesExcluido;
    }else if (lista == 2) {
      return retornoParticipantesIncluido;
    }
  }

}