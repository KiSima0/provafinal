class Atividade {
  int? id;
  String titulo;
  String descricao;
  String dataEntrega;
  int disciplinaId;

  Atividade({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataEntrega,
    required this.disciplinaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataEntrega': dataEntrega,
      'disciplinaId': disciplinaId,
    };
  }

  factory Atividade.fromMap(Map<String, dynamic> map) {
    return Atividade(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      dataEntrega: map['dataEntrega'],
      disciplinaId: map['disciplinaId'],
    );
  }
}