import 'package:ace_app/components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ace_app/components/text_field.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final classeController = TextEditingController();
  final numController = TextEditingController();
  final promotionController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

  // login method
  void login() {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text;
      String classe = classeController.text.toUpperCase();
      String numtel = numController.text;
      String promotion = promotionController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Utilisateur ajouté',
            style: TextStyle(fontFamily: "Poppins"),
          ),
          duration: Duration(seconds: 2), // Durée d'affichage de la SnackBar
        ),
      );

      // Ajout de la base de données
      CollectionReference usersRefs =
          FirebaseFirestore.instance.collection("Users");
      usersRefs.add({
        'name': name,
        'classe': classe,
        'numtel': numtel,
        'promotion': promotion,
        'isConfirmed': false
      });

      nameController.clear();
      classeController.clear();
      numController.clear();
      promotionController.clear();
    }
  }

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
        child: Form(
          key: _formKey, // Assign the GlobalKey to the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Textes de présentation
              const Center(
                child: Text(
                  "Bienvenue chez nous",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                "ACE FAMILY",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 35,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              // Formulaire pour le nom
              MyTextField(
                hintText: "Nom et prénom",
                controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),

              // Formulaire pour la classe
              MyTextField(
                hintText: "Classe",
                controller: classeController,
              ),
              const SizedBox(
                height: 20,
              ),

              PromotionField(
                hintText: "Promotion (IT1-IT12)",
                selectedPromotion: promotionController.text,
                onChanged: (value) {
                  promotionController.text = value;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              // Formulaire pour le numéro
              MyPhoneNumberField(
                hintText: "Numéro de téléphone",
                controller: numController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),

              // Bouton d'inscription
              MyButton(
                text: "S'inscrire",
                onTap: login,
              )
            ],
          ),
        ),
      ),
    );
  }
}
