class User {
  final String name;
  final String numtel;
  final String classe;
  bool isConfirmed;

  User({
    required this.name,
    required this.numtel,
    required this.classe,
    this.isConfirmed = false, // Mettez la valeur par défaut à false
    // Ajoutez d'autres champs nécessaires
  });

  // Ajoutez cette méthode pour créer une instance de User à partir d'une Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      numtel: map['numtel'],
      classe: map['classe'],
    );
  }
}
