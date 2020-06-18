class JogoRedeModel {
  int _id;
  int _numero;
  int _pontuacao1;
  int _pontuacao2;
  String _data;
  int _idRede;
  int _idJogador1;
  int _idJogador2;
  int _idJogador3;
  int _idJogador4;
  int _idJogador5;
  int _idJogador6;
  int _idJogador7;
  int _idJogador8;
  int _idJogador9;
  int _idJogador10;
  String _nomeJogador1;
  String _nomeJogador2;
  String _nomeJogador3;
  String _nomeJogador4;
  String _nomeJogador5;
  String _nomeJogador6;
  String _nomeJogador7;
  String _nomeJogador8;
  String _nomeJogador9;
  String _nomeJogador10;
  String _apelidoJogador1;
  String _apelidoJogador2;
  String _apelidoJogador3;
  String _apelidoJogador4;
  String _apelidoJogador5;
  String _apelidoJogador6;
  String _apelidoJogador7;
  String _apelidoJogador8;
  String _apelidoJogador9;
  String _apelidoJogador10;
  String _emailJogador1;
  String _emailJogador2;
  String _emailJogador3;
  String _emailJogador4;
  String _emailJogador5;
  String _emailJogador6;
  String _emailJogador7;
  String _emailJogador8;
  String _emailJogador9;
  String _emailJogador10;

  JogoRedeModel(this._id, this._numero, this._pontuacao1, this._pontuacao2, this._data,
      this._idRede, this._idJogador1, this._idJogador2,
      this._idJogador3, this._idJogador4, this._idJogador5, this._idJogador6,
      this._idJogador7, this._idJogador8, this._idJogador9, this._idJogador10,
      this._nomeJogador1, this._nomeJogador2,
      this._nomeJogador3, this._nomeJogador4, this._nomeJogador5, this._nomeJogador6,
      this._nomeJogador7, this._nomeJogador8, this._nomeJogador9, this._nomeJogador10,
      this._apelidoJogador1, this._apelidoJogador2,
      this._apelidoJogador3, this._apelidoJogador4, this._apelidoJogador5, this._apelidoJogador6,
      this._apelidoJogador7, this._apelidoJogador8, this._apelidoJogador9, this._apelidoJogador10,
      this._emailJogador1, this._emailJogador2,
      this._emailJogador3, this._emailJogador4, this._emailJogador5, this._emailJogador6,
      this._emailJogador7, this._emailJogador8, this._emailJogador9, this._emailJogador10);

  JogoRedeModel.NovoJogo(this._idRede, this._pontuacao1, this._pontuacao2, this._emailJogador1, this._emailJogador2, this._emailJogador3, this._emailJogador4);
  JogoRedeModel.NovoPlacar(this._id, this._numero, this._pontuacao1, this._pontuacao2);
  JogoRedeModel.Remove(this._id);

  factory JogoRedeModel.fromJson(Map<String, dynamic> json) {
    return JogoRedeModel(
      json["id"],
      json["numero"],
      json["pontuacao1"],
      json["pontuacao2"],
      json["data"],
      json["idRede"],
      json["idJogador1"],
      json["idJogador2"],
      json["idJogador3"],
      json["idJogador4"],
      json["idJogador5"],
      json["idJogador6"],
      json["idJogador7"],
      json["idJogador8"],
      json["idJogador9"],
      json["idJogador10"],
      json["nomeJogador1"],
      json["nomeJogador2"],
      json["nomeJogador3"],
      json["nomeJogador4"],
      json["nomeJogador5"],
      json["nomeJogador6"],
      json["nomeJogador7"],
      json["nomeJogador8"],
      json["nomeJogador9"],
      json["nomeJogador10"],
      json["apelidoJogador1"],
      json["apelidoJogador2"],
      json["apelidoJogador3"],
      json["apelidoJogador4"],
      json["apelidoJogador5"],
      json["apelidoJogador6"],
      json["apelidoJogador7"],
      json["apelidoJogador8"],
      json["apelidoJogador9"],
      json["apelidoJogador10"],
      json["emailJogador1"],
      json["emailJogador2"],
      json["emailJogador3"],
      json["emailJogador4"],
      json["emailJogador5"],
      json["emailJogador6"],
      json["emailJogador7"],
      json["emailJogador8"],
      json["emailJogador9"],
      json["emailJogador10"],
    );
  }

  toJson() {
    return {
      'id': _id,
      'numero': _numero,
      'pontuacao1': _pontuacao1,
      'pontuacao2': _pontuacao2,
      'idRede': _idRede,
      'emailJogador1': _emailJogador1,
      'emailJogador2': _emailJogador2,
      'emailJogador3': _emailJogador3,
      'emailJogador4': _emailJogador4,
    };
  }

  String get apelidoFormatadoJogador1 {
    if (this.apelidoJogador1 == null) {
      return nomeJogador1;
    }else{
      return apelidoJogador1;
    }
  }

  String get apelidoFormatadoJogador2 {
    if (this.apelidoJogador2 == null) {
      return nomeJogador2;
    }else{
      return apelidoJogador2;
    }
  }

  String get apelidoFormatadoJogador3 {
    if (this.apelidoJogador3 == null) {
      return nomeJogador3;
    }else{
      return apelidoJogador3;
    }
  }

  String get apelidoFormatadoJogador4 {
    if (this.apelidoJogador4 == null) {
      return nomeJogador4;
    }else{
      return apelidoJogador4;
    }
  }

  String get apelidoJogador10 => _apelidoJogador10;

  set apelidoJogador10(String value) {
    _apelidoJogador10 = value;
  }

  String get apelidoJogador9 => _apelidoJogador9;

  set apelidoJogador9(String value) {
    _apelidoJogador9 = value;
  }

  String get apelidoJogador8 => _apelidoJogador8;

  set apelidoJogador8(String value) {
    _apelidoJogador8 = value;
  }

  String get apelidoJogador7 => _apelidoJogador7;

  set apelidoJogador7(String value) {
    _apelidoJogador7 = value;
  }

  String get apelidoJogador6 => _apelidoJogador6;

  set apelidoJogador6(String value) {
    _apelidoJogador6 = value;
  }

  String get apelidoJogador5 => _apelidoJogador5;

  set apelidoJogador5(String value) {
    _apelidoJogador5 = value;
  }

  String get apelidoJogador4 => _apelidoJogador4;

  set apelidoJogador4(String value) {
    _apelidoJogador4 = value;
  }

  String get apelidoJogador3 => _apelidoJogador3;

  set apelidoJogador3(String value) {
    _apelidoJogador3 = value;
  }

  String get apelidoJogador2 => _apelidoJogador2;

  set apelidoJogador2(String value) {
    _apelidoJogador2 = value;
  }

  String get apelidoJogador1 => _apelidoJogador1;

  set apelidoJogador1(String value) {
    _apelidoJogador1 = value;
  }

  String get nomeJogador10 => _nomeJogador10;

  set nomeJogador10(String value) {
    _nomeJogador10 = value;
  }

  String get nomeJogador9 => _nomeJogador9;

  set nomeJogador9(String value) {
    _nomeJogador9 = value;
  }

  String get nomeJogador8 => _nomeJogador8;

  set nomeJogador8(String value) {
    _nomeJogador8 = value;
  }

  String get nomeJogador7 => _nomeJogador7;

  set nomeJogador7(String value) {
    _nomeJogador7 = value;
  }

  String get nomeJogador6 => _nomeJogador6;

  set nomeJogador6(String value) {
    _nomeJogador6 = value;
  }

  String get nomeJogador5 => _nomeJogador5;

  set nomeJogador5(String value) {
    _nomeJogador5 = value;
  }

  String get nomeJogador4 => _nomeJogador4;

  set nomeJogador4(String value) {
    _nomeJogador4 = value;
  }

  String get nomeJogador3 => _nomeJogador3;

  set nomeJogador3(String value) {
    _nomeJogador3 = value;
  }

  String get nomeJogador2 => _nomeJogador2;

  set nomeJogador2(String value) {
    _nomeJogador2 = value;
  }

  String get nomeJogador1 => _nomeJogador1;

  set nomeJogador1(String value) {
    _nomeJogador1 = value;
  }

  int get idJogador10 => _idJogador10;

  set idJogador10(int value) {
    _idJogador10 = value;
  }

  int get idJogador9 => _idJogador9;

  set idJogador9(int value) {
    _idJogador9 = value;
  }

  int get idJogador8 => _idJogador8;

  set idJogador8(int value) {
    _idJogador8 = value;
  }

  int get idJogador7 => _idJogador7;

  set idJogador7(int value) {
    _idJogador7 = value;
  }

  int get idJogador6 => _idJogador6;

  set idJogador6(int value) {
    _idJogador6 = value;
  }

  int get idJogador5 => _idJogador5;

  set idJogador5(int value) {
    _idJogador5 = value;
  }

  int get idJogador4 => _idJogador4;

  set idJogador4(int value) {
    _idJogador4 = value;
  }

  int get idJogador3 => _idJogador3;

  set idJogador3(int value) {
    _idJogador3 = value;
  }

  int get idJogador2 => _idJogador2;

  set idJogador2(int value) {
    _idJogador2 = value;
  }

  int get idJogador1 => _idJogador1;

  set idJogador1(int value) {
    _idJogador1 = value;
  }

  int get idRede => _idRede;

  set idRede(int value) {
    _idRede = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  int get pontuacao2 => _pontuacao2;

  set pontuacao2(int value) {
    _pontuacao2 = value;
  }

  int get pontuacao1 => _pontuacao1;

  set pontuacao1(int value) {
    _pontuacao1 = value;
  }

  int get numero => _numero;

  set numero(int value) {
    _numero = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get emailJogador10 => _emailJogador10;

  set emailJogador10(String value) {
    _emailJogador10 = value;
  }

  String get emailJogador9 => _emailJogador9;

  set emailJogador9(String value) {
    _emailJogador9 = value;
  }

  String get emailJogador8 => _emailJogador8;

  set emailJogador8(String value) {
    _emailJogador8 = value;
  }

  String get emailJogador7 => _emailJogador7;

  set emailJogador7(String value) {
    _emailJogador7 = value;
  }

  String get emailJogador6 => _emailJogador6;

  set emailJogador6(String value) {
    _emailJogador6 = value;
  }

  String get emailJogador5 => _emailJogador5;

  set emailJogador5(String value) {
    _emailJogador5 = value;
  }

  String get emailJogador4 => _emailJogador4;

  set emailJogador4(String value) {
    _emailJogador4 = value;
  }

  String get emailJogador3 => _emailJogador3;

  set emailJogador3(String value) {
    _emailJogador3 = value;
  }

  String get emailJogador2 => _emailJogador2;

  set emailJogador2(String value) {
    _emailJogador2 = value;
  }

  String get emailJogador1 => _emailJogador1;

  set emailJogador1(String value) {
    _emailJogador1 = value;
  }

}