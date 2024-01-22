import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const MyTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey[850],
          filled: true,
          // Vérification si une erreur est retournée par le validateur pour utiliser la bordure d'erreur
          border: validator != null ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), // Utilisation de la bordure d'erreur
            borderRadius: BorderRadius.circular(10.0),
          ) : null,
        ),
        validator: validator, // Ajout du validateur
      ),
    );
  }
}
