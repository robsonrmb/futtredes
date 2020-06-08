import 'package:futt/futt/constantes/ConstantesEstatisticas.dart';

class EstatisticaServiceFixo {

  String retornoPerformancePadrao = '['
        '{'
          '"ruim": 10,'
          '"regular": "15",'
          '"bom": "20",'
          '"otimo": "17"'
        '}'
      ']';

  String retornoPerformanceRecepcao = '['
        '{'
          '"ruim": 10,'
          '"regular": "15",'
          '"bom": "20",'
          '"otimo": "17"'
        '}'
      ']';

  /*
    ESTATÍSTICAS DE QUANTIDADES.
   */
  String retornoQuantidadePadrao = '['
        '{'
          '"valor1": 10,'
          '"valor2": "15"'
        '}'
      ']';

  String retornoQuantidadeVD = '['
        '{'
          '"valor1": 10,'
          '"valor2": "15"'
        '}'
      ']';

  /*
    QUANTIDADES.
   */
  String retornoQuantidadeUnicaPadrao = '['
        '{'
          '"quantidade": 10'
        '}'
      ']';

  String retornoQuantidadeUnicaPontos = '['
        '{'
          '"quantidade": 12'
        '}'
      ']';

  String retornoPerformanceTecnica = '['
        '{'
          '"resposta": "10#12#15#20#18#10#12#15#20#18#10#12#15#20#18#10#12#15#20#18#10#12#15#20#18#10#12#15#20#18#8#3"'
        '}'
      ']';

  String retornoPerformanceTatica = '['
        '{'
        '"resposta": "10#12#15#20#18#10#12#15#20#18#10#12#15#18#10#12#15#20#12#15#20#18#8#3"'
        '}'
      ']';

  String retornoQuantitativos = '['
        '{'
          '"resposta": "24#13#18#8#3#6#13#9"'
        '}'
      ']';

  String retornoJogosPontos = '['
        '{'
          '"resposta": "2020#79#2019#65#2018#41#220#350#2019#259#2018#288"'
        '}'
      ']';

  String retornoSequenciais = '['
        '{'
          '"resposta": "V#D#D#V#D#1#4#2#10#8"'
        '}'
      ']';

  String retornoA2 = '['
        '{'
          '"resposta": "19#12"'
        '}'
      ']';

  String responseListaPerformance(int tipo) {
    if (tipo == 0) {
      return retornoPerformancePadrao;
    }else if (tipo == 1) {
      return retornoPerformanceRecepcao;
    }
  }

  String responseListaQuantidade(int tipo) {
    if (tipo == 0) {
      return retornoQuantidadePadrao;
    }else if (tipo == 1) {
      return retornoQuantidadeVD;
    }
  }

  String responseQuantidade(int tipo) {
    if (tipo == 0) {
      return retornoQuantidadeUnicaPadrao;
    }else if (tipo == 1) {
      return retornoQuantidadeUnicaPontos;
    }
  }

  String responseEstatisticas(int tipo) {
    if (tipo == ConstantesEstatisticas.TECNICA) {
      return retornoPerformanceTecnica;
    }else if (tipo == ConstantesEstatisticas.TATICA) {
      return retornoPerformanceTatica;
    }else if (tipo == ConstantesEstatisticas.QUANTITATIVOS) {
      return retornoQuantitativos;
    }else if (tipo == ConstantesEstatisticas.JOGOSEPONTOS) {
      return retornoJogosPontos;
    }else if (tipo == ConstantesEstatisticas.SEQUENCIAIS) {
      return retornoSequenciais;
    }
  }

}