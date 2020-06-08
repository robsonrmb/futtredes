class RespostaModel {
  String _resposta;

  RespostaModel(this._resposta);

  factory RespostaModel.fromJson(Map<String, dynamic> json) {
    return RespostaModel(
      json["resposta"],
    );
  }

  String get resposta => _resposta;

  set resposta(String value) {
    _resposta = value;
  }

}