import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ace_app/components/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<QueryDocumentSnapshot> users;

  @override
  void initState() {
    super.initState();
    users = [];
  }

  void onSearch(String search) {
    // Ajouter la logique de recherche ici
  }

  void resetConfirmation() {
    // Ajouter la logique de réinitialisation de la confirmation ici
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "ACE PRESENCE",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.grey[850],
        actions: [
          IconButton(
              onPressed: resetConfirmation,
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 68,
                child: TextField(
                  onChanged: onSearch,
                  style:
                      const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[850],
                    contentPadding: const EdgeInsets.all(8),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintStyle:
                        TextStyle(fontSize: 15, color: Colors.grey.shade500),
                    hintText: "Search Users",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("Users").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
        
                    if (!snapshot.hasData) {
                      return const Text(
                        "Aucun utilisateur",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 15),
                      );
                    }
        
                    users = snapshot.data!.docs;
        
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return userComponent(userSnapshot: users[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userComponent({required QueryDocumentSnapshot userSnapshot}) {
    // Extraire les données du snapshot
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    print(userData);

    // Créer un objet User à partir des données
    User user = User.fromMap(userData);
    print(user);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${user.numtel}[${user.classe}]",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () async {

              if (user.isConfirmed) {
                // Ne rien faire si la confirmation est déjà effectuée
                return;
              }

              DateTime now = DateTime.now();

              // Ajouter l'utilisateur à la nouvelle collection
              await FirebaseFirestore.instance.collection("Presence").add({
                "name": user.name,
                "numtel": user.numtel,
                "classe": user.classe,
                // Ajoutez d'autres champs nécessaires
                "confirmationDate": now,
                "confirmed": true,
              });

              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userSnapshot.id)
                  .update({
                "isConfirmed": true,
              });

              // Mettre à jour la confirmation dans Firestore
              setState(() {
                user.isConfirmed = true;
              });

              print(userData);
            },
            child: AnimatedContainer(
              height: 35,
              width: 110,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: user.isConfirmed
                    ? Colors.blue[700]
                    : const Color(0x00ffffff),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: user.isConfirmed
                      ? Colors.transparent
                      : Colors.grey.shade700,
                ),
              ),
              child: Center(
                child: Text(
                  user.isConfirmed ? 'Confirmé' : 'Confirmer',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 12
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
