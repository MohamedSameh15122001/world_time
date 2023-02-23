class Model {
  final int id;
  final String name;

  Model({required this.id, required this.name});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(id: json['id'], name: json['name']);
  }
}
