import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:ace_app/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ACEDatabase extends ChangeNotifier {
  static late Isar isar;
  static late FirebaseFirestore firestore;

  // INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );

    // Initialize Firebase
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
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

  // SYNC DATA WITH FIRESTORE
  Future<void> syncDataWithFirestore() async {
    // Fetch all users from Isar
    await fetchUsers();

    // Get the reference to the Firestore collection
    CollectionReference usersCollection = firestore.collection('Users');

    // Add users from Isar to Firestore
    for (User user in aceList) {
      await usersCollection.add(user.toJson());
    }
  }
}
