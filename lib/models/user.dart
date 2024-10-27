class User {
  final int? id;
  final String name;
  final String classe;
  final String promotion;
  final String numtel;
  bool isConfirm;

  User({
    this.id,
    required this.name,
    required this.classe,
    required this.promotion,
    required this.numtel,
    this.isConfirm = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'classe': classe,
      'promotion': promotion,
      'numtel': numtel,
      'isConfirm': isConfirm == true ? 1 : 0, // SQLite uses 1 for true and 0 for false
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      classe: map['classe'],
      promotion: map['promotion'],
      numtel: map['numtel'],
      isConfirm: map['isConfirm'] == 1,
    );
  }
}