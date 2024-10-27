// ignore_for_file: unrelated_type_equality_checks

import 'package:ace_app/database/ace_database.dart';
import 'package:ace_app/models/user.dart';// Assurez-vous que le chemin est correct
import 'package:ace_app/components/list_tile.dart';
import 'package:ace_app/components/text_field.dart';
import 'package:ace_app/pages/form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  List<User> currentUsers = []; // Liste pour stocker les utilisateurs

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Charger les utilisateurs au démarrage
  }

  void fetchUsers() async {
    currentUsers = await DatabaseService.instance
        .getAllUsers(); // Appeler la méthode getAllUsers
    setState(() {}); // Mettre à jour l'état pour rafraîchir l'UI
  }

  void performSearch(String searchTerm) async {
    if (searchTerm.isEmpty) {
      fetchUsers(); // Recharger tous les utilisateurs
    } else {
      currentUsers = await DatabaseService.instance
          .searchUserByName(searchTerm); // Rechercher par nom
      setState(() {}); // Mettre à jour l'état
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la hauteur et la largeur de l'écran
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.church_sharp, color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async {
                // Rafraîchir les confirmations
                await DatabaseService.instance.resetUserConfirmations();
                fetchUsers(); // Recharger les utilisateurs après la réinitialisation
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ))
        ],
        title: Text(
          "A C C U E I L",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: screenWidth * 0.055,
            color: Colors.white,
          ),
        ),
        toolbarHeight: screenHeight * 0.08,
        backgroundColor: Colors.grey[850],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormPage()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.person_add_alt_rounded),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),

          // Champ de texte
          Textfield(controller: searchController, onChanged: performSearch),

          // Liste des utilisateurs
          Expanded(
              child: ListView.builder(
                  itemCount: currentUsers.length,
                  itemBuilder: (context, index) {
                    final user = currentUsers[index];

                    return MyListile(
                      title: user.name,
                      subtitle: "${user.promotion} | ${user.classe}",
                      isConfirmed: user.isConfirm, // Vérifier si la présence est confirmée
                      onPressed: () async {
                        // Mettre à jour la confirmation
                        bool isConfirmed = true;
                        await DatabaseService.instance.confirmUserPresence(
                            user.id!, !isConfirmed); // Inverser l'état
                        fetchUsers(); // Recharger les utilisateurs pour mettre à jour l'affichage
                      },
                    );
                  })),
        ],
      )),
    );
  }
}