import 'package:flutter/material.dart';

class ValidationDialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onValidCode;
  final VoidCallback onCancel;
  final String correctCode; // Code de validation à vérifier

  const ValidationDialogBox({
    super.key,
    required this.controller,
    required this.onValidCode,
    required this.onCancel,
    required this.correctCode,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      backgroundColor: Colors.grey[900],
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[850],
                hintText: "Saisir le code à 5 chiffres",
                counterText: '',
                hintStyle: TextStyle(
                    fontSize: screenWidth * 0.040, color: Colors.grey.shade500),
              ),
            ),
            SizedBox(height: screenHeight * 0.035),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Vérification du code
                    if (controller.text == correctCode) {
                      onValidCode();
                    } else {
                      // Code incorrect
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Code incorrect !'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  ),
                  child: Text(
                    'Valider',
                    style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
                ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  ),
                  child: Text(
                    'Annuler',
                    style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
