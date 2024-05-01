import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isClasse;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isClasse
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    TextCapitalization textCapital() {
      if (isClasse) {
        return TextCapitalization.characters;
      } else {
        return TextCapitalization.none;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: TextField(
        controller: controller,
        textCapitalization: textCapital(),
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
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[850],
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: screenWidth * 0.035, color: Colors.grey.shade500),
        ), // Use the specified or default validator
      ),
    );
  }
}

class MyPhoneNumberField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MyPhoneNumberField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
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
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: screenWidth * 0.035, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}

class PromotionField extends StatefulWidget {
  final String hintText;
  final String selectedPromotion;
  final void Function(String) onChanged;

  const PromotionField({
    super.key, // Ajout de "Key key" pour éviter une erreur
    required this.hintText,
    required this.selectedPromotion,
    required this.onChanged,
  }); // Utilisation de "super(key: key)"

  @override
  _PromotionFieldState createState() => _PromotionFieldState();
}

class _PromotionFieldState extends State<PromotionField> {
  final List<String> itemList = [
    'Hors ESATIC',
    ...List.generate(12, (index) => 'IT${index + 1}')
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
      ),
      child: SingleChildScrollView(
        child: DropdownButtonFormField<String>(
          value: itemList.contains(widget.selectedPromotion)
              ? widget.selectedPromotion
              : null,
          items: itemList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              widget.onChanged(value);
            }
          },
          hint: Text(widget.hintText,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.grey.shade500,
                fontFamily: "Poppins",
              )),
          isExpanded: true,
          elevation: 0,
          dropdownColor: Colors.grey[850],
          icon: const Icon(Icons.keyboard_arrow_down_outlined,
              color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[850],
          ),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const Textfield({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
      ),
      child: SizedBox(
        height: screenHeight * 0.07,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[850],
            contentPadding: EdgeInsets.all(screenWidth * 0.02),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(
                fontSize: screenWidth * 0.035, color: Colors.grey.shade500),
            hintText: "Rechercher votre nom",
          ),
        ),
      ),
    );
  }
}
