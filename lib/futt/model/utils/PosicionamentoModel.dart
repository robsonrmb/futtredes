class PosicionamentoModel {

  String? _id;
  String? _nome;

  PosicionamentoModel(this._id, this._nome);

  factory PosicionamentoModel.fromJson(Map<String, dynamic> json) {
    return PosicionamentoModel(
      json["id"],
      json["nome"],
    );
  }

  @override
  String toString() => _nome!;

  @override
  operator ==(o) => o is PosicionamentoModel && o.id == id;

  @override
  int get hashCode => id.hashCode^nome.hashCode;

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }


}