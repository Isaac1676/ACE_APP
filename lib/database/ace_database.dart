import 'package:ace_app/models/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ace_app/models/user.dart';
import 'package:path_provider/path_provider.dart';

class ACEDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserSchema, ConfirmationSchema],
      directory: dir.path,
    );
  }

  // list of child
  final List<User> aceList = [];

  // CREATE - ADD A CHILD
  Future<void> addNewUser(User user) async {
    await isar.writeTxn(() => isar.users.put(user));

    await fetchUsers();
  }

  // READ - SEE MY CHILD
  Future<void> fetchUsers() async {
    List<User> fetchedUsers = await isar.users.where().findAll();
    aceList.clear();
    aceList.addAll(fetchedUsers);
    notifyListeners();
  }

  // SEARCH - SEARCH BIRTHDAYS BY NAME
  Future<void> searchByName(String searchTerm) async {
    final searchResults =
        await isar.users.where().filter().nameContains(searchTerm).findAll();
    aceList.clear();
    aceList.addAll(searchResults);
    notifyListeners();
  }

  // UPDATE - UPDATE STATE BY NAME
  void updateConfirm(int index, bool newValue) {
    final user = aceList[index];
    user.isConfirm = newValue;

    Confirmation confirmation =
        Confirmation(name: user.name, date: DateTime.now());

    isar.writeTxn(() async {
      await isar.users.put(user);
    });

    isar.writeTxn(() async {
      await isar.confirmations.put(confirmation);
    });
    notifyListeners();
  }

  //REFRESH - Resfresh confirmation
  void refreshConfirm() {
    isar.writeTxn(() async {
      for (var user in aceList) {
        user.isConfirm = false;
        await isar.users.put(user);
      }
    });
    notifyListeners();
  }
}
