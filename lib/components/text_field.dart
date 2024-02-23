import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator = _defaultValidator,
  });

  static String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ ne doit pas être vide';
    }
    return null; // Value is not empty
  }

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
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
        validator: validator, // Use the specified or default validator
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
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
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
          border: validator != null ? OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red), // Error border
            borderRadius: BorderRadius.circular(10.0),
          ) : null,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          prefixText: "+225 ", // Prepend country code with space
          prefixStyle: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        // Regex validation for 10 digits
        validator: (value) => _validatePhoneNumber(value),
      ),
    );
  }

  // Custom validation function for 10 digits
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final regex = RegExp(r"^\d{10}$"); // Ensure 10 digits
    if (!regex.hasMatch(value)) {
      return 'Numéro Invalide';
    }
    return null;
  }
}


class PromotionField extends StatefulWidget {
  final String hintText;
  final String selectedPromotion;
  final void Function(String) onChanged;

  const PromotionField({
    Key? key,
    required this.hintText,
    required this.selectedPromotion,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PromotionFieldState createState() => _PromotionFieldState();
}

class _PromotionFieldState extends State<PromotionField> {
  final List<String> itemList = List.generate(12, (index) => 'IT${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                fontSize: 15,
                color: Colors.grey.shade500,
                fontFamily: "Poppins",
              )),
          isExpanded: true,
          elevation: 0,
          dropdownColor: Colors.grey[850],
          icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
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
          validator: (value) {
            if (value == null) {
              return "Veuillez choisir votre promotion"; // Clear and concise error message
            }
            return null; // Value is valid
          },
        ),
      ),
    );
  }
}
