class EstadosModel {
  String codigo;
  String texto;

  EstadosModel({this.codigo,this.texto});

  factory EstadosModel.fromJson(Map<String, dynamic> json) {
    return EstadosModel(
      codigo: json["codigo"],
      texto: json["texto"],
    );
  }

}