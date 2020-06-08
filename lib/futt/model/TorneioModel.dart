class TorneioModel {
  int _id;
  String _nome;
  int _status;
  String _pais;
  String _estado;
  String _cidade;
  String _local;
  String _dataInicio;
  String _dataFim;
  int _ano;
  int _qtdDuplas;
  String _genero;
  String _info;
  int _usuarioAdministrador;
  int _atletaCampeao1;
  int _atletaCampeao2;
  int _atletaCampeao3;
  int _atletaCampeao4;
  int _atletaCampeao5;
  int _atletaViceCampeao1;
  int _atletaViceCampeao2;
  int _atletaViceCampeao3;
  int _atletaViceCampeao4;
  int _atletaViceCampeao5;
  int _atletaTerceiroLugar1;
  int _atletaTerceiroLugar2;
  int _atletaTerceiroLugar3;
  int _atletaTerceiroLugar4;
  int _atletaTerceiroLugar5;
  String _logoTorneio;

  int _idTipoTorneio;
  String _nomeTipoTorneio;

  int _idClassificacao;
  String _nomeClassificacao;

  int _idEntidade;
  String _nomeEntidade;

  int _idRankingEntidade;
  String _descricaoRankingEntidade;

  TorneioModel(this._id, this._nome, this._status, this._pais, this._estado,
      this._cidade, this._local, this._dataInicio, this._dataFim, this._ano,
      this._qtdDuplas, this._genero, this._info, this._usuarioAdministrador,
      this._atletaCampeao1, this._atletaCampeao2, this._atletaCampeao3,
      this._atletaCampeao4, this._atletaCampeao5, this._atletaViceCampeao1,
      this._atletaViceCampeao2, this._atletaViceCampeao3,
      this._atletaViceCampeao4, this._atletaViceCampeao5,
      this._atletaTerceiroLugar1, this._atletaTerceiroLugar2,
      this._atletaTerceiroLugar3, this._atletaTerceiroLugar4,
      this._atletaTerceiroLugar5, this._logoTorneio, this._idTipoTorneio,
      this._nomeTipoTorneio, this._idClassificacao, this._nomeClassificacao,
      this._idEntidade, this._nomeEntidade, this._idRankingEntidade,
      this._descricaoRankingEntidade);

  TorneioModel.Novo(this._nome, this._idTipoTorneio, this._idClassificacao,
      this._genero, this._idEntidade, this._idRankingEntidade, this._pais, this._cidade,
      this._local, this._dataInicio, this._dataFim, this._qtdDuplas, this._info);

  TorneioModel.Edita(this._id, this._nome, this._idTipoTorneio, this._idClassificacao,
      this._genero, this._idEntidade, this._idRankingEntidade, this._pais, this._cidade,
      this._local, this._dataInicio, this._dataFim, this._qtdDuplas, this._info);

  TorneioModel.Filtro(this._nome, this._pais, this._cidade, this._dataInicio);

  TorneioModel.Campeoes(this._atletaCampeao1, this._atletaCampeao2, this._atletaViceCampeao1, this._atletaViceCampeao2);

  TorneioModel.Terceiro(this._atletaTerceiroLugar1, this._atletaTerceiroLugar2);

  factory TorneioModel.fromJson(Map<String, dynamic> json) {
    int _idTipoTorneioProvisorio = null;
    String _nomeTipoTorneioProvisorio = "";
    if (json["tipo"] != null) {
      _idTipoTorneioProvisorio = json["tipo"]["id"];
      _nomeTipoTorneioProvisorio = json["tipo"]["nome"];
    }

    int _idClassificacaoProvisorio = null;
    String _nomeClassificacaoProvisorio = "";
    if (json["classificacao"] != null) {
      _idClassificacaoProvisorio = json["classificacao"]["id"];
      _nomeClassificacaoProvisorio = json["classificacao"]["nome"];
    }

    int _idEntidadeProvisorio = null;
    String _nomeEntidadeProvisorio = "";
    if (json["entidade"] != null) {
      _idEntidadeProvisorio = json["entidade"]["id"];
      _nomeEntidadeProvisorio = json["entidade"]["nome"];
    }

    int _idRankingEntidadeProvisorio = null;
    String _descricaoRankingEntidadeProvisorio = "";
    if (json["rankingEntidade"] != null) {
      _idRankingEntidadeProvisorio = json["rankingEntidade"]["id"];
      _descricaoRankingEntidadeProvisorio = json["rankingEntidade"]["descricao"];
    }

    return TorneioModel(
      json["id"],
      json["nome"],
      json["status"],
      json["pais"],
      json["estado"],
      json["cidade"],
      json["local"],
      json["dataInicio"],
      json["dataFim"],
      json["ano"],
      json["qtdDuplas"],
      json["genero"],
      json["info"],
      json["usuarioAdministrador"],
      json["atletaCampeao1"],
      json["atletaCampeao2"],
      json["atletaCampeao3"],
      json["atletaCampeao4"],
      json["atletaCampeao5"],
      json["atletaViceCampeao1"],
      json["atletaViceCampeao2"],
      json["atletaViceCampeao3"],
      json["atletaViceCampeao4"],
      json["atletaViceCampeao5"],
      json["atletaTerceiroLugar1"],
      json["atletaTerceiroLugar2"],
      json["atletaTerceiroLugar3"],
      json["atletaTerceiroLugar4"],
      json["atletaTerceiroLugar5"],
      json["logoTorneio"],
      _idTipoTorneioProvisorio,
      _nomeTipoTorneioProvisorio,
      _idClassificacaoProvisorio,
      _nomeClassificacaoProvisorio,
      _idEntidadeProvisorio,
      _nomeEntidadeProvisorio,
      _idRankingEntidadeProvisorio,
      _descricaoRankingEntidadeProvisorio,
    );
  }

  int get idRankingEntidade => _idRankingEntidade;

  set idRankingEntidade(int value) {
    _idRankingEntidade = value;
  }

  int get idEntidade => _idEntidade;

  set idEntidade(int value) {
    _idEntidade = value;
  }

  int get idClassificacao => _idClassificacao;

  set idClassificacao(int value) {
    _idClassificacao = value;
  }

  int get idTipoTorneio => _idTipoTorneio;

  set idTipoTorneio(int value) {
    _idTipoTorneio = value;
  }

  int get atletaTerceiroLugar5 => _atletaTerceiroLugar5;

  set atletaTerceiroLugar5(int value) {
    _atletaTerceiroLugar5 = value;
  }

  int get atletaTerceiroLugar4 => _atletaTerceiroLugar4;

  set atletaTerceiroLugar4(int value) {
    _atletaTerceiroLugar4 = value;
  }

  int get atletaTerceiroLugar3 => _atletaTerceiroLugar3;

  set atletaTerceiroLugar3(int value) {
    _atletaTerceiroLugar3 = value;
  }

  int get atletaTerceiroLugar2 => _atletaTerceiroLugar2;

  set atletaTerceiroLugar2(int value) {
    _atletaTerceiroLugar2 = value;
  }

  int get atletaTerceiroLugar1 => _atletaTerceiroLugar1;

  set atletaTerceiroLugar1(int value) {
    _atletaTerceiroLugar1 = value;
  }

  int get atletaViceCampeao5 => _atletaViceCampeao5;

  set atletaViceCampeao5(int value) {
    _atletaViceCampeao5 = value;
  }

  int get atletaViceCampeao4 => _atletaViceCampeao4;

  set atletaViceCampeao4(int value) {
    _atletaViceCampeao4 = value;
  }

  int get atletaViceCampeao3 => _atletaViceCampeao3;

  set atletaViceCampeao3(int value) {
    _atletaViceCampeao3 = value;
  }

  int get atletaViceCampeao2 => _atletaViceCampeao2;

  set atletaViceCampeao2(int value) {
    _atletaViceCampeao2 = value;
  }

  int get atletaViceCampeao1 => _atletaViceCampeao1;

  set atletaViceCampeao1(int value) {
    _atletaViceCampeao1 = value;
  }

  int get atletaCampeao5 => _atletaCampeao5;

  set atletaCampeao5(int value) {
    _atletaCampeao5 = value;
  }

  int get atletaCampeao4 => _atletaCampeao4;

  set atletaCampeao4(int value) {
    _atletaCampeao4 = value;
  }

  int get atletaCampeao3 => _atletaCampeao3;

  set atletaCampeao3(int value) {
    _atletaCampeao3 = value;
  }

  int get atletaCampeao2 => _atletaCampeao2;

  set atletaCampeao2(int value) {
    _atletaCampeao2 = value;
  }

  int get atletaCampeao1 => _atletaCampeao1;

  set atletaCampeao1(int value) {
    _atletaCampeao1 = value;
  }

  int get usuarioAdministrador => _usuarioAdministrador;

  set usuarioAdministrador(int value) {
    _usuarioAdministrador = value;
  }

  String get info => _info;

  set info(String value) {
    _info = value;
  }

  String get genero => _genero;

  set genero(String value) {
    _genero = value;
  }

  int get qtdDuplas => _qtdDuplas;

  set qtdDuplas(int value) {
    _qtdDuplas = value;
  }

  int get ano => _ano;

  set ano(int value) {
    _ano = value;
  }

  String get dataFim => _dataFim;

  set dataFim(String value) {
    _dataFim = value;
  }

  String get dataInicio => _dataInicio;

  set dataInicio(String value) {
    _dataInicio = value;
  }

  String get local => _local;

  set local(String value) {
    _local = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get logoTorneio => _logoTorneio;

  set logoTorneio(String value) {
    _logoTorneio = value;
  }

  String get nomeTipoTorneio => _nomeTipoTorneio;

  set nomeTipoTorneio(String value) {
    _nomeTipoTorneio = value;
  }

  String get nomeClassificacao => _nomeClassificacao;

  String get descricaoRankingEntidade => _descricaoRankingEntidade;

  set descricaoRankingEntidade(String value) {
    _descricaoRankingEntidade = value;
  }

  String get nomeEntidade => _nomeEntidade;

  set nomeEntidade(String value) {
    _nomeEntidade = value;
  }

  set nomeClassificacao(String value) {
    _nomeClassificacao = value;
  }

  String getStatusFormatado () {
    if (status == 10) {
      return "EM FASE DE DIVULGAÇÃO";
    }else if (status == 20) {
      return "EM FASE DE INSCRIÇÃO";
    }else if (status == 30) {
      return "EM FASE DE ANÁLISE";
    }else if (status == 40) {
      return "EM ANDAMENTO";
    }else if (status == 50) {
      return "JOGOS FINALIZADOS";
    }else if (status == 60) {
      return "GERAÇÃO DE RANKING";
    }else if (status == 70) {
      return "FINALIZADO";
    }else if (status == 99) {
      return "DESATIVADO";
    }
  }

  int getStatusJogosFinalizadosComTorneiosAutomaticos () {
    if (status == 50 && idRankingEntidade != 0) {
      return 51;
    }else if (status == 60 || (status == 50 && idRankingEntidade == 0)) {
      return 52;
    }
  }

}