import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[850],
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
          
      ),
    );
  }
}

class MyPhoneNumberField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyPhoneNumberField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone, // Utilisez TextInputType.phone pour un clavier numérique
        style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[850],
          border: validator != null ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), // Utilisation de la bordure d'erreur
            borderRadius: BorderRadius.circular(10.0),
          ) : null,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}


class PromotionField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PromotionField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ], // Utilisez TextInputType.phone pour un clavier numérique
        style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[850],
          border: validator != null ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), // Utilisation de la bordure d'erreur
            borderRadius: BorderRadius.circular(10.0),
          ) : null,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
