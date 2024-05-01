import 'package:isar/isar.dart';

part 'confirmation.g.dart';

@Collection()
class Confirmation {
  Id id = Isar.autoIncrement;
  String name;
  DateTime date;

  Confirmation({required this.name, required this.date});
}