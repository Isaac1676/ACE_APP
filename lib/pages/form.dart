import 'package:ace_app/components/button.dart';
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
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

  // login method
  void login() {
    if (_formKey.currentState!.validate()) {
      // Only proceed if the form is valid
      // Implement your login logic here
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
              const SizedBox(height: 40,),

              // Formulaire pour le nom
              MyTextField(
                hintText: "Nom et prénom",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom et prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),

              // Formulaire pour la classe
              MyTextField(
                hintText: "Classe",
                controller: classeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre classe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),

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
              const SizedBox(height: 40,),

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
