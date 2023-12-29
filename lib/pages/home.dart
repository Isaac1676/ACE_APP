import 'package:flutter/material.dart';
import 'package:ace_app/components/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isButton = false;

  void updateButton(bool newState) {
    setState(() {
      isButton = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ACE PRESENCE",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (String value) {
              if (value == 'reset') {
                // Action on reset
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'reset',
                child: Text(
                  'Réinitialiser',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15.0),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Entrez votre nom",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                contentPadding: EdgeInsets.all(15.0),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              if (index.isOdd) {
                return const Divider(
                    height: 1, color: Color.fromARGB(255, 161, 209, 248)); // Séparateur constant
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: const Center(child: Text("Nom et prénom")),
                  subtitle:
                      const Center(child: Text("Numéro de téléphone - Classe")),
                  trailing: MyButton(
                      isButtonConfirmed: isButton,
                      updateButtonState: updateButton),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
