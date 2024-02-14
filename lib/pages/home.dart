import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ace_app/components/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late List<QueryDocumentSnapshot?> users;
  late List<QueryDocumentSnapshot?> filteredUsers;

  @override
  void initState() {
    super.initState();
    users = [];
    filteredUsers = [];
  }

void onSearch(String search) {
  String searchLower = search.toLowerCase();

  if (search.isEmpty) {
    setState(() {
      filteredUsers = List.from(users);
    });
    return;
  }

  FirebaseFirestore.instance
      .collection("Users")
      .where("name", isGreaterThanOrEqualTo: searchLower)
      .where("name", isLessThan: '${searchLower}z')
      .snapshots()
      .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
    setState(() {
      // Extraire les données de chaque document Firestore et les convertir en objets User
      users = snapshot.docs
          .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>)).cast<QueryDocumentSnapshot<Object?>?>()
          .toList();
      filteredUsers = List.from(users);
    });
  });
}



  void resetConfirmation() async {
    for (var userSnapshot in users) {
      if (userSnapshot != null) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        if (userData["isConfirmed"]) {
          setState(() {
            userData["isConfirmed"] = false;
          });

          await FirebaseFirestore.instance
              .collection("Users")
              .doc(userSnapshot.id)
              .update({"isConfirmed": false});
        }
      }
    }
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
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "Poppins"),
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
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          strokeWidth: 3,
                        ),
                      );
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
                    filteredUsers = List.from(users);
                    print(filteredUsers);

                    return ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return userComponent(userSnapshot: filteredUsers[index]);
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

  Widget userComponent({required QueryDocumentSnapshot? userSnapshot}) {
    if (userSnapshot == null) {
      return const SizedBox(); // Rien à afficher si le snapshot est nul
    }

    Map<String, dynamic> userData =
        userSnapshot.data() as Map<String, dynamic>;

    User user = User.fromMap(userData);

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
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${user.numtel} [${user.classe}]",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: "Poppins"),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () async {
              if (user.isConfirmed) {
                return;
              }

              DateTime now = DateTime.now();
              String collectionName =
                  "${now.year}-${now.month}-${now.day}_confirmations";

              await FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc()
                  .set({
                "name": user.name,
                "numtel": user.numtel,
                "classe": user.classe,
                "confirmationDate": now,
                "isConfirmed": true,
              });

              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userSnapshot.id)
                  .update({
                "isConfirmed": true,
              });

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
                      color: Colors.white, fontFamily: "Poppins", fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
