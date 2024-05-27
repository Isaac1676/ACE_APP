import 'package:flutter/material.dart';

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
        style: const TextStyle(color: Color(0xFFcc4e5c), fontFamily: "Gramatika"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFeec4c9)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFcc4e5c)),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: screenWidth * 0.04, color: Colors.black45),
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
        style: const TextStyle(color: Color(0xFFcc4e5c), fontFamily: "Gramatika"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFeec4c9)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFcc4e5c)),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: screenWidth * 0.04, color: Colors.black45),
        ),
      ),
    );
  }
}

class AppartField extends StatefulWidget {
  final String hintText;
  final String selectedAppart;
  final void Function(String) onChanged;

  const AppartField({
    super.key, // Ajout de "Key key" pour éviter une erreur
    required this.hintText,
    required this.selectedAppart,
    required this.onChanged,
  }); // Utilisation de "super(key: key)"

  @override
  _AppartFieldState createState() => _AppartFieldState();
}

class _AppartFieldState extends State<AppartField> {
  final List<String> itemList = [
    'Hors ESATIC',
    'ACE',
    'CCEE',
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
          value: itemList.contains(widget.selectedAppart)
              ? widget.selectedAppart
              : null,
          items: itemList.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Color(0xffcc4e5c))),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              widget.onChanged(value);
            }
          },
          hint: Text(widget.hintText,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.black45,
                fontFamily: "Gramatika",
              )),
          isExpanded: true,
          elevation: 0,
          dropdownColor: Color(0xffeee9da),
          icon: const Icon(Icons.keyboard_arrow_down_outlined,
              color: Colors.black45),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFeec4c9)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffcc4e5c)),
              borderRadius: BorderRadius.circular(10),
            ),
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
          style: const TextStyle(color: Colors.white, fontFamily: "Gramatika"),
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
