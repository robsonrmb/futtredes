class PatrocinadorModel {
  int id;
  String nome;
  String website;

  PatrocinadorModel({this.id, this.nome, this.website});

  factory PatrocinadorModel.fromJson(Map<String, dynamic> json) {
    return PatrocinadorModel(
      id: json["id"],
      nome: json["nome"],
      website: json["website"],
    );
  }
}