class User {
  final String name;
  final String numtel;
  final String classe;
  bool isConfirmed;

  User({
    required this.name,
    required this.numtel,
    required this.classe,
    required this.isConfirmed
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      numtel: map['numtel'],
      classe: map['classe'],
      isConfirmed: map['isConfirmed']
    );
  }
}
