import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int) onIndexChanged;
  final int currentIndex;

  const BottomNavigation({
    super.key, // Ajouter une clé facultative
    required this.onIndexChanged,
    required this.currentIndex,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Angle arrondi en haut à gauche
          topRight: Radius.circular(20.0), // Angle arrondi en haut à droite
        ),
        border: Border(
          top: BorderSide(
            color: Colors.white, // Couleur de la bordure blanche
            width: 1.0, // Largeur de la bordure
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.grey.shade900,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontFamily: "Poppins",
        ),
        currentIndex: widget.currentIndex,
        onTap: widget.onIndexChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: "Presence",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: "Nouvelle personne",
          ),
        ],
      ),
    );
  }
}
