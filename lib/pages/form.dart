import 'package:ace_app/components/button.dart';
import 'package:ace_app/database/ace_database.dart';
import 'package:ace_app/models/user.dart';
import 'package:ace_app/pages/home.dart';
import 'package:ace_app/components/text_field.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final classeController = TextEditingController();
  final numController = TextEditingController();
  final promotionController = TextEditingController();

  // Méthode d'ajout d'utilisateur
  void addUser() async {
    if (nameController.text.isNotEmpty &&
        numController.text.isNotEmpty &&
        promotionController.text.isNotEmpty && 
        classeController.text.isNotEmpty) {
      try {
        User newUser = User(
            name: nameController.text,
            promotion: promotionController.text,
            numtel: numController.text,
            classe: classeController.text,
            isConfirm: false);

        // Ajout de l'utilisateur directement via DatabaseService
        await DatabaseService.instance.insertUser(newUser);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Utilisateur Ajouté",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            duration: Duration(seconds: 2), // Durée d'affichage de la SnackBar
          ),
        );

        // Réinitialiser les champs
        nameController.clear();
        classeController.clear();
        numController.clear();
        promotionController.clear();

        // Naviguer vers la page d'accueil
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Erreur : $e",
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2), // Durée d'affichage de la SnackBar
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez remplir tous les champs ci-dessus",
            style: TextStyle(
              fontFamily: "Poppins",
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
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        elevation: 0,
        title: Text(
          "F O R M U L A I R E",
          style: TextStyle(
            fontFamily: "Poppins",
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
              height: screenHeight * 0.05,
            ),

            // Textes de présentation
            Center(
              child: Text(
                "Bienvenue chez nous",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: screenWidth * 0.065,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "ACE FAMILY",
              style: TextStyle(
                fontFamily: "Poppins",
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
              height: screenHeight * 0.045,
            ),

            // Formulaire pour la classe
            MyTextField(
              hintText: "Classe",
              controller: classeController,
              isClasse: true,
            ),
            SizedBox(
              height: screenHeight * 0.045,
            ),

            PromotionField(
              hintText: "Promotion (IT1-IT12)",
              selectedPromotion: promotionController.text,
              onChanged: (value) {
                promotionController.text = value;
              },
            ),

            SizedBox(
              height: screenHeight * 0.045,
            ),

            // Formulaire pour le numéro
            MyPhoneNumberField(
              hintText: "Numéro de téléphone",
              controller: numController,
            ),
            SizedBox(
              height: screenHeight * 0.055,
            ),

            // Bouton d'inscription
            MyButton(
              text: "S'enregistrer",
              onTap: addUser,
              isBlue: true,
            )
          ],
        ),
      ),
    );
  }
}