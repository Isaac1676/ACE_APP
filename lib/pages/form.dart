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

  // login method
  void login() {}

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),

        // textes de présentation

          const Center(
            child: Text(
              "Bienvenue chez nous",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: Colors.white
              ),
            ),
          ),

          const Text(
            "ACE FAMILY",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 35,
              color: Colors.blue,
              fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 40,),

          // formulaire pour le nom
          MyTextField(
            hintText: "nom et prénom",
            controller: nameController,
            ),

          const SizedBox(height: 20,),

          // formulaire pour la classe
          MyTextField(
            hintText: "Classe",
            controller: classeController,
            ),

          const SizedBox(height: 20,),

          // formulaire pour le numéro
          MyTextField(
            hintText: "Numéro de téléphone",
            controller: numController,
            ),
          
          const SizedBox(height: 40,),

          // Button d'inscription
          MyButton(
            text: "S'inscrire", 
            onTap: login)
        ],
      )
    );
  }
}
