import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final bool isButtonConfirmed;
  final Function(bool) updateButtonState;

  const MyButton(
      {Key? key,
      required this.isButtonConfirmed,
      required this.updateButtonState})
      : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(isPressed ? Colors.grey : Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(10.0),
        ),
      ),
      onPressed: isPressed
          ? null
          : () {
              setState(() {
                isPressed = !isPressed;
                widget.updateButtonState(isPressed);
              });
            },
      child: const Text(
        "Confirmer",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
