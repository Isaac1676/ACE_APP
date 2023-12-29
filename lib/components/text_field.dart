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
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          errorBorder: OutlineInputBorder( // Bordure en cas d'erreur
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          // Vérification si une erreur est retournée par le validateur pour utiliser la bordure d'erreur
          border: validator != null ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), // Utilisation de la bordure d'erreur
            borderRadius: BorderRadius.circular(8.0),
          ) : null,
        ),
        validator: validator, // Ajout du validateur
      ),
    );
  }
}
