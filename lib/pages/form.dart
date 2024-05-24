import 'package:ace_app/components/button.dart';
import 'package:ace_app/database/ace_database.dart';
import 'package:ace_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:ace_app/components/text_field.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numController = TextEditingController();
  final appartController = TextEditingController();
  final invitController = TextEditingController();

  // login method
  void login() async {
    if (nameController.text.isNotEmpty &&
        numController.text.isNotEmpty &&
        appartController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        invitController.text.isNotEmpty) {
      try {
        if (emailController.text.contains("@")) {
          User newUser = User(
              name: nameController.text,
              apart: appartController.text,
              numtel: numController.text,
              email: emailController.text,
              inviteur: invitController.text);

          await context.read<ACEDatabase>().addNewUser(newUser);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Utilisateur Ajouté",
                style: TextStyle(
                  fontFamily: "Gramatika",
                ),
              ),
              duration:
                  Duration(seconds: 2), // Durée d'affichage de la SnackBar
            ),
          );

          nameController.clear();
          emailController.clear();
          invitController.clear();
          numController.clear();
          appartController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Email incorrect",
                style: TextStyle(
                  fontFamily: "Gramatika",
                ),
              ),
              backgroundColor: Colors.red,
              duration:
                  Duration(seconds: 2), // Durée d'affichage de la SnackBar
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Erreur : $e",
              style: const TextStyle(
                fontFamily: "Gramatika",
              ),
            ),
            backgroundColor: Colors.red,
            duration:
                const Duration(seconds: 2), // Durée d'affichage de la SnackBar
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez remplir tous les champs ci-dessus",
            style: TextStyle(
              fontFamily: "Gramatika",
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2), // Durée d'affichage de la SnackBar
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Provider.of<ACEDatabase>(context, listen: false).syncDataWithFirestore(),
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ))
        ],
        elevation: 0,
        title: Text(
          "F O R M U L A I R E",
          style: TextStyle(
            fontFamily: "Gramatika",
            fontSize: screenWidth * 0.055,
            color: Colors.white,
          ),
        ),
        toolbarHeight: screenHeight * 0.08,
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),

            // Textes de présentation
            Center(
              child: Text(
                "Bienvenue chez nous",
                style: TextStyle(
                  fontFamily: "Gramatika",
                  fontSize: screenWidth * 0.065,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "ACE FAMILY",
              style: TextStyle(
                fontFamily: "Gramatika",
                fontSize: screenWidth * 0.1,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),

            // Formulaire pour le nom
            MyTextField(
              hintText: "Nom et prénom",
              controller: nameController,
              isClasse: false,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),

            MyTextField(
              hintText: "Email",
              controller: emailController,
              isClasse: false,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),

            // Formulaire pour le numéro
            MyPhoneNumberField(
              hintText: "Numéro de téléphone",
              controller: numController,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),

            AppartField(
              hintText: "Appartenance",
              selectedAppart: appartController.text,
              onChanged: (value) {
                appartController.text = value;
              },
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),

            MyTextField(
              hintText: "Inviteur",
              controller: invitController,
              isClasse: false,
            ),

            SizedBox(
              height: screenHeight * 0.05,
            ),
            // Bouton d'inscription
            MyButton(
              text: "S'enregister",
              onTap: login,
            )
          ],
        ),
      ),
    );
  }
}
