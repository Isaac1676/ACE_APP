import 'package:flutter/material.dart';
import 'package:ace_app/components/text_field.dart';
import 'package:ace_app/components/phone.dart';

class User {
  String nom;
  String classe;
  String num;

  User({required this.nom, required this.classe, required this.num});
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final classeController = TextEditingController();
  final numController = TextEditingController();

  List<User> userList = [];

  final _formKey = GlobalKey<FormState>(); // Clé globale pour le formulaire

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "FORMULAIRE",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey, // Utilisation de la clé pour le formulaire
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bienvenue chez nous",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ACE FAMILY",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.blue,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                MyTextfield(
                  controller: nameController,
                  hintText: "Nom et prénoms",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom et prénom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                MyTextfield(
                  controller: classeController,
                  hintText: "Classe",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre classe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                PhoneNumberField(
                  controller: numController,
                  hintText: "Numéro de téléphone",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre numéro de téléphone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Si la validation est réussie, procédez à l'inscription
                      String name = nameController.text;
                      String classe = classeController.text;
                      String phoneNumber = numController.text;

                      User newUser = User(nom: name, classe: classe, num: phoneNumber);

                      setState(() {
                        userList.add(newUser);
                      });

                      nameController.clear();
                      classeController.clear();
                      numController.clear();

                      for (var user in userList) {
                        print('Nom : ${user.nom}, Classe : ${user.classe}, Numéro : ${user.num}');
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Utilisateur ajouté', style: TextStyle(fontFamily: "Poppins"),),
          duration: Duration(seconds: 5), // Durée d'affichage de la SnackBar
        ),
      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
