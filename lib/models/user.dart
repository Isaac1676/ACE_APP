import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  String name;
  String classe;
  String promotion;
  String numtel;
  bool isConfirm;

  User({required this.name, required this.classe, required this.promotion, required this.numtel, this.isConfirm = false});
}