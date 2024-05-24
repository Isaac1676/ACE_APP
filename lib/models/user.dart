import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  String name;
  String email;
  String apart;
  String inviteur;
  String numtel;

  User({required this.name, required this.email, required this.numtel, required this.apart, required this.inviteur});

  Map<String, dynamic> toJson() {
    return {
      'Nom': name,
      'Email': email,
      'Apart': apart,
      'inviteur': inviteur,
      'numtel': numtel,
    };
  }
}